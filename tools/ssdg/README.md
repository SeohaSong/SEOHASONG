# GUIDELINE

## 예시

### 요청 (./request.sh)
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

### 응답 (./server.py)
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

## Tracking Issues & TBD

1. 술 주종 고정? 고정 후 여러개 복수 주종 가능?
1. 2차 이상의 댓글 유아이 구현
1. 내 입맛과 대중의 입맛을 동시에 표현 (내입맛 노출이 너무 안된다는 사견)
1. 내 별점과 대중의 별점을 동시에 표현 (위와 같은 이유)
1. 사진인증 유아이 구현
1. 임의 닉네임 생성 연산: 클라 vs 서버
1. 데이터 암호화
1. 검색엔진 고도화
1. 이미지 캐셔
1. 규칙 확정: ((리뷰및 별점) => (내입맛, 페어링, 향, 인증)), 찜은 독립

## 데이터

### 분류 3기준
- 온디바이스
```
POST: 없음
GET: 디바이스에 데이터가 없거나 명시적 업데이트 요청시
예시
    유저가 무슨짓을 해도 변하지 않는 데이터
```
- 개인정보
```
POST: 필요할 때 마다
GET: 디바이스에 데이터가 없거나 명시적 업데이트 요청시
예시
    특정 유저의 행위에 대한 데이터 변동이 해당 유저에게만 적용
```
- 서버
```
POST: 필요할 떄 마다
GET: 필요할 떄 마다
예시
    유저의 상호작용이 모든 유저가 보는 페이지를 변경하는 경우
```

### 데이터의 흐름
- 로딩 순서
    1. 브라우저스토리지 => 메모리
    1. 디바이스롬 => 메모리
    1. 서버 => 메모리
- 저장 순서
    1. 메모리 => 서버
    1. 메모리 => 디바이스롬
    1. 메모리 => 브라우저스토리지

### 디바이스캐싱
- 어플리케이션 자체에서 롬 100메가 용량 잡고있음
- 실제 에센셜한 데이터는 10메가도 안될듯
- 선입선출 방식으로 남는 90메가 안에서 캐싱 수행함 (초기값 설정함)
- 이를 처리 가능한 런타임 개발
- 정적 할당 설계 (썸네일 이미지 50메가, 그외 30메가 등)