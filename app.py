from main import app

if __name__ == '__main__':
    app.secret_key = 'db123456'
    #app.run(host='0.0.0.0', debug=True)
    app.run(debug=True)