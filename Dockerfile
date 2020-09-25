FROM python:3.7.4-stretch
RUN mkdir -p /app
WORKDIR /app

COPY . .
RUN pip install -r requirements.txt  

EXPOSE 5000

RUN chmod 755 app.py
CMD ["python", "app.py"]