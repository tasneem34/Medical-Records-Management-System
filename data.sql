-- Insert sample patients
INSERT INTO Patients (name, date_of_birth, gender, contact_number, email)
VALUES
('John Doe', '1985-06-15', 'Male', '1234567890', 'johndoe@example.com'),
('Jane Smith', '1990-08-22', 'Female', '0987654321', 'janesmith@example.com'),
('Alice Brown', '1978-12-05', 'Female', '1122334455', 'alicebrown@example.com');

-- Insert sample doctors
INSERT INTO Doctors (name, specialization, contact_number)
VALUES
('Dr. Emily Johnson', 'Cardiology', '5551234567'),
('Dr. Mark Wilson', 'Dermatology', '5559876543');

-- Insert sample medical histories
INSERT INTO MedicalHistories (patient_id, medical_condition, diagnosis_date)
VALUES
(1, 'Hypertension', '2022-01-10'),
(2, 'Asthma', '2021-05-20');

-- Insert sample appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, purpose)
VALUES
(1, 1, '2024-08-10 10:00:00', 'Routine checkup'),
(2, 2, '2024-08-12 14:30:00', 'Skin rash consultation');

-- Insert sample diagnoses
INSERT INTO Diagnoses (patient_id, doctor_id, symptoms, diagnosis_date)
VALUES
(1, 1, 'High blood pressure, headaches', '2024-08-10'),
(2, 2, 'Itchy rash, redness', '2024-08-12');

-- Insert sample treatments
INSERT INTO Treatments (diagnosis_id, treatment_description)
VALUES
(1, 'Prescribed beta-blockers and advised lifestyle changes'),
(2, 'Prescribed antihistamines and topical creams');

-- Insert sample medications
INSERT INTO Medications (name, dosage_form, manufacturer)
VALUES
('Lisinopril', 'Tablet', 'PharmaCo'),
('Cetirizine', 'Tablet', 'MediLife');

-- Insert sample prescriptions
INSERT INTO Prescriptions (treatment_id, medication_id, dosage, duration)
VALUES
(1, 1, '10mg once daily', '30 days'),
(2, 2, '5mg once daily', '14 days');
