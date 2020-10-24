from main import app, cursor, db
from functools import wraps
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
    if 'logged_in' in session:
    	return render_template('index.html', user=session['username'])
    else:
    	return render_template('index.html')


#Login Page
@app.route('/login', methods=['GET', 'POST'])
def login():			
	if 'logged_in' in session:
		return redirect(url_for('account'))
	else:
		# Retrieve user inputs from form
		if request.method == 'POST':
			try:
				login_email = request.form['input_email']
				login_password = request.form['input_pwd']
			
				# Query relevant user from database 
				user_query = "SELECT * FROM user_info WHERE email='" + login_email + "';"
				cursor.execute(user_query)
				current_user = cursor.fetchall()
			
				#Verify user id and password if user exists
				if current_user != None:
					pwd = current_user[0]['password']

					#Login successful
					if sha256_crypt.verify(login_password, pwd):
					# if login_password == pwd:
						session['logged_in'] = True
						session['username'] = current_user[0]['firstName']
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
			except Exception as e:
				print(e)
		return render_template('login.html')

# disallows access to pages if user is not logged in
def is_logged_in(f):
	@wraps(f)
	def wrap(*args, **kwargs):
		if 'logged_in' in session:
			return f(*args, **kwargs)
		else:
			flash('Unauthorized, Please log in','danger')
			return redirect (url_for('login'))
	return wrap

#Log out function and redirect to login page
@app.route('/logout')
def logout():
	session.clear()
	flash("You are now logged out",'success')
	return redirect(url_for('login'))

@app.route('/account')
def account():
	return render_template('account.html')

#Register Page
@app.route('/signup', methods=['GET', 'POST'])
def signup():
	if request.method == 'POST':
		try:
			cursor = db.cursor()
			email = request.form['cust_email']
			firstName = request.form['cust_firstName']
			lastName = request.form['cust_lastName']
			contact = request.form['cust_phone']
			pwd = sha256_crypt.hash(str(request.form['cust_pwd']))
			# pwd = request.form['cust_pwd']
			addr = request.form['cust_addr']
			postal = request.form['cust_postal']
			parse = (email, firstName, lastName, contact, pwd, addr, postal)
		except Exception as e:
			return jsonify({'status': 'failed', 'message' : str(e)})
		else:
			try:
				cursor.callproc('sp_registration', parse)
			except Exception as e:
				return jsonify({'status': 'failed', 'message' : str(e)})
			else:
				db.commit()
			finally:
				cursor.close()
				flash('You are now registered and can login', 'success')  
				return redirect(url_for('login'))
	return render_template('signup.html')

#Category Page - Based on Sub Categories
@app.route('/categories/<string:main>/<string:sub>')
def categories(main,sub):
	if 'logged_in' in session:
		return render_template('category.html', user=session['username'])
	else:
		return render_template('category.html')


#Product Details Page
@app.route('/<string:cat>/<string:prod>')
def products(cat,prod):
	if 'logged_in' in session:
		return render_template('product.html', prod_id=prod, user=session['username'])
	else:
		return render_template('product.html', prod_id=prod)


#Cart Page
@app.route('/cart')
@is_logged_in
def cart():
	# for 1 argument, db has to give such syntax
	#authenticator = (current_user[0]['firstName'],)
	cursor = db.cursor()
	cursor.callproc('sp_getCurrentUserCart', authenticator)
	return render_template('cart.html')


#Checkout
@app.route('/checkout', methods=['GET','POST'])
@is_logged_in
def order():
	return redirect(url_for('confirmation', id=str_id))


#Order Successful Page
@app.route('/confirmation/<string:id>')
@is_logged_in
def confirmation(id):
	return render_template('confirmation.html', order_id=id)

@app.route('/search/<string:item>')
def search(item):
	return render_template('search.html', result=item)


#--------------------------------APIs---------------------------------------#
#APIs for getting data
@app.route('/get-all-orders', methods=['GET', 'POST'])
def result():
	cursor.execute("SELECT * FROM tabSales_Order")

	# fetching all records from the 'cursor' object
	data = cursor.fetchall()
	return jsonify(data)

#--------------------------------------------------------------------------#
