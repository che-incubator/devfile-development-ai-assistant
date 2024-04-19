FROM registry.access.redhat.com/ubi8/python-311:latest

ADD app /app
ADD resources /resources
COPY requirements.txt requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /app

EXPOSE 9000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "9000"]