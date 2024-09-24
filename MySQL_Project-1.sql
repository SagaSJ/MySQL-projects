DROP DATABASE IF EXISTS railway_system;
CREATE DATABASE IF NOT EXISTS railway_system;

USE railway_system;

DROP TABLE IF EXISTS user_login;
CREATE TABLE IF NOT EXISTS user_login (
    user_id VARCHAR(255) PRIMARY KEY,
    user_password VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    sign_up_on DATE,
    email_id VARCHAR(255)
);

DROP TABLE IF EXISTS passenger;
CREATE TABLE IF NOT EXISTS passenger (
    passenger_id VARCHAR(255) PRIMARY KEY,
    user_password VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    sign_up_on DATE,
    email_id VARCHAR(255),
    contact VARCHAR(255)
);

DROP TABLE IF EXISTS train_type;
CREATE TABLE IF NOT EXISTS train_type (
    train_type_id VARCHAR(255) PRIMARY KEY,
    train_type VARCHAR(255),
    coaches_count INT,
    passenger_strength INT,
    train_count INT
);

DROP TABLE IF EXISTS stations;
CREATE TABLE IF NOT EXISTS stations (
    station_id VARCHAR(255) PRIMARY KEY,
    station_name VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255)
);

DROP TABLE IF EXISTS train_details;
CREATE TABLE IF NOT EXISTS train_details (
    train_id VARCHAR(255) PRIMARY KEY,
    train_type_id VARCHAR(255),
    source_station_id VARCHAR(255),
    destination_station_id VARCHAR(255),
    duration_minutes INT,
    journey_start TIMESTAMP,
    journey_end TIMESTAMP,
    passenger_strength INT,
    is_available BOOLEAN,
    FOREIGN KEY (train_type_id) REFERENCES train_type (train_type_id),
    FOREIGN KEY (source_station_id) REFERENCES stations (station_id),
    FOREIGN KEY (destination_station_id) REFERENCES stations (station_id)
);

DROP TABLE IF EXISTS journey;
CREATE TABLE IF NOT EXISTS journey (
    journey_id VARCHAR(255) PRIMARY KEY,
    passenger_id VARCHAR(255),
    train_id VARCHAR(255),
    booking_id VARCHAR(255),
    payment_id VARCHAR(255),
    payment_status VARCHAR(255),
    paid_on TIMESTAMP,
    booking_status VARCHAR(255),
    booked_on TIMESTAMP,
    seat_alloted VARCHAR(255),
    meal_booked BOOLEAN,
    FOREIGN KEY (passenger_id) REFERENCES passenger (passenger_id),
    FOREIGN KEY (train_id) REFERENCES train_details (train_id)
);

DROP TABLE IF EXISTS train_routes;
CREATE TABLE IF NOT EXISTS train_routes (
    row_id INT AUTO_INCREMENT PRIMARY KEY,
    route_id VARCHAR(255),
    train_id VARCHAR(255),
    station_id VARCHAR(255),
    order_number INT,
    halt_duration_minutes INT,
    estimated_arrival TIME,
    estimated_departure TIME,
    FOREIGN KEY (train_id) REFERENCES train_details (train_id),
    FOREIGN KEY (station_id) REFERENCES stations (station_id)
);


desc user_login;
desc passenger;
desc train_type;
desc stations;
desc train_details;
desc journey;
desc train_routes;

INSERT into user_login (user_id,user_password,first_name,last_name,sign_up_on,email_id) 
VALUES
("U001","password123","John","Smith","2024-01-15","john.smith@email.com"),
("U002","password456","Jane","Doe","2024-02-20","jane.doe@email.com");

INSERT INTO passenger (passenger_id, user_password, first_name, last_name, sign_up_on, email_id, contact)
VALUES 
('P001', 'password123', 'John', 'Smith', '2024-01-15', 'john.smith@email.com', '1234567890'),
('P002', 'password456', 'Jane', 'Doe', '2024-02-20', 'jane.doe@email.com', '0987654321');

INSERT INTO train_type (train_type_id, train_type, coaches_count, passenger_strength, train_count)
VALUES 
('TT01', 'Express', 12, 600, 30),
('TT02', 'Local', 9, 450, 50);

INSERT INTO stations (station_id, station_name, city, state)
VALUES 
('MAS', 'Chennai Central Station', 'Chennai', 'TamilNadu'),
('HYB', 'Nampally Station', 'Hyderbad', 'Telangana'),
('MMCT', 'Mumbai Central Station', 'Mumbai', 'Maharashtra');

INSERT INTO train_details (train_id, train_type_id, source_station_id, destination_station_id, duration_minutes, journey_start, journey_end, passenger_strength, is_available)
VALUES 
('T001', 'TT01', 'MAS', 'HYB', 120, '2024-06-18 08:00:00', '2024-06-18 10:00:00', 600, TRUE),
('T002', 'TT02', 'MMCT', 'MAS', 180, '2024-06-19 07:00:00', '2024-06-19 10:00:00', 400, TRUE);

INSERT INTO journey (journey_id, passenger_id, train_id, booking_id, payment_id, payment_status, paid_on, booking_status, booked_on, seat_alloted, meal_booked)
VALUES 
('J001', 'P001', 'T001', 'B001', 'PAY001', 'Paid', '2024-06-17 09:00:00', 'Confirmed', '2024-06-17 08:00:00', 'A1', FALSE),
('J002', 'P002', 'T002', 'B002', 'PAY002', 'Pending', '2024-06-17 10:00:00', 'Pending', '2024-06-17 09:00:00', 'B2', TRUE);

INSERT INTO train_routes (route_id, train_id, station_id, order_number, halt_duration_minutes, estimated_arrival, estimated_departure)
VALUES 
('R001', 'T001', 'MAS', 1, 10, '08:00:00', '08:10:00'),
('R001', 'T001', 'HYB', 2, 15, '09:55:00', '10:10:00'),
('R002', 'T002', 'MMCT', 1, 20, '07:00:00', '07:20:00'),
('R002', 'T002', 'MAS', 2, 5, '09:55:00', '10:00:00');


SELECT * FROM user_login;
SELECT * FROM passenger;
SELECT * FROM train_type;
SELECT * FROM stations;
SELECT * FROM train_details;
SELECT * FROM journey;
SELECT * FROM train_routes;



ALTER TABLE passenger
ADD COLUMN Address VARCHAR(512);

UPDATE passenger
SET Address = '123 F BLOCK St,ANNA NAGAR,CHENNAI,TAMILNADU'
WHERE passenger_id = 'P001';

UPDATE passenger
SET Address = '456 JS BYTES St, KPHB COLONY, HYDERBAD, TELEGANA'
WHERE passenger_id = 'P002';

ALTER TABLE user_login
MODIFY COLUMN user_password VARCHAR(512);

ALTER TABLE train_details
ALTER COLUMN is_available SET DEFAULT TRUE;

