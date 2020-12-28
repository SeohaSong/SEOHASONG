# Code Snippet

## URL-Download with js

1. 개발자 도구 콘솔창을 연다.
2. 아래 코드를 복붙한다.
```js
const url = 'https://cdn50.asdf.bz/asdf.mp4';
const anchor = document.createElement('a');
anchor.setAttribute('href', url);
anchor.setAttribute('download', '');
    // 값이 없으면 본래 파일의 이름으로 할당되는 것 같다.
anchor.setAttribute('target', '_blank');
    // 대체로 이걸 해 주면 해더 검사할 때 안걸리고 안전한 듯 하다.
anchor.click();
```
