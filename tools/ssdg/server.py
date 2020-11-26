from flask import Flask, request

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        print(request.json)
        # ['get-acct', {}]
    response = ""
    # response 생성
    return ""

app.run(host="0.0.0.0", port=8000)
