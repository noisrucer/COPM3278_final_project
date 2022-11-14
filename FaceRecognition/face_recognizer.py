import urllib
import numpy as np
import mysql.connector
import cv2
import pyttsx3
import pickle
from datetime import datetime
import sys
from uuid import uuid4
# from db_connector import DBConnector

# # 1 Create database connection
# db_conn = DBConnector(
#     host="localhost",
#     user="root",
#     password="Ckdwls1541*",
#     database="comp3278_fp"
# )
WEIGHT_PATH = "./train.yml"
LABELS_PATH = "FaceRecognition/labels.pickle"

class FaceRecognizer:
    def __init__(self, db_conn, db_cursor, conf_thresh=60):
        self.conf_thresh = conf_thresh
        self.recognizer = cv2.face.LBPHFaceRecognizer_create()
        self.recognizer.read("FaceRecognition/train.yml")
        self.cursor = db_cursor
        self.engine = pyttsx3.init()
        self.labels = {}
        self.rate = None

        # Define camera and detect face
        self.face_cascade = cv2.CascadeClassifier('/Users/jasonlee/Desktop/HKU/COMP3278/COPM3278_final_project/FaceRecognition/haarcascade/haarcascade_frontalface_default.xml')
        self.setup()
        

    def setup(self):
        
        with open(LABELS_PATH, "rb") as f:
            self.labels = pickle.load(f)
            self.labels = {v: k for k, v in self.labels.items()}

        self.rate = self.engine.getProperty("rate")
        self.engine.setProperty('rate', 175)


    def recognize_img(self, img):
        '''
        img: numpy RGB array
        '''
        response_msg = None

        gray = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)
        print(gray)
        faces = self.face_cascade.detectMultiScale(gray)
        print(faces)

        for (x, y, w, h) in faces:
            roi_gray = gray[y:y + h, x:x + w]
            roi_color = img[y:y + h, x:x + w]
            print(roi_gray)
            print(roi_gray.shape)
            
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
                data = "error"

                for x in result:
                    data = x

                
                # If the student's information is not found in the database
                if data == "error":
                    student_not_found_msg = f"The student", {current_name}, "is NOT FOUND in the database."
                    response_msg = {
                        "status": "fail",
                        "message": student_not_found_msg,
                        "data": None
                    }

                # If the student's information is found in the database
                else:
                    hello = f"Hello, {current_name}, You did attendance today"
                    response_msg = {
                        "status": "success",
                        "message": hello,
                        "data": {
                            "login_status": "success",
                            "student_id": data[0],
                            "login_token": uuid4()
                        }
                    }
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
                response_msg = {
                        "status": "fail",
                        "message": "Failed to recognize face",
                        "data": None
                    }
                color = (255, 0, 0)
                stroke = 2
                font = cv2.QT_FONT_NORMAL
                cv2.putText(img, "UNKNOWN", (x, y), font, 1, color, stroke, cv2.LINE_AA)
                cv2.rectangle(img, (x, y), (x + w, y + h), (255, 0, 0), (2))
                hello = ("Your face is not recognized")
                print(hello)
                #  self.engine.say(hello)
                # engine.runAndWait()
                
        return response_msg



