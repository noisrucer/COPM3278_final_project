# The University of Hong Kong

## COMP3278 Final Project

### Team members

- Changjin Lee
- Yonghyun Kwon
- Yeon Park
- Sam

### Environment

1. Install all the packages listed out in the tutorial (face recognition tutorial)
2. Install fastapi by

```shell
pip install fastapi "uvicorn[standard]" mysql-connector-python
```

3. Install other requirements by

```shell
pip install -r requirements.txt
```

4. Make sure to put the appropriate DB information in `/backend.ini` and **COPY** it to `/backend/` directory

```shell
cp backend.ini backend/backend.ini
```

### Start backend by

```shell
uvicorn backend.app.api:app --reload
```

### To train face recognition model

1. Go to the root directory of the project
2. Change `user_name = "[YOUR NAME]"` in `FaceRecognition/face_capture.py`
3. Start capturing your faces by

```shell
python FaceRecognition/face_capture.py
```

4. Train the model by

```shell
python FaceRecognition/train.py
```

5. Then, `train.yml` and `labels.pickle` will be created in `FaceRecognition/` directory
6. Complete!
