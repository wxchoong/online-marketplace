from flask import Flask
import mysql.connector as mysql
app = Flask(__name__)

#--------------------------------SQL---------------------------------------#

db = mysql.connect(
    host = "localhost",
    user = "root",
    passwd = "root",
	database = "marketplace"
)
cursor = db.cursor(dictionary=True)

from main import routes