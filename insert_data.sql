INSERT INTO Student VALUES
('3035435840', 'Changjin Lee', 'M', 25),
('3035555626', 'Yonghyun Kwon', 'M', 24),
('3035604075', 'Yeon Park', 'M',23),
('3035729423', 'Jungan Choi','F',22);

INSERT INTO Course VALUES
('COMP3278', 'Intro. to Database Management Systems', 'This course studies the principles, design, administration, and implementation of database management systems. Topics include: entity-relationship model, relational model, relational algebra, database design and normalization, database query languages, indexing schemes, integrity, and concurrency control.'),
('COMP3230', 'Principles of Operating Systems', 'Operating system structures, process and thread, CPU scheduling, process synchronization, deadlocks, memory management, file systems, I/O systems and device driver, mass-storage structure and disk scheduling, case studies.'),
('COMP3330', 'Interactive mobile application design and programming', 'This course aims at introducing the design and development issues of mobile apps. Students will learn the basic principles, constraints and lifecycle of mobile apps. Then they will learn how to use modern object-oriented languages for the development and different design patterns. Next they will learn various development issues such as graphics, touch events, handling of concurrency, sensors, location services and server connection. Students will also participate in both individual assignments and group project to practice ideation, reading, writing, coding and presentation throughout this course.'),
('COMP3258', 'Functional Programming', 'The course teaches the basics of functional programming using the language Haskell. The main goal is introduce students to fundamental programming concepts such as recursion, abstraction, lambda expressions and higher-order functions and data types. The course will also study the mathematical reasoning involved in the design of functional programs and techniques for proving properties about functions so defined. With the adoption of lambda expressions recent versions of Java, C++ or C#, functional programming and related programming techniques are becoming increasingly more relevant even for programmers of languages that are not traditionally viewed as functional. This course is important to introduce students to such techniques.');

INSERT INTO Subclass VALUES
('A', 'COMP3278', 'MON 14:30-15:20', 'THU 13:30-15:20', 'MWT2', 'MWT2', 'Welcome to COMP3278!', 'https://hku.zoom.us/j/96226740999?pwd=ZER1UUdxSVVhQzNXbXFkUDd3WjRBdz09');

INSERT INTO SubclassEvent VALUES
(0, 'COMP3278', 'A', 'assignment', 'Assignment 2', 'www.comp3278asg1.com');

INSERT INTO StudentEnrollsSubclass VALUES
('COMP3278', 'A', '3035435840', '2022-09-01');

INSERT INTO Logging VALUES
(0, '3035435840', '2022-09-06 00:28:51', NULL),
(1, '3035555626', '2022-10-07 13:25:54', '2022-10-07 13:28:42');

INSERT INTO EmailActivity VALUES
(0, '3035435840', '2022-09-08 06:24:51');

INSERT INTO RedirectionActivity VALUES
(0, '3035604075', 'zoom_link', '2022-09-22 09:11:41');
