-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- Query 1: Retrieve all patients
-- Purpose: Display a list of all patients in the database.
SELECT * FROM Patients;

-- Query 2: Retrieve all doctors
-- Purpose: Display a list of all doctors in the database.
SELECT * FROM Doctors;

-- Query 3: Retrieve a specific patient's medical history
-- Purpose: Display the medical history of a patient with a specific ID (e.g., patient_id = 100).
SELECT mh.medical_condition, mh.diagnosis_date
FROM MedicalHistories mh
WHERE mh.patient_id = 100;

-- Query 4: Retrieve all appointments for a specific patient
-- Purpose: Display all appointments for a patient with a specific ID (e.g., patient_id = 100).
SELECT a.appointment_date, d.name AS doctor_name, a.purpose
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE a.patient_id = 100;

-- Query 5: Retrieve all appointments for a specific doctor
-- Purpose: Display all appointments for a doctor with a specific ID (e.g., doctor_id = 1).
SELECT a.appointment_date, p.name AS patient_name, a.purpose
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
WHERE a.doctor_id = 1;

-- Query 6: Retrieve all diagnoses for a specific patient
-- Purpose: Display all diagnoses for a patient with a specific ID (e.g., patient_id = 100).
SELECT d.symptoms, d.diagnosis_date, doc.name AS doctor_name
FROM Diagnoses d
JOIN Doctors doc ON d.doctor_id = doc.doctor_id
WHERE d.patient_id = 100;

-- Query 7: Retrieve all treatments for a specific diagnosis
-- Purpose: Display all treatments for a diagnosis with a specific ID (e.g., diagnosis_id = 1).
SELECT t.treatment_description
FROM Treatments t
WHERE t.diagnosis_id = 1;

-- Query 8: Retrieve all prescriptions for a specific treatment
-- Purpose: Display all prescriptions for a treatment with a specific ID (e.g., treatment_id = 1).
SELECT m.name AS medication, p.dosage, p.duration
FROM Prescriptions p
JOIN Medications m ON p.medication_id = m.medication_id
WHERE p.treatment_id = 1;

-- Query 9: Retrieve the most common diagnosis
-- Purpose: Display the diagnosis that has been recorded the most frequently.
SELECT symptoms, COUNT(*) AS diagnosis_count
FROM Diagnoses
GROUP BY symptoms
ORDER BY diagnosis_count DESC
LIMIT 1;

-- Query 10: Retrieve the number of patients per doctor
-- Purpose: Display the number of patients each doctor has treated.
SELECT doc.name AS doctor_name, COUNT(DISTINCT d.patient_id) AS patient_count
FROM Diagnoses d
JOIN Doctors doc ON d.doctor_id = doc.doctor_id
GROUP BY doc.name;

-- Query 11: Retrieve all medications prescribed to a specific patient
-- Purpose: Display all medications prescribed to a patient with a specific ID (e.g., patient_id = 1).
SELECT m.name AS medication, p.dosage, p.duration
FROM Prescriptions p
JOIN Treatments t ON p.treatment_id = t.treatment_id
JOIN Diagnoses d ON t.diagnosis_id = d.diagnosis_id
JOIN Medications m ON p.medication_id = m.medication_id
WHERE d.patient_id = 1;

-- Query 12: Retrieve the total number of appointments per patient
-- Purpose: Display the total number of appointments for each patient.
SELECT p.name AS patient_name, COUNT(a.appointment_id) AS appointment_count
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
GROUP BY p.name;

-- Query 13: Retrieve all patients with a specific condition
-- Purpose: Display all patients who have been diagnosed with a specific condition (e.g., 'Hypertension').
SELECT p.name AS patient_name, mh.medical_condition, mh.diagnosis_date
FROM MedicalHistories mh
JOIN Patients p ON mh.patient_id = p.patient_id
WHERE mh.medical_condition = 'Hypertension';

-- Query 14: Retrieve all doctors with a specific specialization
-- Purpose: Display all doctors who specialize in a specific area (e.g., 'Cardiology').
SELECT name, specialization
FROM Doctors
WHERE specialization = 'Cardiology';

-- Query 15: Retrieve the next appointment for a specific patient
-- Purpose: Display the next upcoming appointment for a patient with a specific ID (e.g., patient_id = 1).
SELECT a.appointment_date, d.name AS doctor_name, a.purpose
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE a.patient_id = 1 AND a.appointment_date > NOW()
ORDER BY a.appointment_date
LIMIT 1;

-- Query 16: Retrieve the total number of prescriptions per medication
-- Purpose: Display the total number of prescriptions for each medication.
SELECT m.name AS medication, COUNT(p.prescription_id) AS prescription_count
FROM Prescriptions p
JOIN Medications m ON p.medication_id = m.medication_id
GROUP BY m.name;

-- Query 17: Retrieve all patients who have not had an appointment in the last 6 months
-- Purpose: Display patients who have not had an appointment in the last 6 months.
SELECT p.name AS patient_name, MAX(a.appointment_date) AS last_appointment
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_id
HAVING last_appointment < DATE_SUB(NOW(), INTERVAL 6 MONTH) OR last_appointment IS NULL;

-- Query 18: Retrieve the average number of appointments per patient
-- Purpose: Display the average number of appointments across all patients.
SELECT AVG(appointment_count) AS average_appointments
FROM (
    SELECT COUNT(a.appointment_id) AS appointment_count
    FROM Appointments a
    GROUP BY a.patient_id
) AS appointment_counts;

-- Query 19: Retrieve all medications prescribed by a specific doctor
-- Purpose: Display all medications prescribed by a doctor with a specific ID (e.g., doctor_id = 1).
SELECT m.name AS medication, p.dosage, p.duration
FROM Prescriptions p
JOIN Treatments t ON p.treatment_id = t.treatment_id
JOIN Diagnoses d ON t.diagnosis_id = d.diagnosis_id
JOIN Medications m ON p.medication_id = m.medication_id
WHERE d.doctor_id = 1;

-- Query 20: Retrieve the total number of patients in the database
-- Purpose: Display the total number of patients.
SELECT COUNT(*) AS total_patients
FROM Patients;
