CREATE DATABASE student_portal;
USE student_portal;

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    roll_number VARCHAR(20) UNIQUE NOT NULL,
    course VARCHAR(50)
);

CREATE TABLE attendance (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    date DATE,
    status ENUM('Present', 'Absent', 'Late') NOT NULL,
    remarks VARCHAR(200),
    FOREIGN KEY (student_id) REFERENCES students(id)
);

-- Sample student data
INSERT INTO students (name, roll_number, course) VALUES 
('Rahul Kumar', 'CSE001', 'Computer Science'),
('Priya Singh', 'CSE002', 'Computer Science'),
('Amit Sharma', 'ECE001', 'Electronics'),
('Neha Patel', 'ECE002', 'Electronics'),
('Vikram Joshi', 'CSE003', 'Computer Science');
