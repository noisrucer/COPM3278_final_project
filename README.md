# The University of Hong Kong

## COMP3278 Final Project

### Team members

- Changjin Lee
- Yonghyun Kwon
- Yeon Park
- Sam

### Environment

0. Go to COMP3278_final_project directory

1. Install backend requirements by

```shell
pip install fastapi "uvicorn[standard]"
python -m pip install -r requirements.txt
```

2. Install frontend requiremnts by first going to the `COMP3278_final_project/frontend/` then run

```shell
npm install --force
```

4. Make sure to put the appropriate DB information in `/backend.ini` and **COPY** it to `/backend/` directory

```shell
cp backend.ini backend/backend.ini
```

### Start backend by

- Go to the root directory (`COMP3278_final_project/`) of the project and run

```shell
uvicorn backend.app.api:app --reload
```

### Start frotnend by

- Go to `COMP3278_final_project/frontend` and run `npm start`

### To train face recognition model

1. Make sure you put the `haarcascade_frontalface_default.xml` file in `COMP3278_final_project/FaceRecognition/haarcascade` directory.

2. Make sure you change the path to `haarcascade_frontalface_default.xml` to **ABSOLUTE PATH** in `FaceRecognition/face_capture.py` and `FaceRecognition/face_recognizer.py`

3. Go to the root directory of the project
4. Change `user_name = "[YOUR NAME]"` in `FaceRecognition/face_capture.py`
5. Start capturing your faces by

```shell
python FaceRecognition/face_capture.py
```

6. Train the model by

```shell
python FaceRecognition/train.py
```

7. Then, `train.yml` and `labels.pickle` will be created in `FaceRecognition/` directory
