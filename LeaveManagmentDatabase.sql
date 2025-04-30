CREATE DATABASE leave_management;

USE leave_management;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role ENUM('student', 'faculty') NOT NULL
);

CREATE TABLE leave_applications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL, 
    role ENUM('student', 'faculty') NOT NULL,
    leave_type VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    reason TEXT,
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    applied_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_user FOREIGN KEY (username) REFERENCES users(username)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);



drop table leave_applications;
truncate table users;
truncate table leave_applications;

INSERT INTO users (username, password, role) VALUES
('RMC24001', 'MC2401', 'student'),
('RMC24002', 'MC2402', 'student'),
('RMC24003', 'MC2403', 'student'),
('RMC24004', 'MC2404', 'student'),
('RMC24005', 'MC2405', 'student'),
('RMC24006', 'MC2406', 'student'),
('RMC24007', 'MC2407', 'student'),
('RMC24008', 'MC2408', 'student'),
('RMC24009', 'MC2409', 'student'),
('RMC24010', 'MC2410', 'student'),
('RMC24011', 'MC2411', 'student'),
('RMC24012', 'MC2412', 'student'),
('RMC24013', 'MC2413', 'student'),
('RMC24014', 'MC2414', 'student'),
('RMC24015', 'MC2415', 'student'),
('RMC24016', 'MC2416', 'student'),
('RMC24017', 'MC2417', 'student'),
('RMC24018', 'MC2418', 'student'),
('RMC24019', 'MC2419', 'student'),
('RMC24020', 'MC2420', 'student'),
('RMC24021', 'MC2421', 'student'),
('RMC24022', 'MC2422', 'student'),
('RMC24023', 'MC2423', 'student'),
('RMC24024', 'MC2424', 'student'),
('RMC24025', 'MC2425', 'student'),
('RMC24026', 'MC2426', 'student'),
('RMC24027', 'MC2427', 'student'),
('RMC24028', 'MC2428', 'student'),
('RMC24029', 'MC2429', 'student'),
('RMC24030', 'MC2430', 'student'),
('RMC24031', 'MC2431', 'student'),
('RMC24032', 'MC2432', 'student'),
('RMC24033', 'MC2433', 'student'),
('RMC24034', 'MC2434', 'student'),
('RMC24035', 'MC2435', 'student'),
('RMC24036', 'MC2436', 'student'),
('RMC24037', 'MC2437', 'student'),
('RMC24038', 'MC2438', 'student'),
('RMC24039', 'MC2439', 'student'),
('RMC24040', 'MC2440', 'student'),
('RMC24041', 'MC2441', 'student'),
('RMC24042', 'MC2442', 'student'),
('RMC24043', 'MC2443', 'student'),
('RMC24044', 'MC2444', 'student'),
('RMC24045', 'MC2445', 'student'),
('RMC24046', 'MC2446', 'student'),
('RMC24047', 'MC2447', 'student'),
('RMC24048', 'MC2448', 'student'),
('RMC24049', 'MC2449', 'student'),
('RMC24050', 'MC2450', 'student'),
('RMC24051', 'MC2451', 'student'),
('RMC24052', 'MC2452', 'student'),
('RMC24053', 'MC2453', 'student'),
('RMC24054', 'MC2454', 'student'),
('RMC24055', 'MC2455', 'student'),
('RMC24056', 'MC2456', 'student'),
('RMC24057', 'MC2457', 'student'),
('RMC24058', 'MC2458', 'student'),
('RMC24059', 'MC2459', 'student'),
('RMC24060', 'MC2460', 'student'),
('RMC24061', 'MC2461', 'student'),
('RMC24062', 'MC2462', 'student'),
('RMC24063', 'MC2463', 'student'),
('RMC24064', 'MC2464', 'student'),
('RMC24065', 'MC2465', 'student'),
('RMC24066', 'MC2466', 'student'),
('RMC24067', 'MC2467', 'student');

INSERT INTO users (username, password, role) VALUES
('admin', 'a', 'admin');

INSERT INTO users (username, password, role) VALUES
('s1', 's1', 'student'),
('f1', 'f1', 'faculty');

SELECT * FROM users;
SELECT * FROM leave_applications;