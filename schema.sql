-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- Drop existing tables (if any) to avoid conflicts
DROP TABLE IF EXISTS Prescriptions;
DROP TABLE IF EXISTS Treatments;
DROP TABLE IF EXISTS Diagnoses;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS MedicalHistories;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Medications;

-- Create Patients Table
-- Stores information about patients
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each patient
    name VARCHAR(100) NOT NULL,                -- Full name of the patient
    date_of_birth DATE NOT NULL,               -- Patient's date of birth
    gender ENUM('Male', 'Female', 'Other') NOT NULL, -- Patient's gender
    contact_number VARCHAR(15),                -- Contact number for the patient
    email VARCHAR(100)                         -- Email address for the patient
);

-- Create Doctors Table
-- Stores information about healthcare providers
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each doctor
    name VARCHAR(100) NOT NULL,               -- Full name of the doctor
    specialization VARCHAR(100),              -- Area of expertise (e.g., cardiology)
    contact_number VARCHAR(15)                -- Contact number for the doctor
);

-- Create MedicalHistories Table
-- Stores medical history records for patients
CREATE TABLE MedicalHistories (
    history_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each medical history record
    patient_id INT,                           -- Links to the patient
    medical_condition  VARCHAR(255) NOT NULL,          -- Description of the medical condition
    diagnosis_date DATE,                      -- Date the condition was diagnosed
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE
);

-- Create Appointments Table
-- Manages appointments between patients and doctors or healthcare providers
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each appointment
    patient_id INT,                               -- Links to the patient
    doctor_id INT,                                -- Links to the doctor
    appointment_date DATETIME NOT NULL,           -- Date and time of the appointment
    purpose TEXT,                                 -- Reason for the appointment
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

-- Create Diagnoses Table
-- Stores diagnoses made by doctors
CREATE TABLE Diagnoses (
    diagnosis_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each diagnosis
    patient_id INT,                             -- Links to the patient
    doctor_id INT,                              -- Links to the doctor
    symptoms TEXT,                              -- Description of symptoms
    diagnosis_date DATE,                        -- Date of diagnosis
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

-- Create Treatments Table
-- Stores treatments prescribed for diagnoses
CREATE TABLE Treatments (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each treatment
    diagnosis_id INT,                           -- Links to the diagnosis
    treatment_description TEXT,                 -- Description of the treatment
    FOREIGN KEY (diagnosis_id) REFERENCES Diagnoses(diagnosis_id) ON DELETE CASCADE
);

-- Create Medications Table
-- Stores information about available medications
CREATE TABLE Medications (
    medication_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each medication
    name VARCHAR(100) NOT NULL,                  -- Name of the medication
    dosage_form VARCHAR(50),                     -- Form of the medication (e.g., tablet, injection)
    manufacturer VARCHAR(100)                    -- Name of the manufacturer
);

-- Create Prescriptions Table
-- Stores prescriptions for treatments
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each prescription
    treatment_id INT,                              -- Links to the treatment
    medication_id INT,                             -- Links to the medication
    dosage VARCHAR(50),                            -- Dosage instructions
    duration VARCHAR(50),                          -- Duration of the prescription
    FOREIGN KEY (treatment_id) REFERENCES Treatments(treatment_id) ON DELETE CASCADE,
    FOREIGN KEY (medication_id) REFERENCES Medications(medication_id) ON DELETE CASCADE
);

-- Create Indexes
-- Indexes are created to optimize query performance on frequently searched columns

-- Index on patient_id in MedicalHistories
CREATE INDEX idx_medical_histories_patient_id ON MedicalHistories(patient_id);

-- Index on patient_id in Appointments
CREATE INDEX idx_appointments_patient_id ON Appointments(patient_id);

-- Index on doctor_id in Appointments
CREATE INDEX idx_appointments_doctor_id ON Appointments(doctor_id);

-- Index on patient_id in Diagnoses
CREATE INDEX idx_diagnoses_patient_id ON Diagnoses(patient_id);

-- Index on doctor_id in Diagnoses
CREATE INDEX idx_diagnoses_doctor_id ON Diagnoses(doctor_id);

-- Index on diagnosis_id in Treatments
CREATE INDEX idx_treatments_diagnosis_id ON Treatments(diagnosis_id);

-- Index on treatment_id in Prescriptions
CREATE INDEX idx_prescriptions_treatment_id ON Prescriptions(treatment_id);

-- Index on medication_id in Prescriptions
CREATE INDEX idx_prescriptions_medication_id ON Prescriptions(medication_id);

-- Create Views
-- Views are created to simplify complex queries and provide easy access to commonly needed data

-- View: PatientSummary
-- Displays a summary of a patient's medical history, diagnoses, and treatments
CREATE VIEW PatientSummary AS
SELECT
    p.patient_id,
    p.name AS patient_name,
    mh.medical_condition,
    mh.diagnosis_date AS medical_diagnosis_date,
    d.symptoms,
    d.diagnosis_date AS doctor_diagnosis_date,
    t.treatment_description
FROM Patients p
LEFT JOIN MedicalHistories mh ON p.patient_id = mh.patient_id
LEFT JOIN Diagnoses d ON p.patient_id = d.patient_id
LEFT JOIN Treatments t ON d.diagnosis_id = t.diagnosis_id;

-- View: DoctorSchedule
-- Displays a doctor's upcoming appointments
CREATE VIEW DoctorSchedule AS
SELECT
    d.doctor_id,
    d.name AS doctor_name,
    a.appointment_date,
    p.name AS patient_name,
    a.purpose
FROM Doctors d
JOIN Appointments a ON d.doctor_id = a.doctor_id
JOIN Patients p ON a.patient_id = p.patient_id
ORDER BY a.appointment_date;
