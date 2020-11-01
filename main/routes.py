from main import app, cursor, db
from functools import wraps
from flask import render_template, request, json, jsonify, flash, redirect, url_for, session
from passlib.hash import sha256_crypt
from functools import wraps
from datetime import datetime, timedelta
from wtforms import Form, IntegerField, StringField, TextAreaField, PasswordField, validators

###  Functions Checklist and ToDos (Remove Later) ###
# 1. Index Page -  Done*
# 2. Category Page - Done*
# 3. Product Page - Done*
# 4. Login Page - Done*
# 5. Signup Page - Done*
# 6. Admin Page - Pending statistics, update/add product (image path & category)
# 7. Account Page - Pending user function to post review, and render all orders of the customer
# 8. Cart Page - Done*
# 9. Checkout Page - Done* - need total price
# 10. Payment Page - Done*
# 11. Search - Done*

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
#ToDo: optimize session storage
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
				if current_user != []:
					pwd = current_user[0]['userPassword']
					isAdmin = current_user[0]['isAdmin']

					#Login successful
					if sha256_crypt.verify(login_password, pwd):
						session['logged_in'] = True
						session['username'] = current_user[0]['userFirstName']
						session['lastname'] = current_user[0]['userLastName']
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
			except:
				return redirect (url_for('login'))
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
	try:
		cursor = db.cursor()
		productList = []
		orderList = []
		commentList = []
	except Exception as e:
		return jsonify({'Status':'Failed', 'Error':str(e)})
	else:
		cursor.callproc('sp_manage_product')
		for result in cursor.stored_results():
			for item in result.fetchall():
				productList.append(item)
		cursor.nextset()
		cursor.callproc('sp_manage_order')
		for result in cursor.stored_results():
			for item in result.fetchall():
				orderList.append(item)
		cursor.nextset()
		cursor.callproc('sp_manage_comment')
		for result in cursor.stored_results():
			for item in result.fetchall():
				commentList.append(item)
	return render_template('admin_main.html', productList=productList, orderList=orderList, commentList=commentList)

#User Account
@app.route('/account', methods=['GET','POST'])
def account():
	if request.method == 'POST':
		# changePassword()
		if request.form['update_detail'] == 'updatePwd':	
			changePassword()
		elif request.form['update_detail'] == 'updateProfile':
			updateProfile()
		elif request.form['update_detail'] == 'updateReview':
			postReview()
	try:
		cursor = db.cursor()
		orderList = []
		args = (session['useremail'], )
	except Exception as e:
		return jsonify({'Status':'Failed', 'Error':str(e)})
	else:
		try:
			cursor.callproc('display_order_user', args)
		except Exception as e:
			return jsonify({'Status':'Failed', 'Error':str(e)})
		else:
			for result in cursor.stored_results():
				for item in result.fetchall():
					orderList.append(item)
	return render_template('account.html', orderList=orderList, user=session['username'], lastname=session['lastname'], mail=session['useremail'])

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
				cursor.callproc('new_registration', parse)
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
		return render_template('product.html', prod_id=prod, user=session['username'], mail=session['useremail'])
	else:
		return render_template('product.html', prod_id=prod)


#Cart Page
@app.route('/cart', methods=['GET','POST'])
@is_logged_in
def cart():
	itemList = []
	cart_list =[]
	try:
		cursor = db.cursor()
		# for each ID in session['cart']
		cart_list = session['cart']
	except Exception as e:
		print(str(e))
	else:
		for items in cart_list:
			for prodId in items:
				args = (int(prodId), )
				cursor.callproc('display_product_by_ID', args)
				for result in cursor.stored_results():
					for item in result.fetchall():
						itemList.append(item)
	finally:
		cursor.close()
	return render_template('cart.html', noOfItems=len(itemList), itemList=itemList, cart=cart_list, user=session['username'])
	
#Add To Cart Function
@app.route('/addToCart', methods=['GET','POST'])
@is_logged_in
def add_to_cart():
	product_id = int(request.form['prodId'])
	quantity = int(request.form['prodQty'])
	if 'cart' in session:
		cart_list = session['cart']
		#Add to cart if product is not inside
		if not any(str(product_id) in p for p in cart_list):
			cart_list = session['cart']
			cart_list.append({product_id : quantity})
		# If the product is already in the cart, update the quantity
		elif any(str(product_id) in p for p in cart_list):
			for p in cart_list:
				for o in p:
					if(o == str(product_id)):
						p[o] = quantity
		session['cart'] = cart_list
	else:
		# In this block, the user has not started a cart, so we start it for them and add the product. 
		session['cart'] = [{product_id: quantity}]
	return jsonify({'status': 'success', 'message' : 'success'})

#Checkout
@app.route('/checkout', methods=['GET','POST'])
@is_logged_in
def checkout():
	if request.method == 'POST':
		try:
			cursor = db.cursor()

			#parameters for inserting order details
			cart_list = session['cart']

			#parameters for inserting order
			email = session['useremail']
			orderDate = datetime.now()
			name = request.form['reciName']
			address = request.form['reciAddress']
			postalCode = request.form['reciPostal']
			phone = request.form['reciPhone']
			orderStat = 'Confirmed'
			totalPrice = float(request.form['payable'])
			deliverDate = datetime.now() + timedelta(days=3)
			remark = 'call when delivering'
			totalQty = len(cart_list)
			cardName = request.form['cc_name']
			cardNum = request.form['cc_number']
			paymentMethod = request.form['payment']
			cardExpiry = request.form['cc_expiry']

			if(paymentMethod == 'visa'):
				payIdx = 1
			elif(paymentMethod == 'mastercard'):
				payIdx = 2
			else:
				payIdx = 3

			#cardCvv = request.form['cc_cvv']
			parse = (email, orderDate, name, address, postalCode, phone, orderStat, totalPrice, 
			deliverDate, remark, totalQty, cardName, cardNum, payIdx, cardExpiry)

			#get new order id
			order_no = 1
			order_query = "SELECT orderID FROM order_info ORDER BY orderedDate DESC LIMIT 1;"
			cursor.execute(order_query)
			prev_order = cursor.fetchall()
			
			#Verify user id and password if user exists
			if prev_order != []:
				order_no = prev_order[0][0] + 1


		except Exception as e:
			print(str(e))
			return jsonify({'status': 'failed', 'message' : str(e)})
		else:
			try:
				cursor.callproc('add_order', parse)
				db.commit()
				cursor.nextset()
				for items in cart_list:
					for prodId in items:
						args = (int(prodId), order_no, int(items[prodId]))
						cursor.callproc('add_order_detail', args)
						db.commit()
						cursor.nextset()
						forComment = (email, int(prodId))
						cursor.callproc('add_default_no_comment', forComment)
						db.commit()
						cursor.nextset()

			except Exception as e:
				print(str(e))
				return jsonify({'status': 'failed', 'message' : str(e)})
			else:
				db.commit()
				flash('Payment successful', 'success')  
			finally:
				session.pop('cart', None)
				cursor.close()
				return redirect(url_for('payment'))
	return render_template('checkout.html', user=session['username'])

#Order Successful Page
@app.route('/payment')
@is_logged_in
def payment():
	cursor = db.cursor()
	order_no = 'SO-00000'
	order_query = "SELECT orderID FROM order_info WHERE orderedCustomer='" + session['useremail'] + \
		"' ORDER BY orderedDate DESC LIMIT 1;"
	cursor.execute(order_query)
	current_order = cursor.fetchall()
			
	#Verify user id and password if user exists
	if current_order != []:
		order_no = current_order[0][0]
	
	cursor.close()

	return render_template('payment.html', user=session['username'], orderId=order_no)


#Search for Products
@app.route('/search', methods=['GET', 'POST'])
def search():
	try:
		cursor = db.cursor()
		searchStr = '%' + request.form['searchBox'] + '%'
		args = (searchStr,)
		itemList = []
	except Exception as e:
		return jsonify({'status': 'failed', 'message' : str(e)})
	else:
		try:
			cursor.callproc('search_product', args)
			for result in cursor.stored_results():
				for item in result.fetchall():
					itemList.append(item)
		except Exception as e:
			cursor.close()
			return jsonify({'status': 'failed', 'message': str(e)})
		else:
			cursor.close()
			return jsonify({"success":"success", 'itemList':itemList})
	finally:
		cursor.close()
	#return render_template('category.html', searchlist=itemList)


#--------------------------------Functions for User Account---------------------------------------#

#Update Profile Function
def updateProfile():
	try:
		cursor = db.cursor()
		phone = request.form['inputPhone']
		address = request.form['inputAddress']
		postalCode = request.form['inputPostal']
		parse = (session['useremail'], phone, address, postalCode)
		
	except Exception as e:
		return jsonify({'status': 'failed', 'message' : str(e)})
	else:
		try:
			cursor.callproc('update_userInfo', parse)
		except Exception as e:
			return jsonify({'status': 'failed', 'message' : str(e)})
		else:
			db.commit()
			flash('Profile updated', 'success')
		finally:
			cursor.close()
			return redirect(url_for('account'))

#Change Password Function
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
				parse = (session['useremail'], confirmPwd)
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

#Post Review Function
def postReview():
	try:
		cursor = db.cursor()
		review = request.form['inputReview']
		parse = (session['useremail'], review)
		
	except Exception as e:
		return jsonify({'status': 'failed', 'message' : str(e)})
	else:
		try:
			cursor.callproc('post_review', parse)
		except Exception as e:
			return jsonify({'status': 'failed', 'message' : str(e)})
		else:
			db.commit()
			flash('Thank you for reviewing the product.', 'success')  
		finally:
			cursor.close()
			return redirect(url_for('account'))

#Log out and redirect to login page
@app.route('/')
@app.route('/logout')
def logout():
	session.clear()
	flash("You are now logged out",'success')
	return redirect(url_for('login'))

#--------------------------------Functions for Admin CRUD---------------------------------------#

# ----- Product -----

# 2. Update/Edit Existing Product Info
@app.route('/admin/updateProduct', methods=['GET', 'POST'])
def updateProduct():
	if request.method == 'POST':
		try:
			cursor = db.cursor()
			prodId = int(request.form['prodId'])
			prodName = request.form['prodName']
			prodPrice = float(request.form['prodPrice'])
			prodQty = int(request.form['prodQty'])
			prodDescription = request.form['prodDescription']
			prodImagePath = request.form['prodImagePath']

			parse = (prodName, prodPrice, prodQty, prodImagePath, prodDescription, prodId)
			print(parse)

		except Exception as e:
			return jsonify({'status': 'failed', 'message' : str(e)})
		else:
			try:
				cursor.execute('UPDATE product_info SET productName=%s, price=%s, \
					availableQuantity=%s, imagePath=%s, productDescription=%s, \
						lastUpdated=now() WHERE productID=%s;', parse)
			except Exception as e:
				return jsonify({'status': 'failed', 'message' : str(e)})
			else:
				db.commit()
			finally:
				cursor.close()
				return render_template('admin_update.html')
	try:
		catList = []
		cursor = db.cursor()
	except Exception as e:
		cursor.close()
		return jsonify({'failed':'failed', 'message':str(e)})
	else:
		cursor.execute('select categorySub from category;')
		catList = cursor.fetchall()
		print(catList)
		cursor.close()
	return render_template('admin_update.html', catList=catList)
		

# 3. Delete Existing Product
@app.route('/admin/hideProduct', methods=['GET', 'POST'])
def hideProduct():
	try:
		cursor = db.cursor()
		prodId = int(request.form['productID'])
		doWhat = request.form['doWhat']
		parse = (prodId,)
	except Exception as e:
		print(str(e))
		return jsonify({'status': 'failed', 'message' : str(e)})
	else:
		try:
			if doWhat == 'show':
				cursor.execute('UPDATE product_info SET isShow=1, lastUpdated=now() WHERE productID=%s;', parse)
			if doWhat == 'hide':
				cursor.execute('UPDATE product_info SET isShow=0, lastUpdated=now() WHERE productID=%s;', parse)
		except Exception as e:
			print(str(e))
			return jsonify({'status': 'failed', 'message' : str(e)})
		else:
			db.commit()
		finally:
			cursor.close()
			return jsonify({'status':'success', 'message':'success'})


# 4. Add New Product
@app.route('/admin/addProduct',  methods=['GET', 'POST'])
def addProduct():
	if request.method == 'POST':
		try:
			cursor = db.cursor()
			catId = 1
			prodCat = str(request.form['prodCat'])
			prodName = request.form['prodName']
			prodPrice = float(request.form['prodPrice'])
			prodQty = int(request.form['prodQty'])
			prodDescription = request.form['prodDescription']
			prodImgPath = '/static/assets/dist/images/Products/living-room/coffee-table/wooden-coffee-table.jpg'

			parse = (prodCat)
			print(parse)
			cursor.execute("SELECT categoryID FROM category WHERE categorySub='%s';", parse)
			catList = cursor.fetchall()
			#catId = int(catList[0][0])
			print(catList)

			parse = (catId, prodName, prodDescription, prodQty, prodPrice, 0, prodImgPath)

		except Exception as e:
			return jsonify({'status': 'failed', 'message' : str(e)})
		else:
			try:
				cursor.callproc('add_product', parse)
			except Exception as e:
				return jsonify({'status': 'failed', 'message' : str(e)})
			else:
				db.commit()
			finally:
				cursor.close()
				return render_template('admin_update.html')
	try:
		catList = []
		cursor = db.cursor()
	except Exception as e:
		cursor.close()
		return jsonify({'failed':'failed', 'message':str(e)})
	else:
		cursor.execute('select categorySub from category;')
		catList = cursor.fetchall()
		cursor.close()
	return render_template('admin_update.html', catList=catList)

# ----- Order -----
# 6. Change Status of Order
@app.route('/admin/updateOrderStat', methods=['GET', 'POST'])
def updateOrder():
	try:
		cursor = db.cursor()
		orderId = int(request.form['orderID'])
		orderStatus = request.form['changes']
		parse = (orderId,)
	except Exception as e:
		print(str(e))
		return jsonify({'status': 'failed', 'message' : str(e)})
	else:
		try:
			#cursor.callproc('update_order_status', parse)
			if orderStatus == 'Confirmed':
				cursor.execute('Update order_info SET orderStatus=\'Confirmed\' WHERE orderID=%s;', parse)
			if orderStatus == 'Cancelled':
				cursor.execute('Update order_info SET orderStatus=\'Cancelled\' WHERE orderID=%s;', parse)
			if orderStatus == 'Delivered':
				cursor.execute('Update order_info SET orderStatus=\'Delivered\' WHERE orderID=%s;', parse)

		except Exception as e:
			print(str(e))
			return jsonify({'status': 'failed', 'message' : str(e)})
		else:
			db.commit()
		finally:
			cursor.close()
			return jsonify({'status':'success', 'message':'success'})


# ----- Comment -----
# 7. Reply to Customer Comment
@app.route('/admin/replyComment', methods=['GET', 'POST'])
def replyComment():
	try:
		cursor = db.cursor()
		commentor = request.form['commentor']
		commentId = int(request.form['commentID'])
		commentText = request.form['message']
		parse = (commentText, commentId, commentor)

	except Exception as e:
		cursor.close()
		print("1: "+str(e))
		status = 'failed'
		message = (str(e))
		return jsonify({'status':status, 'message':message})
	else:
		try:
			cursor.execute(' UPDATE user_comment SET adminReply = %s WHERE commentID = %s and commentorEmail = %s;', parse)
		except Exception as e:
			cursor.close()
			print(str(e))
			status = 'failed'
			message = (str(e))
		else:
			db.commit()
			status = 'success'
			message = commentText
		finally:
			cursor.close()
	finally:
		return jsonify({'status':status, 'message':message})

# ----- Statistics -----
# 9. Render Revenues, Top Sales and Top Customers data
@app.route('/admin/viewStatistics', methods=['GET', 'POST'])
# def viewStatistics():

#--------------------------------APIs---------------------------------------#
#APIs for getting all product data
@app.route('/getAllProducts', methods=['GET', 'POST'])
def getAllProducts():
	try:
		cursor = db.cursor()
		fullProductList = []
		cursor.callproc('display_product_all')
	except Exception as e:
		status = 'failed'
		message = str(e)
	else:
		status = 'success'
		message = 'success'
		for result in cursor.stored_results():
			for prod in result.fetchall():
				fullProductList.append(prod)
	finally:
		cursor.close()
		return jsonify({'status': status, 'message':message, 'prodList': fullProductList})


#APIs for getting categories data
@app.route('/renderCategories', methods=['GET', 'POST'])
def renderCategories():
	try:
		cursor = db.cursor()
		subCat = request.form['categorySubTitle']
		args = (subCat,)
		itemList = []
	except Exception as e:
		return jsonify({'status': 'failed', 'message' : str(e)})
	else:
		try:
			cursor.callproc('sp_item_by_categorySub', args)
			for result in cursor.stored_results():
				for item in result.fetchall():
					itemList.append(item)
		except Exception as e:
			cursor.close()
			return jsonify({'status': 'failed', 'message': str(e)})
		else:
			cursor.close()
			return jsonify({"success":"success", 'itemList':itemList})

#API for getting ONE product data
@app.route('/renderSingleProduct', methods=['GET', 'POST'])
def renderSingleProduct():
	try:
		cursor = db.cursor()
		prod = int(request.form['prodID'])
		args = (prod,)
		itemList = []
	except Exception as e:
		cursor.close()
		return jsonify({'status': 'failed', 'message' : str(e)})
	else:
		try:
			cursor.callproc('display_product_by_ID', args)
			for result in cursor.stored_results():
				for item in result.fetchall():
					itemList.append(item)
		except Exception as e:
			cursor.close()
			return jsonify({'status': 'failed', 'message': str(e)})
		else:
			cursor.close()
			return jsonify({"success":"success", 'itemList':itemList})


#APIs for getting categories data
@app.route('/getProductByMainCategory', methods=['GET', 'POST'])
def getProductByMainCategory():
	try:
		cursor = db.cursor()
		categoryMainTitle = request.form['categoryMainTitle']
		args = (categoryMainTitle,)
		itemList = []
	except Exception as e:
		return jsonify({'status': 'failed', 'message' : str(e)})
	else:
		try:
			cursor.callproc('sp_item_by_categoryMain', args)
			for result in cursor.stored_results():
				for item in result.fetchall():
					itemList.append(item)
		except Exception as e:
			cursor.close()
			return jsonify({'status': 'failed', 'message': str(e)})
		else:
			cursor.close()
			return jsonify({"success":"success", 'itemList':itemList})
	finally:
		cursor.close()

#API for sorting in category page
@app.route('/sortByInput', methods=['GET', 'POST'])
def sortByInput():
	try:
		cursor = db.cursor()
		sortType = request.form['sort']
		categorySubTitle = request.form['categorySubTitle']
		sortedList = []
		if(sortType == 'Newest'):
			args = (categorySubTitle, 'latest')
		elif(sortType == 'price_low'):
			args = (categorySubTitle, 'asc')
		elif(sortType == 'price_high'):
			args = (categorySubTitle, 'desc')
	except Exception as e:
		print(str(e))
		cursor.close()
		return jsonify({'status': 'failed', 'message': str(e)})
	else:
		try:
			cursor.callproc('sort_product_by_ordering', args)
			for result in cursor.stored_results():
				for item in result.fetchall():
					sortedList.append(item)
					print(sortedList)
		except Exception as e:
			print(str(e))
			cursor.close()
			return jsonify({'status': 'failed', 'message': str(e)})
	finally:
		cursor.close()
	return jsonify({"status":"success", 'sortedList':sortedList})


#APIs for getting top picks
@app.route('/getTopPicks', methods=['GET', 'POST'])
def getTopPicks():
	try:
		cursor = db.cursor()
		itemList = []
	except Exception as e:
		return jsonify({'status': 'failed', 'message' : str(e)})
	else:
		try:
			cursor.callproc('get_top_picks')
			for result in cursor.stored_results():
				for item in result.fetchall():
					itemList.append(item)
		except Exception as e:
			cursor.close()
			status = 'failed'
			message = str(e)
		else:
			cursor.close()
			status = 'success'
			message = 'success'
	finally:
		cursor.close()
		return jsonify({"success":status, 'itemList':itemList, 'message':message})

#APIs for getting order detail based on orderID
@app.route('/getOrderDetailOnOrderID', methods=['GET', 'POST'])
def getOrderDetailOnOrderID():
	orderId = int(request.form['orderID'])
	userInSess = request.form['userIdentifier']
	detailList = []
	status='failed'
	message='failed'
	try:
		cursor = db.cursor()
		args = (userInSess, orderId)
	except Exception as e:
		cursor.close()
		print(str(e))
		status = 'failed'
		message = str(e)
	else:
		try:
			cursor.callproc('get_order_detail_for_ordered', args)
		except Exception as e:
			cursor.close()
			print(str(e))
			status = 'failed'
			message = str(e)
		else:
			for result in cursor.stored_results():
				for item in result.fetchall():
					detailList.append(item)
					status = 'success'
					message = 'success'
	finally:
		cursor.close()
		return jsonify({"success":status, 'detailList':detailList, 'message':message})


#APIs for getting all bookmarks made by user
@app.route('/displayBookmarkOfUser', methods=['GET', 'POST'])
def displayBookmarkOfUser():
	try:
		cursor = db.cursor()
		userIdentifier = request.form['userIdentifier']
		itemList = []
		args = (userIdentifier, )
	except Exception as e:
		return jsonify({'status': 'failed', 'message' : str(e)})
	else:
		try:
			cursor.callproc('display_bookmark_user', args)
			for result in cursor.stored_results():
				for item in result.fetchall():
					itemList.append(item)
		except Exception as e:
			cursor.close()
			status = 'failed'
			message = str(e)
		else:
			cursor.close()
			status = 'success'
			message = 'success'
	finally:
		cursor.close()
		return jsonify({"success":status, 'itemList':itemList, 'message':message})


#APIs for deselecting bookmarks made by user 
@app.route('/likeOrDislikeProduct', methods=['GET', 'POST']) 
def dislikeProduct(): 
	try: 
		cursor = db.cursor() 
		userIdentifier = request.form['userIdentifier']
		likeOrNo = int(request.form['likeOrNo'])
		prodID = int(request.form['prodID'])
		args = (prodID,userIdentifier,likeOrNo)
	except Exception as e:
		status = 'failed'
		print(str(e))
		message = str(e)
	else: 
		try: 
   			cursor.callproc('update_bookmark', args) 
		except Exception as e: 
   			cursor.close() 
   			print(str(e))
   			status = 'failed'
   			message = str(e)
		else:
   			db.commit()
   			cursor.close() 
   			status = 'success'
   			message = 'success'
	finally: 
   		cursor.close()
   		return jsonify({'status':status, 'message':message})



#APIs for inserting user comment
@app.route('/insertComment', methods=['GET', 'POST']) 
def insertComment(): 
	try: 
		cursor = db.cursor()
		commentId = int(request.form['commentId'])
		content = request.form['comment']
		args = (content, commentId)
	except Exception as e:
		status = 'failed'
		print(str(e))
		message = str(e)
	else: 
		try: 
   			cursor.execute('UPDATE user_comment SET comment=%s,commentDate=now() WHERE commentID=%s;', args) 
		except Exception as e: 
   			cursor.close() 
   			print(str(e))
   			status = 'failed'
   			message = str(e)
		else:
   			db.commit()
   			cursor.close() 
   			status = 'success'
   			message = content
	finally: 
		cursor.close()
		return jsonify({'status':status, 'message':message})
#--------------------------------------------------------------------------#
