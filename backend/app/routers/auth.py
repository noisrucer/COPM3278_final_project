import base64
from PIL import Image
import numpy as np
import io
from pydantic import BaseModel
from datetime import datetime

from fastapi import APIRouter, Depends

from FaceRecognition.face_recognizer import FaceRecognizer
from backend.app.db import db_connector, db_cursor
from .. import crud

router = APIRouter(
    prefix="/auth",
    tags=["auth"]
)

class LoginIn(BaseModel):
    base64_encoded_img: str
    
@router.post('/login')
async def login(login_input: LoginIn):
    # print(login_input)
    encoded_img_start_idx = login_input.base64_encoded_img.find(',')
    encoded_img_str = login_input.base64_encoded_img[encoded_img_start_idx + 1:]
    base64_decoded = base64.b64decode(encoded_img_str)
    img = Image.open(io.BytesIO(base64_decoded))
    img_np = np.array(img)
    
    recognizer = FaceRecognizer(
        db_conn=db_connector,
        db_cursor=db_cursor,
        conf_thresh=60
    )
    
    img, response_msg = recognizer.recognize_img(img_np)
    json_response = {
        "login_status": False,
        "student_id": None,
        "login_token": None
    }
    
    if response_msg['status'] == "fail":
        return json_response
    
    json_response.update(**response_msg['data'])
    student_id = response_msg['data']['student_id']
    student_name = crud.get_student_name_by_student_id(student_id)[0][0][0]
    json_response.update({"student_name": student_name})
    current_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    sql = f"INSERT INTO Logging (logging_id, student_id, login_time, logout_time, login_token) VALUES (NULL, '{json_response['student_id']}', '{current_time}', NULL, '{json_response['login_token']}');"
    db_cursor.execute(sql)
    db_connector.commit()
    
    # find_student_sql = f"SELECT name FROM Student WHERE student_id='{response_msg['data']['student_id']}';"
    # print(find_student_sql)
    # student_name = db_cursor.execute(find_student_sql)
    # db_connector.commit()
    # print("student_name: {}".format(student_name))
    # json_response.update({"student_name": student_name})
    current_time = datetime.now().strftime("%H:%M:%S")
    json_response.update({"login_time": current_time})
    
    return json_response
    
    
class LogOut(BaseModel):
    login_token: str
    
@router.post('/logout')
async def logout(logout_input: LogOut):
    login_token = logout_input.login_token
    print("login_token: {}".format(login_token))
    logout_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print("logout_time: {}".format(logout_time))
    print(type(login_token))
    print(type(logout_time))
    sql = f"UPDATE Logging SET logout_time='{logout_time}' WHERE login_token = '{login_token}';";
    print(sql)
    db_cursor.execute(sql)
    db_connector.commit()
    # crud.logout(login_token, logout_time)
    
   
