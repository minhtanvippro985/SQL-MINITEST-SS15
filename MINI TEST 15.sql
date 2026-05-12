CREATE DATABASE StudentManagement;
USE StudentManagement;


CREATE TABLE students(
	student_id VARCHAR(5) PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    total_debt DECIMAL(10,2) DEFAULT 0 


);

CREATE TABLE subjects(
	subject_id VARCHAR(5) PRIMARY KEY,
    subject_name VARCHAR(30) NOT NULL,
    credits INT CHECK(credits > 0)


);

CREATE TABLE grades(
	student_id VARCHAR(5),
    subject_id VARCHAR(5),
	PRIMARY KEY (student_id , subject_id) ,
    score DECIMAL(4,2) CHECK(score BETWEEN 0 AND 10) ,
	FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

CREATE TABLE grade_log(
	log_id INT PRIMARY KEY AUTO_INCREMENT ,
    student_id VARCHAR(5),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    old_score DECIMAL(4,2) ,
    new_score DECIMAL(4,2) ,
    change_date DATETIME DEFAULT current_timestamp
);



INSERT INTO students (student_id, full_name, total_debt) VALUES
('S001', 'Nguyễn Văn A', 0),
('S002', 'Trần Thị B', 1500.50),
('S003', 'Lê Minh C', 500.00),
('S004', 'Phạm Hồng D', 0),
('S005', 'Hoàng Gia E', 2200.00);

INSERT INTO subjects (subject_id, subject_name, credits) VALUES
('M001', 'Cơ sở dữ liệu', 3),
('M002', 'Lập trình Java', 4),
('M003', 'Toán rời rạc', 3),
('M004', 'Mạng máy tính', 3),
('M005', 'Kỹ năng mềm', 2);


INSERT INTO grades (student_id, subject_id, score) VALUES
('S001', 'M001', 8.5),
('S001', 'M002', 7.0),
('S002', 'M001', 4.5),
('S002', 'M003', 9.0),
('S003', 'M002', 6.5),
('S004', 'M004', 10.0),
('S005', 'M001', 5.5);

INSERT INTO grade_log (student_id, old_score, new_score) VALUES
('S002', 4.0, 4.5),
('S001', 8.0, 8.5);

DELIMITER // 
CREATE TRIGGER tg_check_score 
BEFORE INSERT 
ON grades
FOR EACH ROW
BEGIN 
	IF NEW.score < 0 
		THEN SET NEW.score = 0;
	ELSEIF NEW.score > 10 
		THEN SET NEW.score = 10;
    END IF;

END //

DELIMITER ;

SELECT * FROM grades;


DELIMITER //
CREATE TRIGGER tg_log_grade_update 
AFTER UPDATE 
ON grades 
FOR EACH ROW 
BEGIN 
	INSERT INTO grade_log (student_id, old_score, new_score , change_date)
    VALUES (NEW.student_id , OLD.score , NEW.score , NOW() );

END //


DELIMITER ;

UPDATE grades
SET score = 3.5 
WHERE student_id = 'S001';

SELECT * FROM grade_log;



START TRANSACTION ;
	INSERT INTO students(student_id , full_name , total_debt)
	VALUES ('SV02' , 'Ha Bich Ngoc', 5000000) ;
COMMIT;


SELECT * FROM students


DELIMITER //
CREATE PROCEDURE sp_pay_tuition ()
BEGIN
	START TRANSACTION 
		DECLARE 

END //

DELIMITER ;
