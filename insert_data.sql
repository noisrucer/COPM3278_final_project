INSERT INTO Student VALUES
('3035435840', 'Changjin Lee', 'M', 25, "changjin9792@gmail.com"),
('3035555626', 'Yonghyun Kwon', 'M', 24, "u3555562@connect.hku.hk"),
('3035604075', 'Yeon Park', 'M',23, "pyeon99@gmail.com"),
('3035729423', 'Jungan Choi','F',22, "junganchoi26@gmail.com"),
('3035786603', 'Lo Yu Sum', 'M', 20, "loyusum246807952@gmail.com");


INSERT INTO Course VALUES
('COMP3278', 'Intro. to Database Management Systems', 'This course studies the principles, design, administration, and implementation of database management systems. Topics include: entity-relationship model, relational model, relational algebra, database design and normalization, database query languages, indexing schemes, integrity, and concurrency control.'),
('COMP3230', 'Principles of Operating Systems', 'Operating system structures, process and thread, CPU scheduling, process synchronization, deadlocks, memory management, file systems, I/O systems and device driver, mass-storage structure and disk scheduling, case studies.'),
('COMP3330', 'Interactive mobile application design and programming', 'This course aims at introducing the design and development issues of mobile apps. Students will learn the basic principles, constraints and lifecycle of mobile apps. Then they will learn how to use modern object-oriented languages for the development and different design patterns. Next they will learn various development issues such as graphics, touch events, handling of concurrency, sensors, location services and server connection. Students will also participate in both individual assignments and group project to practice ideation, reading, writing, coding and presentation throughout this course.'),
('COMP3258', 'Functional Programming', 'The course teaches the basics of functional programming using the language Haskell. The main goal is introduce students to fundamental programming concepts such as recursion, abstraction, lambda expressions and higher-order functions and data types. The course will also study the mathematical reasoning involved in the design of functional programs and techniques for proving properties about functions so defined. With the adoption of lambda expressions recent versions of Java, C++ or C#, functional programming and related programming techniques are becoming increasingly more relevant even for programmers of languages that are not traditionally viewed as functional. This course is important to introduce students to such techniques.');

INSERT INTO Subclass VALUES
('A', 'COMP3278', 'Welcome to COMP3278!'),
('A', 'COMP3230', 'Welcome to COMP3230A!'),
('B', 'COMP3230', 'Welcome to COMP3230B!'),
('A', 'COMP3330', 'Welcome to COMP3330!'),
('A', 'COMP3258', 'Welcome to COMP3258!')
;

INSERT INTO SubclassInfo VALUES
(1, 'A', 'COMP3278', 'Monday', '14:30', '15:20', 'MWT2', 'https://hku.zoom.us/j/96226740999?pwd=ZER1UUdxSVVhQzNXbXFkUDd3WjRBdz09'),
(2, 'A', 'COMP3278', 'Thursday', '13:30', '15:20', 'MWT2', 'https://hku.zoom.us/j/96226740999?pwd=ZER1UUdxSVVhQzNXbXFkUDd3WjRBdz09'),
(1, 'A', 'COMP3230', 'Tuesday', '10:30', '12:20', 'CPD-LG.01', 'No static address, let''s discuss which one to choose'),
(2, 'A', 'COMP3230', 'Thursday', '10:30', '12:20', 'CYPP2', 'No static address, let''s discuss which one to choose'),
(1, 'B', 'COMP3230', 'Tuesday', '10:30', '12:20', 'TBC', 'TBC'),
(2, 'B', 'COMP3230', 'Thursday', '10:30', '12:20', 'TBC', 'TBC'),
(1, 'A', 'COMP3330', 'Monday', '12:30', '14:20', 'LE4', 'TBC'),
(2, 'A', 'COMP3330', 'Thursday', '12:30', '13:20', 'LE4', 'TBC'),
(1, 'A', 'COMP3258', 'Tuesday', '13:30', '15:20', 'MB167', 'TBC'),
(2, 'A', 'COMP3258', 'Friday', '14:30', '15:20', 'MB167', 'TBC'),
(3, 'A', 'COMP3258', 'Friday', '23:30', '23:20', 'MB167', 'TBC');

INSERT INTO SubclassEvent VALUES
(0, 'COMP3278', 'A', 'assignment', 'Assignment 1', 'www.comp3278asg1.com', '2022-11-4 12:00', NULL),
(1, 'COMP3278', 'A', 'assignment', 'Assignment 3', 'www.comp3278asg3.com', '2022-11-4 12:00', NULL),
(2, 'COMP3278', 'A', 'lecture_note', 'Lecture 1', 'www.comp3278lec1.com', '2022-11-4 12:00', NULL),
(3, 'COMP3278', 'A', 'tutorial_note', 'Tutorial 2', 'www.comp3278tuto2.com', '2022-11-4 12:00', NULL),
(4, 'COMP3278', 'A', 'quiz', 'Quiz 1', 'www.comp3278quiz1.com', '2022-11-4 12:00', NULL),
(5, 'COMP3230', 'A', 'lecture_note', 'Lecture 3', 'www.comp3230Alec1.com', '2022-11-4 12:00', NULL),
(6, 'COMP3230', 'B', 'lecture_note', 'Lecture 3', 'www.comp3230Blec1.com', '2022-11-4 12:00', NULL),
(7, 'COMP3330', 'A', 'assignment', 'Assignment 7', 'www.comp3330asg7.com', '2022-11-4 12:00', NULL),
(8, 'COMP3258', 'A', 'quiz', 'Quiz 2', 'www.comp3258quiz2.com', '2022-11-4 12:00', NULL),
(9, 'COMP3258', 'A', 'tutorial_note', 'Tutorial 5', 'www.comp3258tuto5.com', '2022-11-4 12:00', NULL)
;

--if a student is already enrolled in course, can't enrolled in another subclass --
INSERT INTO StudentEnrollsSubclass VALUES
('COMP3278', 'A', '3035435840', '2022-09-01'),
('COMP3258', 'A', '3035435840', '2022-09-02'),
('COMP3230', 'A', '3035435840', '2022-09-02'),
('COMP3330', 'A', '3035435840', '2022-09-01'),
('COMP3278', 'A', '3035604075', '2022-09-01'),
('COMP3230', 'B', '3035604075', '2022-09-01'),
('COMP3258', 'A', '3035604075', '2022-09-01'),
('COMP3278', 'A', '3035555626', '2022-09-03'),
('COMP3258', 'A', '3035555626', '2022-09-03'),
('COMP3230', 'A', '3035555626', '2022-09-03'),
('COMP3330', 'A', '3035555626', '2022-08-30')
;

INSERT INTO StudentEnrollsSubclass VALUES ('COMP3258', 'A', '3035729423', '2022-08-29');

INSERT INTO Logging VALUES
(0, '3035435840', '2022-09-06 00:28:51', NULL, NULL),
(1, '3035555626', '2022-10-07 13:25:54', '2022-10-07 13:28:42', NULL),
(2, '3035604075', '2022-11-02 09:30:00', '2022-11-02 11:30:00', NULL),
(4, '3035729423', '2022-10-01 17:05:19', '2022-10-01 17:15:30', NULL);
INSERT INTO Logging VALUES (5, '3035729423', '2022-10-01 17:05:19', '2022-10-01 17:15:30', "TEMPTOKEN");
INSERT INTO Logging VALUES (6, '3035729423', '2022-9-01 17:05:19', NULL, "TEMPTOKEN");

-- We can't have a student doing any activity if not enrolled in the course
INSERT INTO EmailActivity VALUES
(0, '3035435840', 'COMP3230', 'A', '2022-09-08 06:24:51'),
(1, '3035604075', 'COMP3258', 'A', '2022-10-27 16:55:30');

INSERT INTO RedirectionActivity VALUES
(0, '3035604075', 'zoom_link', '2022-09-22 09:11:41'),
(1, '3035555626', 'lecture_note', '2022-10-22 00:19:35'),
(2, '3035435840', 'tutorial_note', '2022-10-22 00:19:35'),
(5, '3035435840', 'assignment', '2022-09-03 19:21:51'),
(6, '3035604075', 'quiz', '2022-11-01 23:59:59');

