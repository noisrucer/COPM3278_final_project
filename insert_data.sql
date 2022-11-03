INSERT INTO Student VALUES
('3035435840', 'Changjin Lee', 'M', 25, "changjin9792@gmail.com"),
('3035555626', 'Yonghyun Kwon', 'M', 24, "u3555562@connect.hku.hk"),
('3035604075', 'Yeon Park', 'M',23, "pyeon99@gmail.com"),
('3035729423', 'Jungan Choi','F',22, "junganchoi26@gmail.com"),
('3035786603', 'Lo Yu Sum', 'M', 20, "loyusum246807952@gmail.com")


INSERT INTO Course VALUES
('COMP3278', 'Intro. to Database Management Systems', 'This course studies the principles, design, administration, and implementation of database management systems. Topics include: entity-relationship model, relational model, relational algebra, database design and normalization, database query languages, indexing schemes, integrity, and concurrency control.'),
('COMP3230', 'Principles of Operating Systems', 'Operating system structures, process and thread, CPU scheduling, process synchronization, deadlocks, memory management, file systems, I/O systems and device driver, mass-storage structure and disk scheduling, case studies.'),
('COMP3330', 'Interactive mobile application design and programming', 'This course aims at introducing the design and development issues of mobile apps. Students will learn the basic principles, constraints and lifecycle of mobile apps. Then they will learn how to use modern object-oriented languages for the development and different design patterns. Next they will learn various development issues such as graphics, touch events, handling of concurrency, sensors, location services and server connection. Students will also participate in both individual assignments and group project to practice ideation, reading, writing, coding and presentation throughout this course.'),
('COMP3258', 'Functional Programming', 'The course teaches the basics of functional programming using the language Haskell. The main goal is introduce students to fundamental programming concepts such as recursion, abstraction, lambda expressions and higher-order functions and data types. The course will also study the mathematical reasoning involved in the design of functional programs and techniques for proving properties about functions so defined. With the adoption of lambda expressions recent versions of Java, C++ or C#, functional programming and related programming techniques are becoming increasingly more relevant even for programmers of languages that are not traditionally viewed as functional. This course is important to introduce students to such techniques.');

INSERT INTO Subclass VALUES
('A', 'COMP3278', 'MON 14:30-15:20', 'THU 13:30-15:20', 'MWT2', 'MWT2', 'Welcome to COMP3278!', 'https://hku.zoom.us/j/96226740999?pwd=ZER1UUdxSVVhQzNXbXFkUDd3WjRBdz09'),
('A', 'COMP3230', 'TUE 10:30-12:20', 'THU 10:30-12:20', 'CPD-LG.01', 'CYPP2', 'Welcome to COMP3230A!', 'No static address, let\'s discuss which one to choose'),
('B', 'COMP3230', 'TUE 10:30-12:20', 'THU 10:30-12:20', 'TBC', 'TBC', 'Welcome to COMP3230B!', 'TBC'),
('A', 'COMP3330', 'MON 12:30-14:20', 'THU 12:30-13:20', 'LE4', 'LE4', 'Welcome to COMP3330!', 'TBC'),
('A', 'COMP3258', 'TUE 13:30-15:20', 'FRI 14:30-15:20', 'MB167', 'MB167', 'Welcome to COMP3258!', 'TBC')
;

INSERT INTO SubclassEvent VALUES
(0, 'COMP3278', 'A', 'assignment', 'Assignment 1', 'www.comp3278asg1.com'),
(1, 'COMP3278', 'A', 'assignment', 'Assignment 3', 'www.comp3278asg3.com'),
(2, 'COMP3278', 'A', 'lecture_note', 'Lecture 1', 'www.comp3278lec1.com'),
(3, 'COMP3278', 'A', 'tutorial_note', 'Tutorial 2', 'www.comp3278tuto2.com'),
(4, 'COMP3278', 'A', 'quiz', 'Quiz 1', 'www.comp3278quiz1.com'),
(5, 'COMP3230', 'A', 'lecture_note', 'Lecture 3', 'www.comp3230Alec1.com'),
(6, 'COMP3230', 'B', 'lecture_note', 'Lecture 3', 'www.comp3230Blec1.com'),
(7, 'COMP3330', 'A', 'assignment', 'Assignment 7', 'www.comp3330asg7.com'),
(8, 'COMP3258', 'A', 'quiz', 'Quiz 2', 'www.comp3258quiz2.com'),
(9, 'COMP3258', 'A', 'tutorial_note', 'Tutorial 5', 'www.comp3258tuto5.com')
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

INSERT INTO Logging VALUES
(0, '3035435840', '2022-09-06 00:28:51', NULL, NULL),
(1, '3035555626', '2022-10-07 13:25:54', '2022-10-07 13:28:42', NULL),
(2, '3035604075', '2022-11-02 09:30:00', '2022-11-02 11:30:00', NULL),
(4, '3035729423', '2022-10-01 17:05:19', '2022-10-01 17:15:30', NULL);


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

