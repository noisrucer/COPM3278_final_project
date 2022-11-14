# The University of Hong Kong

## COMP3278 Final Project

### Team members

- Changjin Lee
- Yonghyun Kwon
- Yeon Park
- Sam

### Environment

``` shell
pip install fastapi "uvicorn[standard]" mysql-connector-python
```

### Start backend by

``` shell
python .\backend\main.py
```

### To train face recognition model
1. Go to the root directory of the project
2. Change `user_name = "[YOUR NAME]"` in `FaceRecognition/face_capture.py`
3. Start capturing your faces by
```shell
python3 FaceRecognition/face_capture.py
```
4. Train the model by
```shell
python3 FaceRecognition/train.py
```
5. Then, `train.yml` and `labels.pickle` will be created in `FaceRecognition/` directory
6. Complete!
