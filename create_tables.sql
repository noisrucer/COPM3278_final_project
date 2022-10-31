CREATE TABLE Student (
    student_id VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    gender VARCHAR(1) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY(student_id)
);

CREATE TABLE Course (
    course_id VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(2000) NOT NULL,
    PRIMARY KEY(course_id)
);
CREATE TABLE Subclass (
    subclass_id VARCHAR(100) NOT NULL,
    course_id VARCHAR(100) NOT NULL,
    time1 VARCHAR(100) NOT NULL,
    time2 VARCHAR(100) NOT NULL,
    address1 VARCHAR(100) NOT NULL,
    address2 VARCHAR(100) NOT NULL,
    teacher_message VARCHAR(800) NOT NULL,
    zoom_link VARCHAR(500) NOT NULL,
    PRIMARY KEY(subclass_id, course_id),
    FOREIGN KEY(course_id) REFERENCES Course(course_id)
);

CREATE TABLE SubclassEvent(
    subclass_event_id INT NOT NULL  ,
    course_id VARCHAR(100) NOT NULL, 
    subclass_id VARCHAR(100) NOT NULL,
    type ENUM('lecture_note', 'tutorial_note', 'assignment', 'quiz') NOT NULL,
    name VARCHAR(100) NOT NULL,
    hyperlink VARCHAR(500) NOT NULL,
    PRIMARY KEY(subclass_event_id, course_id, subclass_id), 
    FOREIGN KEY(course_id) REFERENCES Course(course_id),
    FOREIGN KEY(subclass_id) REFERENCES Subclass(subclass_id)
);

CREATE TABLE StudentEnrollsSubclass(
    course_id VARCHAR(100) NOT NULL,
    subclass_id VARCHAR(100) NOT NULL,
    student_id VARCHAR(100) NOT NULL,
    enroll_date DATE NOT NULL,
    PRIMARY KEY(course_id, subclass_id, student_id),
    FOREIGN KEY(course_id) REFERENCES Course(course_id),
    FOREIGN KEY(student_id) REFERENCES Student(student_id),
    FOREIGN KEY(subclass_id) REFERENCES Subclass(subclass_id)
);

CREATE TABLE Logging(
    logging_id INT NOT NULL  ,
    student_id VARCHAR(100) NOT NULL,
    login_time DATETIME NOT NULL,
    logout_time DATETIME,
    PRIMARY KEY(logging_id),
    FOREIGN KEY(student_id) REFERENCES Student(student_id)
);

CREATE TABLE EmailActivity(
    email_activity_id INT NOT NULL  ,
    student_id VARCHAR(100) NOT NULL,
    action_date DATETIME NOT NULL,
    PRIMARY KEY(email_activity_id),
    FOREIGN KEY(student_id) REFERENCES Student(student_id)
);

CREATE TABLE RedirectionActivity(
    redirection_activity_id INT NOT NULL  ,
    student_id VARCHAR(100) NOT NULL,
    type ENUM('zoom_link', 'lecture_note', 'tutorial_note', 'assignment', 'quiz') NOT NULL,
    action_date DATETIME NOT NULL,
    PRIMARY KEY(redirection_activity_id),
    FOREIGN KEY(student_id) REFERENCES Student(student_id)
);
