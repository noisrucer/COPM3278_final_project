CREATE TABLE Student (
    student_id VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    gender VARCHAR(1) NOT NULL,
    age INT NOT NULL,
    email_address VARCHAR(250) NOT NULL,
    PRIMARY KEY(student_id)
);

CREATE TABLE Course (
    course_id VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(2000) NOT NULL,
    PRIMARY KEY(course_id)
);

--stime and etime should start counting from 1970-06-01--
--e.g. 1970-06-05 14:30 for FRI 14:30--
CREATE TABLE Subclass (
    subclass_id VARCHAR(100) NOT NULL,
    course_id VARCHAR(100) NOT NULL,
    stime TIMESTAMP NOT NULL,
    etime TIMESTAMP NOT NULL,
    repeat_weekly TINYINT NOT NULL DEFAULT 1,
    class_loca VARCHAR(100) NOT NULL,
    teacher_message VARCHAR(800) NOT NULL,
    zoom_link VARCHAR(500) NOT NULL,
    PRIMARY KEY(subclass_id, course_id, stime, etime, repeat_weekly),
    FOREIGN KEY(course_id) REFERENCES Course(course_id)
);

CREATE TABLE SubclassEvent(
    subclass_event_id INT NOT NULL,
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
    logging_id INT NOT NULL,
    student_id VARCHAR(100) NOT NULL,
    login_time DATETIME NOT NULL,
    logout_time DATETIME,
    login_token VARCHAR(300),
    PRIMARY KEY(logging_id),
    FOREIGN KEY(student_id) REFERENCES Student(student_id)
);

CREATE TABLE EmailActivity(
    email_activity_id INT NOT NULL  ,
    student_id VARCHAR(100) NOT NULL,
    course_id VARCHAR(100) NOT NULL,
    subclass_id VARCHAR(100) NOT NULL,
    action_date DATETIME NOT NULL,
    PRIMARY KEY(email_activity_id),
    FOREIGN KEY(course_id) REFERENCES Course(course_id),
    FOREIGN KEY(subclass_id) REFERENCES StudentEnrollsSubclass(subclass_id),
    FOREIGN KEY(student_id) REFERENCES Student(student_id)
);

CREATE TABLE RedirectionActivity(
    redirection_activity_id INT NOT NULL,
    student_id VARCHAR(100) NOT NULL,
    type ENUM('zoom_link', 'lecture_note', 'tutorial_note', 'assignment', 'quiz') NOT NULL,
    action_date DATETIME NOT NULL,
    PRIMARY KEY(redirection_activity_id),
    FOREIGN KEY(student_id) REFERENCES Student(student_id)
);
