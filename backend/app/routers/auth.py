import base64
from PIL import Image
import numpy as np
import io
from pydantic import BaseModel

from fastapi import APIRouter, Depends

from FaceRecognition.face_recognizer import FaceRecognizer
from backend.app.db import db_connector, db_cursor

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
    
    response_msg = recognizer.recognize_img(img_np)
    json_response = {
        "login_status": False,
        "student_id": None,
        "login_token": None
    }
    
    if response_msg['status'] == "fail":
        return json_response
    
    json_response.update(**response_msg['data'])
    
    return json_response
    
    
    
    
    
    
