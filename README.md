# PlantTycoon
1인가구가 늘어가는 지금, 공허함을 느끼는 현대인들을 위한 `스마트 반려식물 육성` 서비스.

## 👨‍🏫 프로젝트 소개
코로나19 팬데믹은 우리의 삶을 송두리째 바꿔놓았습니다. 집에서 보내는 시간이 늘어나면서 '홈 가드닝'이 새로운 트렌드로 급부상했고, 식물은 단순한 취미를 넘어 '반려식물'이라는 이름으로 우리 삶에 자리 잡았습니다. 관련 산업 매출 또한 폭발적으로 증가하여 2023년에는 2019년 대비 8배에 달하는 시장 규모를 전망하고 있습니다. (발명진흥회 재산평가 센터 자료 발췌)

하지만 팬데믹 초기에 들여온 반려식물들은 어떻게 되었을까요? 특히, 대표적인 '반려식물'로 사랑받았던 다육식물은 평균 수명이 2~5년 정도로, 2024년 현재 많은 사람들이 시들어가는 다육식물을 마주하고 있을 것입니다.

이러한 상황 속에서, 우리는 단순히 식물을 키우는 것을 넘어, '반려식물'과 함께하는 삶의 질을 향상시키는 솔루션을 제시하고자 합니다.

Plan Tycoon 은 IT 기술을 활용하여 '반려식물'의 건강 상태를 정확하게 파악하고, 맞춤형 관리 가이드를 제공함으로써, 시들어가는 '반려식물'에 새로운 생명을 불어넣고, 사용자에게 더 큰 행복과 만족감을 선사할 것입니다.

## 💻 개발환경
- **Version** : Java 11
- **IDE** : STS, Arduino IDE, Android Studio, Visual Studio Code
- **Framework** : Spring 4.3.8.RELEASE
- **SQL Mapper** : Mybatis

## ⚙️ 기술 스택
- **DataBase** : Oracle 21C Express Edition
- **Language** : JAVA, Javascript, HTML5, CSS3, jQuery 
- **Server** : Tomcat
- **아이디어 회의** : Notion

## 📌 구현 기능
- 계정 관련
  - 로그인, 로그아웃, 회원가입
  - 비밀번호 찾기
  - 내 정보(닉네임, 식물변경)
  - 회원관리 페이지를 통한 회원 활성/비활성
- 식물 현황
  - 온도, 대기습도, 조도, 토양습도 시각화
  - 실시간 모니터링
  - 급수관리(자동/수동)
  - 조명제어
- 게시판(관찰일지, 공지사항)
  - 게시글 CRUD
  - 검색 기능
  - CKEditor5
  - 버튼 페이징

## 📝 화면별 기능 요약
- 로그인
  - 로그인 후 서비스 이용 가능
  - 유효성 검사
![image](https://github.com/Erosaddy/PlantTycoon/assets/55119669/cb839138-8208-4ff7-a7f3-8ed74682e2b5)

- 회원가입
  - 아이디 중복검사
  - 유효성 검사
![image](https://github.com/Erosaddy/PlantTycoon/assets/55119669/db5dd7f9-dbf4-4777-8feb-5d09cdd9a536)


- 홈(메인 페이지)
  - 온도, 대기습도, 조도, 토양습도 시각화
  - 식물별 적정수치에 따른 식물 이미지 및 말풍선 변화
  - 다음 자동 급수시간 안내
  - 급수기록 조회
  - 수동 물주기
  - 조명제어
![image](https://github.com/Erosaddy/PlantTycoon/assets/55119669/9b6f1321-8c32-4f6c-a3bd-ba7e6bd2c867)

- 실시간 모니터링
  - 아두이노 웹캠 모듈을 활용하여 식물 모니터링
  - 온도, 대기습도, 조도, 토양습도 시각화
  - 수동 물주기
  - 조명제어
![image](https://github.com/Erosaddy/PlantTycoon/assets/55119669/53bc50bd-be3c-40dc-a8db-e8d69e134e60)

- 온도/습도/조도
  - 온도, 대기습도, 조도, 토양습도 시각화
  - chart.js 플러그인
![image](https://github.com/Erosaddy/PlantTycoon/assets/55119669/456d3ec8-e697-4d2a-9d26-a2d6bcf999fa)

- 급수관리
  - 자동 급수주기 관리
  - 급수기록 조회
  - 월별 급수 현황 시각화
![image](https://github.com/Erosaddy/PlantTycoon/assets/55119669/cb2632a8-6bfd-4a28-8583-d5d4d29034c1)

- 관찰일지, 공지사항
  - 게시글 CRUD
  - 검색 기능
  - CKEditor5
  - 페이징
![image](https://github.com/Erosaddy/PlantTycoon/assets/55119669/6302c516-89f7-4e49-9b69-bc6a571cebdf)
![image](https://github.com/Erosaddy/PlantTycoon/assets/55119669/53fc5ae8-ba97-4675-9dc7-bac16980726e)
![image](https://github.com/Erosaddy/PlantTycoon/assets/55119669/85efc250-5293-4933-97b5-83ffd15a50fb)
![image](https://github.com/Erosaddy/PlantTycoon/assets/55119669/967fe0ce-b399-41a5-96fa-ceca322e6eba)
![image](https://github.com/Erosaddy/PlantTycoon/assets/55119669/e00df0fe-ef47-4e44-900d-d86b6cc29cc7)
![image](https://github.com/Erosaddy/PlantTycoon/assets/55119669/6513fbcf-90a8-4922-97b4-74141f253d77)

- 회원관리
  - 관리자 전용 메뉴
  - 검색 기능
  - 회원 활성/비활성
![image](https://github.com/Erosaddy/PlantTycoon/assets/55119669/730c8bce-72a5-4c06-92e7-8f0f8223ca32)




  
