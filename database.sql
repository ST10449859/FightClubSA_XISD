CREATE DATABASE IF NOT EXISTS FightClubSA_DB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE FightClubSA_DB;
CREATE TABLE IF NOT EXISTS Members (member_id INT PRIMARY KEY AUTO_INCREMENT, full_name VARCHAR(100) NOT NULL, email VARCHAR(100) UNIQUE NOT NULL, phone VARCHAR(15), membership_type VARCHAR(50) DEFAULT 'Starter', password_hash VARCHAR(255), created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE IF NOT EXISTS Trainers (trainer_id INT PRIMARY KEY AUTO_INCREMENT, trainer_name VARCHAR(100) NOT NULL, specialization VARCHAR(100));
CREATE TABLE IF NOT EXISTS Classes (class_id INT PRIMARY KEY AUTO_INCREMENT, class_name VARCHAR(100) NOT NULL, trainer_id INT, schedule_date DATE NOT NULL, start_time TIME NOT NULL, capacity INT DEFAULT 20, level VARCHAR(50) DEFAULT 'All levels', description TEXT, FOREIGN KEY (trainer_id) REFERENCES Trainers(trainer_id));
CREATE TABLE IF NOT EXISTS Bookings (booking_id INT PRIMARY KEY AUTO_INCREMENT, member_id INT, class_id INT, booking_date DATE DEFAULT (CURRENT_DATE), status VARCHAR(30) DEFAULT 'Confirmed', FOREIGN KEY (member_id) REFERENCES Members(member_id), FOREIGN KEY (class_id) REFERENCES Classes(class_id));
CREATE TABLE IF NOT EXISTS Payments (payment_id INT PRIMARY KEY AUTO_INCREMENT, member_id INT, amount DECIMAL(10,2), payment_date DATE DEFAULT (CURRENT_DATE), transaction_id VARCHAR(80), status VARCHAR(30) DEFAULT 'Paid', FOREIGN KEY (member_id) REFERENCES Members(member_id));
INSERT INTO Trainers (trainer_name,specialization) SELECT * FROM (SELECT 'Thabo M.','Boxing') x WHERE NOT EXISTS (SELECT 1 FROM Trainers WHERE trainer_name='Thabo M.');
INSERT INTO Trainers (trainer_name,specialization) SELECT * FROM (SELECT 'Ayanda N.','Fitness') x WHERE NOT EXISTS (SELECT 1 FROM Trainers WHERE trainer_name='Ayanda N.');
INSERT INTO Trainers (trainer_name,specialization) SELECT * FROM (SELECT 'Mpho K.','Strength') x WHERE NOT EXISTS (SELECT 1 FROM Trainers WHERE trainer_name='Mpho K.');
INSERT INTO Classes (class_name,trainer_id,schedule_date,start_time,capacity,level,description)
SELECT 'Boxing Basics',trainer_id,CURRENT_DATE,'08:00:00',20,'Beginner','Learn boxing fundamentals, movement and conditioning.' FROM Trainers WHERE trainer_name='Thabo M.' LIMIT 1;
INSERT INTO Classes (class_name,trainer_id,schedule_date,start_time,capacity,level,description)
SELECT 'HIIT Boxing',trainer_id,CURRENT_DATE,'10:00:00',20,'Intermediate','High intensity boxing and cardio session.' FROM Trainers WHERE trainer_name='Ayanda N.' LIMIT 1;
INSERT INTO Classes (class_name,trainer_id,schedule_date,start_time,capacity,level,description)
SELECT 'Strength Lab',trainer_id,CURRENT_DATE,'12:00:00',15,'All levels','Strength and functional movement training.' FROM Trainers WHERE trainer_name='Mpho K.' LIMIT 1;
INSERT INTO Classes (class_name,trainer_id,schedule_date,start_time,capacity,level,description)
SELECT 'Fight Conditioning',trainer_id,CURRENT_DATE,'19:30:00',18,'Advanced','Conditioning session for serious fighters.' FROM Trainers WHERE trainer_name='Mpho K.' LIMIT 1;
