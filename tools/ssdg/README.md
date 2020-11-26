# 예시

## 요청 (request.sh)
```bash
json='[
    "get-acct",
    {}
]'

curl \
    -X POST \
    -H "Content-Type: application/json" \
    -d "$json" \
    localhost:8000

```

## 응답 (./server.py)
```python
from flask import Flask, request

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        print(request.json)
        # ['get-acct', {}]
    response = None
    # response 생성
    return response

app.run(host="0.0.0.0", port=8000)
```
