import mysql.connector

class DBConnector:
    def __init__(self, host, user, password, database):
        self.host = host
        self.user = user
        self._password = password
        self.database = database
        self.db = None
        self.cursor = None

        self.connect_db()

    def connect_db(self):
        self.db = mysql.connector.connect(
            host=self.host,
            user=self.user,
            password=self._password,
            database=self.database
        )

        self.cursor = self.db.cursor()

    @property
    def get_db(self):
        return self.db

    @property
    def get_cursor(self):
        return self.cursor


