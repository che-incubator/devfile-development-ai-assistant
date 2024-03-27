FROM registry.access.redhat.com/ubi8/python-311:latest

ADD app /app
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
WORKDIR /app

CMD ["python3", "app.py"]