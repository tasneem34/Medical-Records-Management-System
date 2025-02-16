# Design Document

By Tasneem Mostafa Borham

Video overview: <https://youtu.be/2LCAO_mRawI>

## Scope

Purpose of the Database
The purpose of this database is to create a Medical Records Management System that helps healthcare providers efficiently manage patient information, medical histories, diagnoses, treatments, prescriptions, and appointments. The system aims to streamline administrative tasks, improve patient care, and ensure secure access to medical records.

In Scope
Patients: Individuals receiving medical care.

Doctors: Healthcare providers responsible for diagnosing and treating patients.

Medical Histories: Records of past illnesses, surgeries, allergies, and chronic conditions.

Diagnoses: Medical conditions identified by doctors.

Treatments: Procedures or therapies prescribed for diagnoses.

Prescriptions: Medications prescribed to patients.

Appointments: Scheduled visits between patients and doctors.

Medications: Reference data for available drugs and their details.

Out of Scope
Billing and Insurance: Financial transactions and insurance claims.

Laboratory Results: Detailed test results and imaging data.

Telemedicine: Virtual consultations and remote monitoring.

AI-Based Diagnostics: Advanced diagnostic tools or machine learning models.

## Functional Requirements

What Users Can Do
Patients:

View their medical history, diagnoses, and treatments.

Schedule and manage appointments with doctors.

Doctors:

Access patient records and medical histories.

Record diagnoses and prescribe treatments.

View and manage their appointment schedules.

Administrative Staff:

Add and update patient and doctor information.

Generate reports (e.g., patient summaries, appointment schedules).

Beyond Scope
Users cannot process payments or handle insurance claims.

The system does not support advanced analytics or predictive modeling.

It does not integrate with external systems like pharmacies or laboratories.

## Representation

### Entities

Entities
1. Patients
Attributes:

patient_id (INT, PRIMARY KEY): Unique identifier for each patient.

name (VARCHAR(100)): Full name of the patient.

date_of_birth (DATE): Patient’s birth date.

gender (ENUM('Male', 'Female', 'Other')): Patient’s gender.

contact_number (VARCHAR(15)): Phone number for contact.

email (VARCHAR(100)): Email address for communication.

Constraints:

patient_id is auto-incremented to ensure uniqueness.

name, date_of_birth, and gender are required fields.

2. Medical Histories
Attributes:

history_id (INT, PRIMARY KEY): Unique identifier for each medical history record.

patient_id (INT, FOREIGN KEY): Links to the patient.

condition (VARCHAR(255)): Description of the medical condition.

diagnosis_date (DATE): Date the condition was diagnosed.

Constraints:

patient_id references the Patients table to maintain referential integrity.

3. Doctors
Attributes:

doctor_id (INT, PRIMARY KEY): Unique identifier for each doctor.

name (VARCHAR(100)): Full name of the doctor.

specialization (VARCHAR(100)): Area of expertise (e.g., cardiology, pediatrics).

contact_number (VARCHAR(15)): Phone number for contact.

Constraints:

doctor_id is auto-incremented to ensure uniqueness.

4. Appointments
Attributes:

appointment_id (INT, PRIMARY KEY): Unique identifier for each appointment.

patient_id (INT, FOREIGN KEY): Links to the patient.

doctor_id (INT, FOREIGN KEY): Links to the doctor.

appointment_date (DATETIME): Date and time of the appointment.

purpose (TEXT): Reason for the appointment.

Constraints:

patient_id and doctor_id reference the Patients and Doctors tables, respectively.

5. Diagnoses
Attributes:

diagnosis_id (INT, PRIMARY KEY): Unique identifier for each diagnosis.

patient_id (INT, FOREIGN KEY): Links to the patient.

doctor_id (INT, FOREIGN KEY): Links to the doctor.

symptoms (TEXT): Description of symptoms.

diagnosis_date (DATE): Date of diagnosis.

Constraints:

patient_id and doctor_id reference the Patients and Doctors tables, respectively.

6. Treatments
Attributes:

treatment_id (INT, PRIMARY KEY): Unique identifier for each treatment.

diagnosis_id (INT, FOREIGN KEY): Links to the diagnosis.

treatment_description (TEXT): Description of the treatment.

Constraints:

diagnosis_id references the Diagnoses table.

7. Medications
Attributes:

medication_id (INT, PRIMARY KEY): Unique identifier for each medication.

name (VARCHAR(100)): Name of the medication.

dosage_form (VARCHAR(50)): Form of the medication (e.g., tablet, injection).

manufacturer (VARCHAR(100)): Name of the manufacturer.

Constraints:

medication_id is auto-incremented to ensure uniqueness.

8. Prescriptions
Attributes:

prescription_id (INT, PRIMARY KEY): Unique identifier for each prescription.

treatment_id (INT, FOREIGN KEY): Links to the treatment.

medication_id (INT, FOREIGN KEY): Links to the medication.

dosage (VARCHAR(50)): Dosage instructions.

duration (VARCHAR(50)): Duration of the prescription.

Constraints:

treatment_id and medication_id reference the Treatments and Medications tables, respectively.

### Relationships

![ERD](<Medical Records Management System-2025-02-11-120831.png>)

Relationships
Patients → Medical Histories (one-to-many): A patient can have multiple medical history records.

Patients → Appointments (one-to-many): A patient can have multiple appointments.

Doctors → Appointments (one-to-many): A doctor can have multiple appointments.

Patients → Diagnoses (one-to-many): A patient can have multiple diagnoses.

Doctors → Diagnoses (one-to-many): A doctor can make multiple diagnoses.

Diagnoses → Treatments (one-to-many): A diagnosis can lead to multiple treatments.

Treatments → Prescriptions (one-to-many): A treatment can involve multiple prescriptions.

Medications → Prescriptions (one-to-many): A medication can be part of multiple prescriptions.

## Optimizations

Indexes
Created indexes on patient_id, doctor_id, and appointment_date to speed up queries involving patient records, doctor schedules, and appointment lookups.

Views
Created a view called PatientSummary to display a patient’s medical history, diagnoses, and treatments in one place.

Created a view called DoctorSchedule to show a doctor’s upcoming appointments.
## Limitations

The database does not handle complex medical data like lab results or imaging files.

It lacks support for advanced features like telemedicine or AI-based diagnostics.

Representation Challenges
The system may struggle to represent highly specialized medical data (e.g., genetic information).

It does not account for multi-language support, which could be a limitation in diverse healthcare settings.
