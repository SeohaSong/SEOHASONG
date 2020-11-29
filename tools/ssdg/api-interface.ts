// c r u d cu(c혹은u중 서버측에서결정) 다섯가지 요청 형태
type integer = number;
type longString = string; // 긴 문자열

interface 요청프로토콜
{
    0: (
        "r-ondevice" |
        "c-acct" | "r-acct" | "u-acct" | "d-acct" |
        "cu-usr-sool" | 
        "r-sool" | "r-sools"
    ), // 요청 타입
    1: null | {}
}
interface 응답프로토콜
{
    0: null | string,  // 응답결과 (null 성공 | string 실패에대한 정보)
    1: {}
}

interface UsrInfo
{
    "usr-id": integer, // 데이터베이스 관리 용 유저 아이디
    "token": string,
        // 이것으로 세션 진위여부를 확인하게 됨
        // 토큰은 로그인 시점에 생성되고 로그아웃 시점에 만료됨
        // 로그인 안해도 클라이언트에게 주는 방식도 고려, (디도스 방어용)
    "email": string
}

type 계정_인증_관련_오류_응답 = "usr-id" | "email" | "token";
    // 찾을 수 없는 사용자
    // 계정 정보 오류
    // 세션 만료
type 오류_응답_가이드 = 계정_인증_관련_오류_응답 | "그외 무엇이든 키 값";
    // 해당 속성값의 자료형이 맞지 않을경우
        // 그외 특별한 경우는 따로 기입했음
        
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

interface SoolInformation
{
    "name": [string, string], // 앞부분이 더 잘 노출되는 이름
    "alias": string[], // 다르게 불리는 이름들 (검색시 차순위 검색 대상)
    "price": integer[], // 가격 오름차순 정렬
    "img": string[], // 파일 사이즈 기준으로 오름차순 정렬
    "type": "탁주" | "청주" | "증류식소주" | "등등 리스트 확정 필요",
    "proof": integer, // 도수
    "vol": integer, // 용량, ml기준
    "taste": [integer, integer, integer, integer, integer],
         // 기본 설정된 디폴트 5개 미각
    "pairing": string[],
    "scent": string[],
    "knowhow": longString, // 맛있게 마시기
    "intro": longString,
    "story": longString
}
const soolInformation_예시: SoolInformation = {
    "name": ["금정산성 막걸리", "금정산성 토산주"],
    "alias": ["누리끼리 막걸리", "금산탁주", "어쩌구저쩌구"],
    "price": [11000, 13500, 21000],
    "img": ["img-url1", "img-url2"],
    "type": "탁주",
    "proof": 7,
    "vol": 750,
    "taste": [3, 5, 1, 2, 4],
    "pairing": ["마른안주", "한식"],
    "scent": ["요거트"],
    "knowhow": ``,
    "intro": `
        금정산성막걸리는 술빛기에 적합한 온도와 습도가 유지되는 해발 400m의...
        금정산성막걸리는 깨끗한 자연환경속에서 발효된 자연산 누룩과...
    `,
    "story": `
        금정산성막걸리는 그 유래가 정확하지는 않지만 조선 초기부터 이곳 화전민이...
    `     
}

interface 온디바이스_요청 extends 요청프로토콜
{
    0: "r-ondevice",
    1: null
}
const 온디바이스_요청_예시: 온디바이스_요청 = [
    "r-ondevice",
    null
]

interface 온디바이스_응답 extends 응답프로토콜
{
    0: null,
    1: {
        "sool-id2info": {
            [sool_id: number]: SoolInformation // 배열의 인덱스가 곧 술 아이디
        }
    }
}
const 온디바이스_응답_예시: 온디바이스_응답 = [
    null,
    {
        "sool-id2info": [
            soolInformation_예시, // sool-id 0
            soolInformation_예시, // sool-id 1
            soolInformation_예시 // sool-id 2
        ]
    }
]
// 온디바이스 데이터는 운영자 전용 파이프라인에서만 수정/삭제 가능

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

interface 계정가입_요청 extends 요청프로토콜
{
    0: "c-acct",
    1: {
        "email": string, // oauth의 기준이 되는 메일주소 혹은 유저가 입력한 메일주소
        "name": string, // 처음에는 임의 생성된 닉네임을 쏘겠지
        "pwd": string, // 비밀번호 해쉬처리 된 값 | oauth의 token값
        "gender": 0 | 1 | null,
            // 0남 1여 (이런식으로 인덱싱 하는 경우는 항상 사전순을 따름)
        "yob": integer | null // year of birth
    }
}
const 계정가입_요청_예시: 계정가입_요청 = [
    "c-acct",
    {
        "email": "johndoe@mail.com",
        "name": "술취한 참새 29819", 
        "pwd": "92429d82a41e930486c6de5ebda9602d55c39986",
        "gender": 0,
        "yob": 1993
    }
]

interface 계정가입_응답 extends 응답프로토콜
{
    0: null | "email" | "name",
        // 이메일을 입력하세요. 중복된 이메일입니다, 올바른 이메일이 아닙니다
        // 닉네임을 입력하세요. 중복된 닉네임입니다.
    1: null | {
        "usr-id": integer
    }
}
const 계정가입_응답_예시: 계정가입_응답 = [
    null,
    {
        "usr-id": 32
    }
]

// -----------------------------------------------------------------------------

interface UsrSoolInfo
{
    "star": number, // 내가 준 별점
    "taste": [integer, integer, integer, integer, integer]
        // 내가 입력한 5개 맛 척도
    "pairing": string[], // 내가 추가 입력한 페어링 정보
    "scent":  string[], // 내가 추가 입력한 향 보보
    "review": longString
}
const UsrSoolInfo_예시: UsrSoolInfo = {
    "star": 3.5,
    "taste": [5, 3, 2, 4, 1],
    "pairing": ["육개장", "명태전"],
    "scent": ["풀잎", "새집"],
    "review": `
        맛있습니다.
        마시는 치즈같은 끈적한 신맛이네요.
    `
}

interface 계정로그인_요청 extends 요청프로토콜
{
    0: "r-acct",
    1: {
        "email": string,
        "pwd": string
    }
}

interface 계정로그인_응답 extends 응답프로토콜
{
    0: null | "email" | "pwd",
        // 존재하지 않는 이메일입니다
        // 비밀번호 불일치
    1: null | {
        "token": string,
        "idx2sool-ids": [
            integer[], // 내 도감에 표현되는 전체 술 목록
            integer[], // 인증 술 목록
            integer[], // 평가 술 목록
            integer[], // 찜 술 목록
            integer[], // 리뷰 술 목록
        ],
        "sool-id2info": {
            [sool_id: number]: UsrSoolInfo
        }
    }
}
const 계정로그인_응답_예시: 계정로그인_응답 = [
    null,
    {
        "token": "c2778d43400d656e25671b58a5f6c2b82278c5f5",
        "idx2sool-ids": [
            [132, 499, 83, 1420, 802, 95],
            [132, 499, 83],
            [132, 499, 1420],
            [499, 1420, 802, 95],
            [132, 499],
        ], // 모든 리스트는 기본적으로 등록 순서를 유지해야함 (순서 중요함)
        "sool-id2info": {
            83: UsrSoolInfo_예시,
            95: UsrSoolInfo_예시,
            132: UsrSoolInfo_예시,
            499: UsrSoolInfo_예시,
            802: UsrSoolInfo_예시,
            1420: UsrSoolInfo_예시
        }
    }
]

// -----------------------------------------------------------------------------

interface 계정변경_요청 extends 요청프로토콜
{
    0: "u-acct",
    1: {
        "name": null | string,
        "gender": null | 0 | 1,
        "yob": null | integer,
        "usr-info": UsrInfo
    }
}
const 계정변경_요청_예시: 계정변경_요청 = [
    "u-acct",
    {
        "name": "강철의 양조술사",
        "gender": null,
        "yob": null,
        "usr-info": {
            "usr-id": 32,
            "token": "c2778d43400d656e25671b58a5f6c2b82278c5f5",
            "email": "johndoe@mail.com"
        }
    }
]

interface 계정변경_응답 extends 응답프로토콜
{
    0: null | 계정_인증_관련_오류_응답,
    1: null | {
        "name": string,
        "gender": null | 0 | 1,
        "yob": null | integer,
    }
}
const 계정변경_응답_예시: 계정변경_응답 = [
    null,
    {
        "name": "강철의 양조술사", // 변경된 값
        "gender": 0, // 변경이 없으면 기존값을 반환
        "yob": 1993 // 변경이 없으면 기존값을 반환
    }
]

// -----------------------------------------------------------------------------

interface 계정탈퇴_요청 extends 요청프로토콜
{
    0: "d-acct",
    1: {
        "usr-info": UsrInfo
    }
}

interface 계정탈퇴_응답 extends 응답프로토콜
{
    0: null | 계정_인증_관련_오류_응답,
    1: null
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

interface 유저술관계_등록변경_요청 extends 요청프로토콜
{
    0: "cu-usr-sool",
    1: {
        "usr-info": UsrInfo,
        "sool-id": integer,
        "cert": null | boolean, // 인증 유무
        "like": null | boolean, // 찜 유무
        "taste": null | [integer, integer, integer, integer, integer],
        "star": null | number,
        "review": null | longString,
        "pairing": null | string[],
        "scent": null | string[],
    }
}

interface 유저술관계_등록변경_응답 extends 응답프로토콜
{
    0: null | "sool-id" | 계정_인증_관련_오류_응답,
        // 찾을 수 없는 술 정보
    1: null | {
        // 요청 반영 후 유저의 최신 정보 반환
        "cert": boolean, // defalut false
        "like": boolean, // defalut false
        "taste": null | [integer, integer, integer, integer, integer],
        "star": null | number,
        "review": null | longString,
        "pairing": string[], // default 빈 배열
        "scent": string[], // defalut 빈 배열
    }
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

interface ReviewRecord
{
    "star": integer, // 해당 리뷰에서 준 별점
    "name": string, // 리뷰남긴 사람 닉네임
    "review": longString // 리뷰 본문
}
const ReviewRecord_예시: ReviewRecord = {
    "star": 4,
    "name": "술취한 참새 29819",
    "review": `
        맛있습니다. 마시는 치즈같은 끈적한 신맛이네요.
        프리미엄 막걸리라 표방하는 왠만한...
        어쩌구.. 저쩌구.
    `
}

interface 술정보_요청 extends 요청프로토콜
{
    0: "r-sool",
    1: {
        "usr-info": null | UsrInfo, // 혹시 모를 로그분석을 위해서 전송해봄
        "sool-id": integer
    }
}

interface 술정보_응답 extends 응답프로토콜
{
    0: null | "sool-id",
    1: null | {
        "review-data": {
            [idx: number]: ReviewRecord
        },
        "info": null | {
            "star": number, // 별점 통계량
            "star-distr": [integer, integer, integer, integer, integer,
                           integer, integer, integer, integer, integer],
                // 별점 히스토그램 10칸
            "star-n": integer, // 별점 준 사람 수
            "taste-n": integer, // 맛정보 준 사람 수
            "review-n": integer, // 리뷰 남긴 사람 수
            "cluster": integer[], // 지정 메트릭 기준 유사도 순 정렬 (비슷한 술)
            "pairing": string[], // 전역 페어링
            "scent": string[], // 전역 향
            "taste": [integer, integer, integer, integer, integer]
                // 맛정보 통계량
        }
    }
}

// -----------------------------------------------------------------------------

interface 술리스트_요청 extends 요청프로토콜
{
    0: "r-sools",
    1: {
        "usr-info": null | UsrInfo, // 혹시 모를 로그분석을 위해서 전송해봄
        "sool-ids": integer[],
            // 빈 배열이면 전체에서 찾음
        "criteria": null | "star" | "review-n" | "그 외 다양한 기준",
            // 정렬기준. null인경우 sool-ids 배열 순으로 정렬 유지.
    }
}

interface 술리스트_응답 extends 응답프로토콜
{
    0: null | "sool-id" | "criteria",
        // 조회할 수 없는 술 아이디가 있음
        // 검색조건 없음
    1: null | {
        "infos": {
            [idx: number]: {
                "sool-id": integer,
                "star": number, // 별점통계량
                "review-n": integer, // 총 리뷰수
                "name": string, // 대표 리뷰 작성자 닉네임
                "s-review": string // small review (대표리뷰 30자에서 자름)
            }
        } 
    }
}

