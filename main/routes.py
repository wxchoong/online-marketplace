from main import app, cursor, db
from functools import wraps
from flask import render_template, request, json, jsonify, flash, redirect, url_for, session
from passlib.hash import sha256_crypt
from functools import wraps
from datetime import datetime
from wtforms import Form, IntegerField, StringField, TextAreaField, PasswordField, validators

###  Functions Checklist and ToDos (Remove Later) ###
# 1. Index Page -  Render top picks
# 2. Category Page - Done with Python, need AJAX bug fix
# 3. Product Page - Pending AJAX
# 4. Login Page - Done
# 5. Signup Page - Done
# 6. Admin Page - Pending, refer to "Admin CRUD" section
# 7. Account Page - Functions(submit) added, pending test with stored procedure. Pending Render user info.
# 8. Cart Page - Pending function for creating view
# 9. Checkout Page - Function added, pending test with stored procedure.
# 10. Payment Page - Pending function for retrieval of order ID (assume payment is always successful)
# 11. Search - Pending

#--------------------------------Routes---------------------------------------#

#Index Page
@app.route('/')
def index():
    ### Check for Session
    if 'logged_in' in session:
    	return render_template('index.html', user=session['username'])
    else:
    	return render_template('index.html')

#Login Page
@app.route('/login', methods=['GET', 'POST'])
def login():	
	# If logged in, redirect to user account page	
	if 'logged_in' in session:
		return redirect(url_for('account'))
	else:
		# Retrieve user inputs from form
		if request.method == 'POST':
			try:
				login_email = request.form['input_email']
				login_password = request.form['input_pwd']
			
				# Query relevant user information from database 
				user_query = "SELECT * FROM user_info WHERE userEmail='" + login_email + "';"
				cursor.execute(user_query)
				current_user = cursor.fetchall()
			
				#Verify user id and password if user exists
				if current_user != None:
					pwd = current_user[0]['userPassword']
					isAdmin = current_user[0]['isAdmin']

					#Login successful
					if sha256_crypt.verify(login_password, pwd):
						session['logged_in'] = True
						session['username'] = current_user[0]['userFirstName']
						session['useremail'] = current_user[0]['userEmail']
						session['user_pwd'] = pwd
						flash('You are now logged in','success')
						
						#Redirect based on user role (admin/customer)
						if(isAdmin == True):
							session['is_admin'] = True
							return redirect(url_for('admin'))
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

# Disallow access to pages if user is not logged in
def is_logged_in(f):
	@wraps(f)
	def wrap(*args, **kwargs):
		if 'logged_in' in session:
			return f(*args, **kwargs)
		else:
			flash('Unauthorized, Please log in','danger')
			return redirect (url_for('login'))
	return wrap

# Disallows access to admin pages if current user is not admin
def is_admin(f):
	@wraps(f)
	def wrap(*args, **kwargs):
		if 'is_admin' in session:
			return f(*args, **kwargs)
		else:
			flash('Unauthorized, Please log in using admin account','danger')
			return redirect (url_for('index'))
	return wrap

#Admin Page
@app.route('/admin')
@is_admin
def admin():
	return render_template('admin_main.html')

#User Account
@app.route('/account', methods=['GET','POST'])
def account():
	if request.method == 'POST':
		if request.form['update_detail'] == 'updatePwd':
			return redirect(url_for('changePassword'))
		elif request.form['update_detail'] == 'updateProfile':
			return redirect(url_for('updateProfile'))
		elif request.form['update_detail'] == 'updateReview':
			return redirect(url_for('addReview'))
	return render_template('account.html', user=session['username'])

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
			addr = request.form['cust_addr']
			postal = request.form['cust_postal']
			parse = (email, firstName, lastName, contact, pwd, addr, postal)
		except Exception as e:
			return jsonify({'status': 'failed', 'message' : str(e)})
		else:
			try:
				cursor.callproc('new_registeration', parse)
			except Exception as e:
				return jsonify({'status': 'failed', 'message' : str(e)})
			else:
				db.commit()
				flash('You are now registered and can login', 'success')  
			finally:
				cursor.close()
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
	# authenticator = (session['username'])
	# cursor = db.cursor()
	# cursor.callproc('sp_getCurrentUserCart', authenticator)
	return render_template('cart.html', user=session['username'])

#Checkout
@app.route('/checkout', methods=['GET','POST'])
@is_logged_in
def checkout():
	if request.method == 'POST':
		try:
			cursor = db.cursor()
			name = request.form['reciName']
			phone = request.form['reciPhone']
			address = request.form['reciAddress']
			postalCode = request.form['reciPostal']
			paymentMethod = request.form['payment']
			cardName = request.form['cc_name']
			cardNum = request.form['cc_number']
			cardExpiry = request.form['cc_expiration']
			cardCvv = request.form['cc_cvv']
			parse(name, phone, address, postalCode, paymentMethod, cardName, cardNum, cardExpiry, cardCvv)
			
		except Exception as e:
			return jsonify({'status': 'failed', 'message' : str(e)})
		else:
			try:
				cursor.callproc('add_payment', parse)
			except Exception as e:
				return jsonify({'status': 'failed', 'message' : str(e)})
			else:
				db.commit()
			finally:
				cursor.close()
				flash('Payment successful', 'success')  
				return redirect(url_for('payment'))
	return render_template('checkout.html', user=session['username'])

#Order Successful Page
@app.route('/payment')
@is_logged_in
def payment():
	order_no = 'SO-00001'
	return render_template('payment.html', user=session['username'], orderId=order_no)

#Search for Products
@app.route('/search/<string:item>')
def search(item):
	return render_template('category.html', result=item)

#--------------------------------Functions for User Account---------------------------------------#

#Update Profile Function
@app.route('/updateProfile', methods=['GET', 'POST'])
def updateProfile():
	try:
		cursor = db.cursor()
		phone = request.form['inputPhone']
		address = request.form['inputAddress']
		postalCode = request.form['inputPostal']
		parse(phone, address, postalCode)
		
	except Exception as e:
		return jsonify({'status': 'failed', 'message' : str(e)})
	else:
		try:
			cursor.callproc('update_profile', parse)
		except Exception as e:
			return jsonify({'status': 'failed', 'message' : str(e)})
		else:
			db.commit()
		finally:
			cursor.close()
			flash('Profile updated', 'success')  
	return redirect(url_for('account'))

#Change Password Function
@app.route('/changePassword')
def changePassword():
	try:
		cursor = db.cursor()
		currentPwd = request.form['inputCurrentPassword']

		#if password entered same as current password stored in database
		if sha256_crypt.verify(currentPwd, session['user_pwd']):
			newPwd = request.form['inputNewPassword']
			confirmPwd = sha256_crypt.hash(str(request.form['inputConfirmPassword']))

			#if new password and confirm password match
			if sha256_crypt.verify(newPwd, confirmPwd):
				parse(session['useremail'], confirmPwd)
			#new password and confirm password does not match
			else:
				flash('New password does not match', 'danger') 
		#password entered does not match the password in database 
		else:
			flash('Old password does not match', 'danger')
		
	except Exception as e:
		return jsonify({'status': 'failed', 'message' : str(e)})
	else:
		try:
			cursor.callproc('update_password', parse)
		except Exception as e:
			return jsonify({'status': 'failed', 'message' : str(e)})
		else:
			db.commit()
			flash('Password Changed', 'success')
		finally:
			cursor.close()
			return redirect(url_for('account'))
	return redirect(url_for('account'))

#Post Review Function
@app.route('/postReview', methods=['GET', 'POST'])
def postReview():
	try:
		cursor = db.cursor()
		review = request.form['inputReview']
		parse(review)
		
	except Exception as e:
		return jsonify({'status': 'failed', 'message' : str(e)})
	else:
		try:
			cursor.callproc('post_review', parse)
		except Exception as e:
			return jsonify({'status': 'failed', 'message' : str(e)})
		else:
			db.commit()
		finally:
			cursor.close()
			flash('Thank you for reviewing the product.', 'success')  
	return redirect(url_for('account'))

#Log out and redirect to login page
@app.route('/logout')
def logout():
	session.clear()
	flash("You are now logged out",'success')
	return redirect(url_for('login'))

#--------------------------------Functions for Admin CRUD---------------------------------------#

# ----- Product -----
# 1. Update Existing Product Info
# 2. Delete Existing Product
# 3. Add New Product

# ----- Order -----
# 4. Change Status of Order

# ----- Comment -----
# 5. Reply to Customer Comment
# 6. Delete User Comment

# ----- Statistics -----
# 7. Render Revenues, Top Sales and Top Customers data

#--------------------------------APIs---------------------------------------#
#APIs for getting all order data
@app.route('/get-all-orders', methods=['GET', 'POST'])
def result():
	cursor.execute("SELECT * FROM tabSales_Order")

	# fetching all records from the 'cursor' object
	data = cursor.fetchall()
	return jsonify(data)

#APIs for getting categories data
@app.route('/renderCategories', methods=['GET', 'POST'])
def renderCategories():
	try:
		cursor = db.cursor()
		subCat = request.form['categorySubTitle']
		args = (subCat,)
		itemList = []
	except Exception as e:
		cursor.close()
		return jsonify({'status': 'failed', 'message' : str(e)})
	else:
		try:
			cursor.callproc('sp_item_by_categorySub', args)
			for result in cursor.stored_results():
				for item in result.fetchall():
					itemList.append(item)
					print(item)
		except Exception as e:
			cursor.close()
			return jsonify({'status': 'failed', 'message': str(e)})
		else:
			cursor.close()
			return jsonify({"success":"success", 'itemList':itemList})

#API for getting product data
@app.route('/renderProduct', methods=['GET', 'POST'])
def renderProduct():
	try:
		cursor = db.cursor()
		prod = request.form['product']
		args = (prod,)
		itemList = []
	except Exception as e:
		cursor.close()
		return jsonify({'status': 'failed', 'message' : str(e)})
	else:
		try:
			cursor.callproc('sp_item_by_productname', args)
			for result in cursor.stored_results():
				for item in result.fetchall():
					itemList.append(item)
					print(item)
		except Exception as e:
			cursor.close()
			return jsonify({'status': 'failed', 'message': str(e)})
		else:
			cursor.close()
			return jsonify({"success":"success", 'itemList':itemList})
			
#--------------------------------------------------------------------------#
