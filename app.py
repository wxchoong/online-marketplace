from flask import Flask, render_template, request, json, jsonify, flash, redirect, url_for, session
from passlib.hash import sha256_crypt
from functools import wraps
from datetime import datetime
from wtforms import Form, IntegerField, StringField, TextAreaField, PasswordField, validators
import mysql.connector as mysql

app = Flask(__name__)

db = mysql.connect(
    host = "localhost",
    user = "root",
    passwd = "root",
	database = "marketplace"
)
cursor = db.cursor(dictionary=True)

#Create table for sales order and sales items 
cursor.execute("""CREATE TABLE IF NOT EXISTS tabSales_Order(
	id INT AUTO_INCREMENT NOT NULL,
	creation_datetime DATETIME(6) NOT NULL,
	customer_name VARCHAR(140),
	customer_address VARCHAR(140),
	customer_phone_no VARCHAR(140),
	shipper_name VARCHAR(140),
	shipper_address VARCHAR(140),
	shipper_phone_no VARCHAR(140),
	personalised_msg VARCHAR(140),
	attrib_01 VARCHAR(140),
	PRIMARY KEY(id)
	);""")

cursor.execute("""CREATE TABLE IF NOT EXISTS tabSales_Order_Item(
	id INT AUTO_INCREMENT NOT NULL,
	creation_datetime DATETIME(6) NOT NULL,
	parent_id INT NOT NULL,
	item_code VARCHAR(140) NOT NULL,
	quantity INT NOT NULL,
	mfr VARCHAR(140),	
	PRIMARY KEY(id),
	FOREIGN KEY(parent_id) REFERENCES tabSales_Order(id)
	);""")

#--------------------------------Routes---------------------------------------#

#Index Page
@app.route('/')
def index():
    return render_template('index.html')

#Login Page
@app.route('/login', methods=['GET', 'POST'])
def login():				
	#Retrieve user inputs from form
	if request.method == 'POST':
		login_username = request.form['username']
		login_password = request.form['password']
		
		#Query relevant user from database 
		current_user = User.query.filter_by(username=login_username).first()
		
		#Verify user id and password if user exists
		if current_user > 0:
			pwd = current_user.password

			#Login successful
			if sha256_crypt.verify(login_password, pwd):
				session['logged_in'] = True
				session['username'] = login_username
				flash('You are now logged in','success')
				
				#Redirect based on user role (admin/customer)
				if(session['username'] == 'admin'):
					return redirect(url_for('index'))
				else:
					return redirect(url_for('index'))	
			#Login invalid			
			else:
				error = 'Invalid login'
				return render_template('login.html',error=error)	
		#User not found		
		else:
			error = 'Username not found'
			return render_template('login.html',error=error)
			
	return render_template('login.html')

#Register Page
@app.route('/signup', methods=['GET', 'POST'])
def signup():
	return render_template('signup.html')

#Cart Page
@app.route('/cart')
def cart():
	return render_template('cart.html')

#Checkout
@app.route('/checkout', methods=['GET','POST'])
def order():
	session.clear()

	#New Order Submitted
	if request.method == 'POST':

		#Get field values from form
		creation = datetime.now()
		cust_name = request.form['cust-name']
		cust_addr = '1 Expo Drive, Singapore 486150'
		cust_phone = '12345678'
		shipper_name = 'NUS Marketplace'
		shipper_addr = '21 Lower Kent Ridge Rd, Singapore 119077'
		shipper_phone = '12345678'
		message = request.form['message']
		attribute = ''

		#Insert to table 'tabSales_Order'
		order_query = """INSERT INTO tabSales_Order(creation_datetime, customer_name,
		customer_address, customer_phone_no, shipper_name, shipper_address, shipper_phone_no, 
		personalised_msg, attrib_01) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"""

		order_values = (creation,cust_name,cust_addr,cust_phone,shipper_name,
		shipper_addr,shipper_phone,message,attribute)

		cursor.execute(order_query, order_values)
		db.commit()

		#Return the auto-generated ID for latest order
		cursor.execute("SELECT MAX(id) FROM tabSales_Order;")
		data = cursor.fetchall()
		order_id = data[0]['MAX(id)']

		#Insert to table 'tabSales_Order_Item'
		products = request.form.getlist('checkbox')
		for product in products:
			parent_dt = creation
			parent_id = order_id
			item_code = product
			quantity = '1'
			mfr = ''

			item_query = """INSERT INTO tabSales_Order_Item(creation_datetime, parent_id, 
			item_code, quantity, mfr) VALUES (%s, %s, %s, %s, %s)"""

			item_values = (parent_dt, parent_id, item_code, quantity, mfr)

			cursor.execute(item_query, item_values)
			db.commit()

		str_id = "SO-" + str(order_id).zfill(6)
		session['cust_name'] = cust_name
		flash('Your order is successfully submitted.', 'success')	
	return redirect(url_for('confirmation', id=str_id))

#Order Successful Page
@app.route('/confirmation/<string:id>')
def confirmation(id):
	wait_time = 10
	return render_template('confirmation.html', order_id=id, wait_time=wait_time)

#--------------------------------APIs---------------------------------------#
#APIs for getting data
@app.route('/get-all-orders', methods=['GET', 'POST'])
def result():
	cursor.execute("SELECT * FROM tabSales_Order")

	# fetching all records from the 'cursor' object
	data = cursor.fetchall()
	return jsonify(data)


if __name__ == '__main__':
	app.secret_key = 'db123456'
	app.run(host='0.0.0.0', debug=True)