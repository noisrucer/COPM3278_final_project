import cv2

from db_connector import DBConnector
from face_recognizer import FaceRecognizer

img = cv2.imread('./data/Yonghyun Kwon/Yonghyun Kwon327.jpg')
img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
print(img_rgb.shape)

db_connector = DBConnector(
    user="root",
    host="localhost",
    password="Ckdwls1541*",
    database="COMP3278_fp"
)

WEIGHT_PATH = "./train.yml"
LABELS_PATH = "./labels.pickle"
recognizer = FaceRecognizer(
    weight_path=WEIGHT_PATH,
    labels_path=LABELS_PATH,
    db_conn=db_connector,
    conf_thresh=60
)

recognizer.recognize_img(img_rgb)

