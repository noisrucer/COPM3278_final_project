import configparser

config = configparser.ConfigParser()
try:
    with open('backend/backend.ini') as f:
        config.read_file(f)
except IOError:
    raise ValueError(
        'Please modify and copy backend.ini to backend/backend.ini')