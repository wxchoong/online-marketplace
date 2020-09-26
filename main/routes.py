from main import app, cursor, db
from flask import render_template, request, json, jsonify, flash, redirect, url_for, session
from passlib.hash import sha256_crypt
from functools import wraps
from datetime import datetime
from wtforms import Form, IntegerField, StringField, TextAreaField, PasswordField, validators

#--------------------------------Routes---------------------------------------#

#Index Page
@app.route('/')
def index():
    ### check for Session.
    # if 'user' in session
    return render_template('index.html')
    #else:
    #return redirect(url_for('login'))

#Login Page
@app.route('/login', methods=['GET', 'POST'])
def login():				
	#Retrieve user inputs from form
	if request.method == 'POST':
		login_username = request.form['username']
		login_password = request.form['password']
		
		#Query relevant user from database 
		#current_user = User.query.filter_by(username=login_username).first()
		user_query = "SELECT * FROM user WHERE username=%s;"
		cursor.execute(user_query, login_username)
		current_user = cursor.fetchall()
		
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

#Products (based on Category) Page
@app.route('/categories/<string:cat>')
def categories(cat):
	return render_template('category.html', cat_id=cat)

#Product Details Page
@app.route('/products/<string:id>')
def products(id):
	return render_template('products.html', prod_id=id)

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
			cursor.close()
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

#APIs for registering new user
@app.route('/register', methods=['GET', 'POST'])
def register():
    cursor = db.cursor()
    email = request.form['cust_email']
    firstName = request.form['cust_firstName']
    lastName = request.form['cust_lastName']
    contact = request.form['cust_phone']
    pwd = request.form['cust_pwd']
    addr = request.form['cust_addr']
    postal = request.form['cust_postal']
    parse = (email, firstName, lastName, contact, pwd, addr, postal)
    cursor.callproc('sp_registration', parse)
    cursor.close()
    
    print("registerd")
    return jsonify(email)

#--------------------------------------------------------------------------#
