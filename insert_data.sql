-- Active: 1667214464632@@127.0.0.1@3306@comp3278_fp
INSERT INTO Student VALUES
('3035555626', 'Yonghyun Kwon', 'M', 24, "u3555562@connect.hku.hk"),
('3035604075', 'Yeon Park', 'M',23, "pyeon99@gmail.com"),
('3035786603', 'Lo Yu Sum', 'M',20, "emcjava@connect.hku.hk");

INSERT INTO Course VALUES
('COMP3278', 'Intro. to Database Management Systems', 'This course studies the principles, design, administration, and implementation of database management systems. Topics include: entity-relationship model, relational model, relational algebra, database design and normalization, database query languages, indexing schemes, integrity, and concurrency control.'),
('COMP3230', 'Principles of Operating Systems', 'Operating system structures, process and thread, CPU scheduling, process synchronization, deadlocks, memory management, file systems, I/O systems and device driver, mass-storage structure and disk scheduling, case studies.'),
('COMP3322', 'Modern Technologies on World Wide Web', 'Selected network protocols relevant to the World Wide Web (e.g., HTTP, DNS, IP); World Wide Web; technologies for programming the Web (e.g, HTML, XML, style sheets, PHP, JavaScript, Node.js.; other topics of current interest (AJAX, HTML5, web services, cloud computing).'),
('CCCH9047', 'Will the \'Real\' China Please Stand Up?: Interpreting Chinese Civilization','This course asks what do we really know about China, its politics, society, culture, economy and ways of life, and what can we know? By discussing a range of China stories – ways of representing China and Chineseness, each of which has something to teach us about the similarities and differences between our own and other cultures as they approach the civilization of China, the course encourages students to develop a more critical approach towards various representations about China and to identify the ways in which writing about China may obscure as much as it reveals about a possible \'real\' China.'),
('COMP3297', 'Software Engineering', 'This course introduces the fundamental principles, methodologies and practices of modern software engineering. It covers the software process, and development activities including requirements engineering, software design, testing, deployment and evolution. The course emphasizes the use of contemporary tools, frameworks and techniques. It features a complete agile development project in which students work in teams to engineer and cloud-deploy a software service to satisfy their clients\' needs.'),
('COMP3270', 'Artificial Intelligence', 'This is an introduction course on the subject of artificial intelligence. Topics include: intelligent agents; search techniques for problem solving; knowledge representation; logical inference; reasoning under uncertainty; statistical models and machine learning.'),
('CCHU9060', 'Gaming: Play, Learning and Society', 'This course will cover the theoretical and practical foundations of game application and its social consequences, using design techniques that originate from the field of psychology and the study of motivation. You will (i) experience our gamified teaching style, (ii) explore various scenarios about playing/using games, (iii) recognize the psychological, social, economic, and educational benefits of game application, (iv) be alert to the potential harms and risks, (v) understand how games are applied in different contexts, and (vi) critically evaluate game and gamification projects.'),
('STAT3600', 'Linear statistical analysis', 'The analysis of variability is mainly concerned with locating the sources of the variability.  Many statistical techniques investigate these sources through the use of \'linear\' models.  This course presents the theory and practice of these models.');

INSERT INTO Subclass VALUES
('A', 'COMP3278', 'Welcome to COMP3278A! The slides and videos of the lectures and tutorials will be released. The slides are ".pdf" files with one slide on one page (1-by-1 scheme). Please print multiple pages (slides) on one paper in order to play green. Thanks for saving papers!'),
('A', 'COMP3230', 'Welcome to COMP3230A! To present the fundamentals of operating systems, to study the details of the operations and principles behind the design of various components of an operating system'),
('A', 'COMP3322', 'Welcome to COMP3322A. This course is designed to provide you key technologies of the World Wide Web, as well as useful practice in developing web-based applications and systems. The course consists primarily of lectures and lab practice. Major topics to be covered include: Internet protocol stack, client-server model, IP, World Wide Web, HTTP, HTML, CSS, JavaScript, Node.js, ReactJS, and web service.'),
('A', 'CCCH9047', 'Welcome dear students to a course on China stories! Before we start, the red text in the lecture notes addresses you directly, being a question to answer, something to ponder, or a task to fulfill. A student activity in short. The blue is for me, the professor, to remember to tell you something or to revise something in the text. Important terms, concepts and names I want you to take particular note of, maybe even google up, are in bold. Every lecture contains a discussion section, marked in red in the lecture notes document. They will not be graded but are meant for you to start reflecting on important topics, concepts and ideas - to help you prepare for the quizzes and the group project.'),
('A', 'COMP3297', 'Welcome to COMP3297A! Able to demonstrate an understanding of the software development process and activities including the analysis, design, implementation, testing and deployment of contemporary software systems.'),
('A', 'COMP3270', 'Welcome to COMP3270A! You will learn mathematics foundation, basic and advanced data structures, algorithms'),
('A', 'CCHU9060', 'Have you ever played games with your friends and family? Do you have rewards points on your credit cards? Have you ever thought about what it means to “game” the system, or have you studied “game theory”? Playing games is, and always has been, a basic attribute of humans at all stages of life and across all cultures. Games and their applications – such as My Starbucks Rewards, NikeiD and Facebook – have been used to enrich our lives in many different contexts, including business, education, and pleasure. However, games can also be associated with negative consequences, such as addiction, which can greatly affect our health and social life.'),
('A', 'STAT3600', 'Teaching is composed of three hours of lectures and an one-hour tutorial class per week.');

INSERT INTO SubclassInfo VALUES
('A', 'COMP3278', 'Monday', '14:30', '15:20', 'MWT2', 'https://hku.zoom.us/j/96226740999?pwd=ZER1UUdxSVVhQzNXbXFkUDd3WjRBdz09'),
('A', 'COMP3278', 'Thursday', '13:30', '15:20', 'MWT2', 'https://hku.zoom.us/j/96226740999?pwd=ZER1UUdxSVVhQzNXbXFkUDd3WjRBdz09'),
('A', 'COMP3278', 'Sunday', '23:10', '23:40', 'MWT2', 'https://hku.zoom.us/j/96226740999?pwd=ZER1UUdxSVVhQzNXbXFkUDd3WjRBdz09'),
('A', 'COMP3230', 'Tuesday', '10:30', '12:20', 'CPD-LG.01', 'https://hku.zoom.us/rec/share/dFiU-ic0nH8P6wuB1UeocvO-9ikjf9aWZRCZ0bEBSnSMOoZswvTdlyyXlPIcPJUe.Tiy1retiylJzYUqy'),
('A', 'COMP3230', 'Sunday', '22:30', '23:00', 'CPD-LG.01', 'https://hku.zoom.us/rec/share/dFiU-ic0nH8P6wuB1UeocvO-9ikjf9aWZRCZ0bEBSnSMOoZswvTdlyyXlPIcPJUe.Tiy1retiylJzYUqy'),
('A', 'COMP3230', 'Thursday', '10:30', '12:20', 'CYPP2', 'https://hku.zoom.us/rec/share/rxQkV5qC5cKvF4psOFDUiQXXbXrccKlDfSb5OFohnnSKnv1Cn4ayZ1mrB-yvALLg.OQ2Ia3-JEzVJoGf9'),
('A', 'COMP3322', 'Monday', '15:30', '17:20', 'CPD-LG.1', 'https://hku.zoom.us/rec/share/rxQkV5qC5cKvF4psOFDUiQXXbXrccKlDfSb5OFohnnSKnv1Cn4ayZ1mrB-yvALLg.OQ2Ia3-JEzVJoGf9'),
('A', 'COMP3322', 'Friday', '15:30', '17:20', 'CPD-LG.1', 'https://hku.zoom.us/rec/share/rxQkV5qC5cKvF4psOFDUiQXXbXrccKlDfSb5OFohnnSKnv1Cn4ayZ1mrB-yvALLg.OQ2Ia3-JEzVJoGf9'),
('A', 'CCCH9047', 'Wednesday', '16:30', '18:20', 'TBC', 'https://hku.zoom.us/rec/share/rxQkV5qC5cKvF4psOFDUiQXXbXrccKlDfSb5OFohnnSKnv1Cn4ayZ1mrB-yvALLg.OQ2Ia3-JEzVJoGf9'),
('A', 'COMP3297', 'Tuesday', '09:30', '10:20', 'CYPP2', 'https://hku.zoom.us/rec/share/rxQkV5qC5cKvF4psOFDUiQXXbXrccKlDfSb5OFohnnSKnv1Cn4ayZ1mrB-yvALLg.OQ2Ia3-JEzVJoGf9'),
('A', 'COMP3297', 'Friday', '09:30', '11:20', 'CYPP2', 'https://hku.zoom.us/rec/share/rxQkV5qC5cKvF4psOFDUiQXXbXrccKlDfSb5OFohnnSKnv1Cn4ayZ1mrB-yvALLg.OQ2Ia3-JEzVJoGf9'),
('A', 'COMP3270', 'Tuesday', '12:30', '13:20', 'CYCP1', 'https://hku.zoom.us/j/97433800177?pwd=T2hSWEdqWitDQ1dUUXJ4MGQ4OENJZz09'),
('A', 'COMP3270', 'Friday', '12:30', '14:20', 'CYCP1', 'https://hku.zoom.us/j/97433800177?pwd=T2hSWEdqWitDQ1dUUXJ4MGQ4OENJZz09'),
('A', 'CCHU9060', 'Wednesday', '12:30', '14:20', 'MWT1', 'https://hku.zoom.us/j/94195395496?pwd=alRoeHcxL1hkSk5Pc1FkWUdaajQyZz09'),
('A', 'STAT3600', 'Tuesday', '13:30', '16:20', 'LE2', 'https://hku.zoom.us/rec/play/F7st-acHi63Jtw2moBHNyRKMlmGqgxqoyAedH1wvH2WO6znSeiWE2AoofzCfHE23UEEYLYsJoM1SJYhV.E3dZQRrPAVhgRv58?continueMode=true');

INSERT INTO SubclassEvent VALUES
(NULL, 'COMP3230', 'A', 'assignment', 'Assignment 1', 'https://drive.google.com/file/d/1OVXQOi7xnrFEQh3DBwINmMvjfkc4lB3X/view?usp=share_link', '2022-09-28 13:00', NULL),
(NULL, 'COMP3230', 'A', 'quiz', 'Quiz 1', 'https://drive.google.com/file/d/1dkiN2RbVxNNs4ZAyMeSF4wtanO3Pp_Iq/view?usp=share_link', '2022-10-18 14:25', NULL),
(NULL, 'COMP3230', 'A', 'lecture_note', 'Lecture 0', 'https://drive.google.com/file/d/1RZDgno2RrHm2NzqFedqlIRhPW7-NChQs/view?usp=share_link', '2022-09-04 09:30', NULL),
(NULL, 'COMP3230', 'A', 'tutorial_note', 'Tutorial 1', 'https://drive.google.com/file/d/1RRI-QN-yeA--PC9-YnBny4RnSfSPTs38/view?usp=share_link', '2022-09-08 11:30', NULL),
(NULL, 'CCHU9060', 'A', 'tutorial_note', 'Tutorial 3', 'https://drive.google.com/file/d/1GGXfvKMIRnzFWXNhLSqiaFOsmiT5SzgH/view?usp=share_link', '2022-10-02 14:30', NULL),
(NULL, 'COMP3270', 'A', 'assignment', 'Assignment 1', 'https://drive.google.com/file/d/10g7sqqesh-fgfxkl1C_NeLsy9R07QCSj/view?usp=share_link', '2022-10-22 17:50', NULL),
(NULL, 'COMP3270', 'A', 'tutorial_note', 'Tutorial 1', 'https://drive.google.com/file/d/1JMw_a31umY0OjrFmbYjKuJkgenL3wqhj/view?usp=share_link', '2022-10-15 12:30', NULL),
(NULL, 'COMP3278', 'A', 'assignment', 'Assignment 1', 'https://drive.google.com/file/d/1UcHXeAM1zlMlAcTvKYn4L-q6RElGAapk/view?usp=share_link', '2022-11-02 10:20', NULL),
(NULL, 'COMP3278', 'A', 'lecture_note', 'Lecture 1', 'https://drive.google.com/file/d/1WpTf6581Rv6_wkSWcBzzjNGEGbU_ILOW/view?usp=share_link', '2022-09-05 9:30', NULL),
(NULL, 'COMP3278', 'A', 'lecture_note', 'Lecture 2', 'https://drive.google.com/file/d/1WpTf6581Rv6_wkSWcBzzjNGEGbU_ILOW/view?usp=share_link', '2022-09-10 10:30', NULL),
(NULL, 'COMP3278', 'A', 'lecture_note', 'Lecture 3', 'https://drive.google.com/file/d/1WpTf6581Rv6_wkSWcBzzjNGEGbU_ILOW/view?usp=share_link', '2022-09-13 11:30', NULL),
(NULL, 'COMP3278', 'A', 'tutorial_note', 'Tutorial 1', 'https://drive.google.com/file/d/1Vf1f9yHnrzCGj5bzLj_omXVuNAIAlOto/view?usp=share_link', '2022-09-10 15:30', NULL),
(NULL, 'COMP3297', 'A', 'lecture_note', 'Lecture 0', 'https://drive.google.com/file/d/13FGvKz7vQcreu5OYWxDcwK9DN9A3R7cd/view?usp=share_link', '2022-09-04 11:00', NULL),
(NULL, 'COMP3297', 'A', 'quiz', 'Quiz 1', 'https://drive.google.com/file/d/1MA1Ix2DhCEkINHlCD667urvTvu-d89j-/view?usp=share_link', '2022-10-25 19:50', NULL),
(NULL, 'COMP3297', 'A', 'tutorial_note', 'Tutorial 1', 'https://drive.google.com/file/d/1bEclgIpmZbjmtp5HiLsL8hsN9sWBTT6y/view?usp=share_link', '2022-09-14 08:35', NULL),
(NULL, 'STAT3600', 'A', 'assignment', 'Assignment 1', 'https://drive.google.com/file/d/1pI85x9bx1LN__up5H-RxZu6ctS79rSV6/view?usp=share_link', '2022-09-30 00:00', NULL),
(NULL, 'STAT3600', 'A', 'lecture_note', 'Lecture 1', 'https://drive.google.com/file/d/1ry3vVF7fWdl3F1iGzfG_UebSMkAjbQM8/view?usp=share_link', '2022-09-04 09:30', NULL),
(NULL, 'STAT3600', 'A', 'tutorial_note', 'Tutorial 1', 'https://drive.google.com/file/d/1msYouHI6dYfluYedr8ewQBGxMZuuOamV/view?usp=share_link', '2022-09-11 15:59', NULL);

--if a student is already enrolled in course, can't enrolled in another subclass --
INSERT INTO StudentEnrollsSubclass VALUES
('CCCH9047', 'A', '3035555626', '2022-09-01'),
('COMP3230', 'A', '3035555626', '2022-09-01'),
('STAT3600', 'A', '3035555626', '2022-09-01'),
('COMP3278', 'A', '3035555626', '2022-09-01'),
('COMP3297', 'A', '3035604075', '2022-09-01'),
('COMP3297', 'A', '3035555626', '2022-09-01'),
('COMP3270', 'A', '3035604075', '2022-09-01'),
('CCHU9060', 'A', '3035604075', '2022-09-01'),
('COMP3230', 'A', '3035786603', '2022-09-01'),
('COMP3278', 'A', '3035786603', '2022-09-01'),
('STAT3600', 'A', '3035604075', '2022-09-01');

-- INSERT INTO StudentEnrollsSubclass VALUES ('COMP3258', 'A', '3035729423', '2022-08-29');

-- INSERT INTO Logging VALUES
-- (NULL, '3035435840', '2022-09-06 00:28:51', NULL, NULL),
-- (NULL, '3035555626', '2022-10-07 13:25:54', '2022-10-07 13:28:42', NULL),
-- (NULL, '3035604075', '2022-11-02 09:30:00', '2022-11-02 11:30:00', NULL),
-- (NULL, '3035729423', '2022-10-01 17:05:19', '2022-10-01 17:15:30', NULL);
-- INSERT INTO Logging VALUES (5, '3035729423', '2022-10-01 17:05:19', '2022-10-01 17:15:30', "TEMPTOKEN");
-- INSERT INTO Logging VALUES (6, '3035729423', '2022-9-01 17:05:19', NULL, "TEMPTOKEN");

-- -- We can't have a student doing any activity if not enrolled in the course
-- INSERT INTO EmailActivity VALUES
-- (NULL, '3035435840', 'COMP3230', 'A', '2022-09-08 06:24:51'),
-- (NULL, '3035604075', 'COMP3258', 'A', '2022-10-27 16:55:30');

-- INSERT INTO RedirectionActivity VALUES
-- (NULL, '3035604075', 'zoom_link', '2022-09-22 09:11:41'),
-- (NULL, '3035555626', 'lecture_note', '2022-10-22 00:19:35'),
-- (NULL, '3035435840', 'tutorial_note', '2022-10-22 00:19:35'),
-- (NULL, '3035435840', 'assignment', '2022-09-03 19:21:51'),
-- (NULL, '3035604075', 'quiz', '2022-11-01 23:59:59');

insert into
    LocationMeta
values
    (NULL, 'MWT2'),
    (NULL, 'CYPP2'),
    (NULL, 'CYCP1'),
    (NULL, 'LE2'),
    (NULL, 'CPD-LG.1');

insert into
    PathTime
values
    ('3035555626', 1, 3, 1, 300),
    ('3035604075', 1, 3, 1, 330),
    ('3035786603', 1, 3, 1, 300),
    ('3035555626', 1, 3, 2, 100300),
    ('3035604075', 1, 3, 2, 100330),
    ('3035786603', 1, 3, 2, 100300),
    ('3035555626', 3, 4, 1, 300),
    ('3035604075', 3, 1, 1, 0),
    ('3035786603', 1, 4, 1, 300),
    ('3035786603', 4, 5, 1, 5000);