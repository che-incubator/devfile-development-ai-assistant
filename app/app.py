from flask import Flask, request
from openai_service import chat

app = Flask(__name__)


@app.route('/', methods=['POST'])
def home():
    if request.method == 'POST':
        return chat(request.data)


if __name__ == '__main__':
    app.run(port=9000, host='0.0.0.0')
