-- Active: 1667122590589@@127.0.0.1@3306@final_project
CREATE TABLE Student (
    student_id  INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    gender VARCHAR(1) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY(student_id)
);
CREATE TABLE Course (
    course_id  INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    description VARCHAR(800) NOT NULL,
    PRIMARY KEY(course_id)
);
CREATE TABLE Subclass (
    subclass_id INT NOT NULL AUTO_INCREMENT,
    course_id INT NOT NULL,
    time DATETIME NOT NULL,
    address VARCHAR(100) NOT NULL,
    teacher_message VARCHAR(800) NOT NULL,
    zoom_link VARCHAR(500) NOT NULL,
    PRIMARY KEY(subclass_id, course_id),
    FOREIGN KEY(course_id) REFERENCES Course(course_id)
);

CREATE TABLE SubclassEvent(
    subclass_event_id INT NOT NULL AUTO_INCREMENT,
    course_id INT NOT NULL, 
    subclass_id INT NOT NULL,
    type ENUM('lecture_note', 'tutorial_note', 'assignment', 'quiz') NOT NULL,
    name VARCHAR(100) NOT NULL,
    hyperlink VARCHAR(500) NOT NULL,
    PRIMARY KEY(subclass_event_id, course_id, subclass_id), 
    FOREIGN KEY(course_id) REFERENCES Course(course_id),
    FOREIGN KEY(subclass_id) REFERENCES Subclass(subclass_id)
);

CREATE TABLE StudentEnrollsCourse(
    course_id INT NOT NULL,
    student_id INT NOT NULL,
    enroll_date DATETIME NOT NULL,
    PRIMARY KEY(course_id, student_id),
    FOREIGN KEY(course_id) REFERENCES Course(course_id),
    FOREIGN KEY(student_id) REFERENCES Student(student_id)
);

CREATE TABLE Logging(
    logging_id INT NOT NULL AUTO_INCREMENT,
    student_id INT NOT NULL,
    login_time DATETIME NOT NULL,
    logout_time DATETIME,
    PRIMARY KEY(logging_id),
    FOREIGN KEY(student_id) REFERENCES Student(student_id)
);

CREATE TABLE EmailActivity(
    email_activity_id INT NOT NULL AUTO_INCREMENT,
    student_id INT NOT NULL,
    action_date DATETIME NOT NULL,
    PRIMARY KEY(email_activity_id),
    FOREIGN KEY(student_id) REFERENCES Student(student_id)
);

CREATE TABLE RedirectionActivity(
    redirection_activity_id INT NOT NULL AUTO_INCREMENT,
    student_id INT NOT NULL,
    type ENUM('zoom link', 'lecture_note', 'tutorial_note', 'assignment', 'quiz') NOT NULL,
    action_date DATETIME NOT NULL,
    PRIMARY KEY(redirection_activity_id),
    FOREIGN KEY(student_id) REFERENCES Student(student_id)
);
