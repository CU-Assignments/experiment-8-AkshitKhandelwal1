CREATE DATABASE employeedb;
USE employeedb;

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    salary DOUBLE
);

INSERT INTO employees (name, department, salary) VALUES 
('John Doe', 'Engineering', 75000),
('Jane Smith', 'HR', 65000),
('Mike Johnson', 'Marketing', 70000),
('Sarah Williams', 'Engineering', 80000),
('David Brown', 'Finance', 85000);
