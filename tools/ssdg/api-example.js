const ISSUE = `
1. 2차 이상의 댓글 유아이 구현
2. 내 입맛과 대중의 입맛을 동시에 표현 (내입맛 노출이 너무 안된다는 사견)
3. 내 별점과 대중의 별점을 동시에 표현 (위와 같은 이유)
4. 사진인증 유아이 구현
5. 임의 닉네임 생성 연산: 클라 vs 서버
`
const 개발되어야할것 = `
1. 데이터 암호화
2. 검색엔진 고도화
3. 이미지 캐셔
`
const 데이터분류세가지기준 = `
온디바이스
    POST: 없음
    GET: 디바이스에 데이터가 없거나 명시적 업데이트 요청시
    예시
        유저가 무슨짓을 해도 변하지 않는 데이터
개인정보
    POST: 필요할 때 마다
    GET: 디바이스에 데이터가 없거나 명시적 업데이트 요청시
    예시
        특정 유저의 행위에 대한 데이터 변동이 해당 유저에게만 적용
서버
    POST: 필요할 떄 마다
    GET: 필요할 떄 마다
    예시
        유저의 상호작용이 모든 유저가 보는 페이지를 변경하는 경우
`
const 데이터흐름에관한정책 = `
로딩 순서
    1. 브라우저스토리지 => 메모리
    2. 디바이스롬 => 메모리
    3. 서버 => 메모리
저장 순서
    1. 메모리 => 서버
    2. 메모리 => 디바이스롬
    3. 메모리 => 브라우저스토리지
`
const 디바이스캐싱정책 = `
어플리케이션 자체에서 롬 100메가 용량 잡고있음
실제 에센셜한 데이터는 10메가도 안될듯
선입선출 방식으로 남는 90메가 안에서 캐싱 수행함 (초기값 설정함)
이를 처리 가능한 런타임 개발
정적 할당 설계 (썸네일 이미지 50메가, 그외 30메가 등)
`
const 기본프로토콜형태__배열표현 = [
    요청타입 | 응답결과, // 응답결과는 문제 없다면 null
    null | {} // 데이터
]
const 기본프로토콜형태__배열표현이맘에안들면이렇게바꾸시죠 = {
    "type": 요청타입 | 응답결과,
    "content": null | {}
}


const 온디바이스데이터_요청 = [
    "get-ondevice",
    null
]
const 온디바이스데이터_응답 = [
    null,
    null
]
// 위에대한 명세가 승현형이 원하는 것 ㅎㅎㅎㅎ 하지만~ 나중에 정리함 ㅎ


const 계정가입_요청 = [
    "post-acct",
    {
        "email": "johndoe@mail.com", // oauth의 기준이 되는 메일주소 혹은 유저가 입력한 메일주소
        "name": "술취한 참새 29819", // 임의 생성된 닉네임
        "pwd": "92429d82a41e930486c6de5ebda9602d55c39986", // 비밀번호 해쉬처리 된 값 혹은 oauth의 token값
        "gender": 0 | null, // 0남 1여 (이런식으로 인덱싱 하는 경우는 항상 사전순을 따름)
        "yob": 24 | null // year of birth
    }
]
const 계정가입_응답 = [
    // 이메일을 입력하세요. 중복된 이메일입니다, 올바른 이메일이 아닙니다
    // 닉네임을 입력하세요. 중복된 닉네임입니다.
    // 비밀번호를 입력하세요.
    null | "email" | "name" | "pwd",
    null
]


const 계정로그인_요청 = [
    "get-acct",
    {
        "email": "johndoe@mail.com",
        "pwd": "92429d82a41e930486c6de5ebda9602d55c39986",
        "privacy-request": true | false // 개인정보 요청 유무
    }
]
const 계정로그인_응답 = [
    // 존재하지 않는 이메일입니다
    // 비밀번호 불일치
    null | "email" | "pwd",
    null | {
        "token": "c2778d43400d656e25671b58a5f6c2b82278c5f5",
        // 이것으로 세션 진위여부를 확인하게 됨
        // 토큰은 로그인 시점에 생성됨 (나이브하게)
        // 토큰은 로그아웃 시점에 만료됨 (나이브하게)
        // 토큰이 맞지 않으면 강제 로그아웃 시킬것임 (위 시나리오에선 복수 기기 접속시 과거 기기에서는 로그아웃 될 듯)
        "privacy": null | {
            "idx2sool-ids": [
                [132, 499, 83, 1420, 802, 95], // 전체 술 목록
                [132, 499, 83], // 인증 술 목록
                [132, 499, 1420], // 평가 술 목록
                [499, 1420, 802, 95], // 찜 술 목록
                [132, 499], // 리뷰 술 목록
            ], // 모든 리스트는 기본적으로 등록 순서를 유지해야함 (순서 중요함)
            "sool-id2info": {
                83: {
                    "star": 3.5, // 내가 준 별점
                    "taste": [5, 3, 2, 4, 1], // 앱에서 쓰는 5개 맛 척도
                    "pairing": ["육개장", "명태전"],
                    "scent": ["풀잎", "새집"],
                    "review": `
                        맛있습니다.
                        마시는 치즈같은 끈적한 신맛이네요.
                    `
                },
                95: {위83번데이터처럼},
                132: {위83번데이터처럼},
                499: {위83번데이터처럼},
                802: {위83번데이터처럼},
                1420: {위83번데이터처럼}
            }
        }
    }
]


const 술정보_요청 = [
    "get-sool",
    {
        "email": "johndoe@mail.com" | null,
        "token": "c2778d43400d656e25671b58a5f6c2b82278c5f5" | null,
        "sool-id": 142,
    }
]
const 술정보_응답 = [
    // 조회할 수 없는 술입니다
    null | "sool-id",
    null | {
        "review-data": [
            [
                4, //star
                "술취한 참새 29819", //name
                `
                    맛있습니다. 마시는 치즈같은 끈적한 신맛이네요.
                    프리미엄 막걸리라 표방하는 왠만한...
                    어쩌구.. 저쩌구.
                ` // comment
            ],
            [
                5,
                "막걸리 호랑이 323",
                `
                    맛있습니다.
                    마시는 치즈같은 끈적한 신맛이네요.
                `
            ]
        ],
        "info": null | {
            "star": 4.2, // 평균 별점
            "star-distr": [4, 58, 29, 19, 10, 39, 121, 13, 12, 3], // 별점 히스토그램 10칸짜리
            "review-num": 20, // 리뷰 수
        } // 유저 통계에 의해서만 산출되는 값으로 표현
    }
]


const 술리스트_요청 = [
    "get-sool-list",
    {
        "email": "johndoe@mail.com" | null,
        "token": "c2778d43400d656e25671b58a5f6c2b82278c5f5" | null,
        "sool-ids": null | [142, 26, 38], // null이면 전체에서 찾구, 배열이면 응답할때도 순서 유지되어야함
        "criteria": null | "review-ct", // sool-ids가 null이면 이건 null이면 절대 안됨.
        "reverse": true | false
    }
]
const 술리스트_응답 = [
    // 조회할 수 없는 술
    // 검색조건 없음
    null | "sool-ids" | "criteria",
    null | {
        "infos": [
            [
                3.7, // 별점
                124, // 총 리뷰 수임
                "술취한 참새 1232",
                `
                    어쩌구 저쩌구 이러쿵
                    맛이 저쩌고
                `
            ], // sool-id 142번의 대표 리뷰.
            [
                2.2,
                7,
                "뱅글 호랑이 323",
                `
                    그냥 그럼
                `
            ], // sool-id 26 대표 리뷰.
            [
                4.6,
                58,
                "술 무새 98",
                `
                    인생술
                    ㅋㅋㅋ jmt
                `
            ] // sool-id 38 대표 리뷰.
        ] 
    }
]


const 찜등록_요청 = [
    "post-like",
    {
        "email": "johndoe@mail.com",
        "token": "c2778d43400d656e25671b58a5f6c2b82278c5f5",
        "sool-id": 142
    }
]
const 찜등록_응답 = [
    // 없는 email입니다
    // 로그인 세션 만료
    // 조회할 수 없는 술입니다
    null | "email" | "token" | "sool-id",
    null
]


const 맛작성_요청 = [
    "post-taste",
    {
        "email": "johndoe@mail.com",
        "token": "c2778d43400d656e25671b58a5f6c2b82278c5f5",
        "sool-id": 142,
        "taste": [5, 3, 2, 4, 1],
    }
]
const 맛작성_응답 = [
    // 없는 email입니다
    // 로그인 세션 만료
    // 조회할 수 없는 술입니다
    // 입맛을 표현해주세요
    null | "email" | "token" | "sool-id" | "taste",
    null
]


const 평가작성_요청 = [
    "post-score",
    {
        "email": "johndoe@mail.com",
        "token": "c2778d43400d656e25671b58a5f6c2b82278c5f5",
        "sool-id": 142,
        "star": 3,
        "comment": null | "솔직히 그냥 평범하네요~ 사케랑 비슷~"
    }
]
const 평가작성_응답 = [
    // 없는 email입니다
    // 로그인 세션 만료
    // 조회할 수 없는 술입니다
    // 별점을 매겨야 합니다
    null | "email" | "token" | "sool-id" | "star",
    null
]


const 페어링작성_요청 = [
    "post-pairing",
    {
        "email": "johndoe@mail.com",
        "token": "c2778d43400d656e25671b58a5f6c2b82278c5f5",
        "sool-id": 142,
        "pairing": ["새우", "스테이크"]
    }
]
const 페어링작성_응답 = [
    // 없는 email입니다
    // 로그인 세션 만료
    // 조회할 수 없는 술입니다
    // 페어링을 해주세요
    null | "email" | "token" | "sool-id" | "pairing",
    null
]


const 향작성_요청 = [
    "post-pairing",
    {
        "email": "johndoe@mail.com",
        "token": "c2778d43400d656e25671b58a5f6c2b82278c5f5",
        "sool-id": 142,
        "scent": ["계피", "바나나"]
    }
]
const 향작성_응답 = [
    // 없는 email입니다
    // 로그인 세션 만료
    // 조회할 수 없는 술입니다
    // 어떤 향이 나나요?
    null | "email" | "token" | "sool-id" | "scent",
    null
]
