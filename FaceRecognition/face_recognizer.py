import urllib
import numpy as np
import mysql.connector
import cv2
import pyttsx3
import pickle
from datetime import datetime
import sys
from db_connector import DBConnector

# 1 Create database connection
db_conn = DBConnector(
    host="localhost",
    user="root",
    password="Ckdwls1541*",
    database="comp3278_fp"
)

class FaceRecognizer:
    def __init__(self, weight_path, labels_path, db_conn, conf_thresh=60):
        self.weight_path = weight_path
        self.labels_path = labels_path
        self.conf_thresh = conf_thresh
        self.recognizer = cv2.face.LBPHFaceRecognizer_create()
        self.engine = pyttsx3.init()
        self.labels = {}
        self.rate = None
        self.cursor = db_conn.cursor

        # Define camera and detect face
        self.face_cascade = cv2.CascadeClassifier('./haarcascade/haarcascade_frontalface_default.xml')
        self.setup()

    def setup(self):
        self.recognizer.read(self.weight_path)
        with open(self.labels_path, "rb") as f:
            labels = pickle.load(f)
            labels = {v: k for k, v in labels.items()}

        self.rate = self.engine.getProperty("rate")
        self.engine.setProperty('rate', 175)


    def recognize_img(self, img):
        '''
        img: numpy RGB array
        '''

        gray = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)
        faces = self.face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30), flags=cv2.CASCADE_SCALE_IMAGE)
        print(faces)

        for (x, y, w, h) in faces:
            roi_gray = gray[y:y + h, x:x + w]
            roi_color = img[y:y + h, x:x + w]
            # predict the id and confidence for faces
            id_, conf = self.recognizer.predict(roi_gray)

            # If the face is recognized
            print(conf)

            if conf > self.conf_thresh:
                # print(id_)
                # print(labels[id_])
                font = cv2.QT_FONT_NORMAL
                id = 0
                id += 1
                name = self.labels[id_]
                current_name = name
                color = (255, 0, 0)
                stroke = 2
                cv2.putText(img, name, (x, y), font, 1, color, stroke, cv2.LINE_AA)
                cv2.rectangle(img, (x, y), (x + w, y + h), (255, 0, 0), (2))

                # Find the student's information in the database.
                select = "SELECT student_id, name, gender, age FROM Student WHERE name='%s'" % (name)
                name = self.cursor.execute(select)
                result = self.cursor.fetchall()
                # print(result)
                data = "error"

                for x in result:
                    data = x

                # If the student's information is not found in the database
                if data == "error":
                    print("The student", current_name, "is NOT FOUND in the database.")

                # If the student's information is found in the database
                else:
                    print(result)
                    """
                    Implement useful functions here.
                    Check the course and classroom for the student.
                        If the student has class room within one hour, the corresponding course materials
                            will be presented in the GUI.
                        if the student does not have class at the moment, the GUI presents a personal class
                            timetable for the student.

                    """
                    # Update the data in database
                    # update =  "UPDATE Student SET login_date=%s WHERE name=%s"
                    # val = (date, current_name)
                    # cursor.execute(update, val)
                    # update = "UPDATE Student SET login_time=%s WHERE name=%s"
                    # val = (current_time, current_name)
                    # cursor.execute(update, val)
                    # myconn.commit()

                    hello = ("Hello ", current_name, "You did attendance today")
                    print(hello)
                    #  engine.say(hello)
                    # engine.runAndWait()
            else:
                color = (255, 0, 0)
                stroke = 2
                font = cv2.QT_FONT_NORMAL
                cv2.putText(img, "UNKNOWN", (x, y), font, 1, color, stroke, cv2.LINE_AA)
                cv2.rectangle(img, (x, y), (x + w, y + h), (255, 0, 0), (2))
                hello = ("Your face is not recognized")
                print(hello)
                #  self.engine.say(hello)
                # engine.runAndWait()



