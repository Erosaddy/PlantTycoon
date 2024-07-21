# PlantTycoon
1인가구가 늘어가는 지금, 공허함을 느끼는 현대인들을 위한 `스마트 반려식물 육성` 서비스.

## 👨‍🏫 프로젝트 소개
최근 1인 가구가 증가함에 따라 외로움을 느끼는 사람들도 자연스레 늘고 있습니다. 이에 많은 사람들이 반려 동물을 키우며 외로움을 달래지만, 동물을 키우는 데 필요한 시간과 에너지가 부족한 사람들도 있습니다.

이러한 상황에서 **가정용 식물이 외로움을 달래 줄 반려 동물의 대체재로 주목받고 있습니다.** 홈 가드닝 관련 산업 매출은 국내에서 2019년 대비 2023년 4년 만에 8배 증가할 만큼 폭발적인 성장세를 보이고 있으며, 가정용 식물에게 '반려 식물'이라는 호칭을 붙이며 가족 구성원처럼 대하는 사람들도 생겨날 만큼 가정용 식물은 많은 이들의 동반자가 되어 주고 있습니다.

그러나 가정용 식물은 분명한 한계가 존재합니다. **식물은 감정적 교류가 불가하며, 주인의 관심과 보살핌에 즉각적인 반응이 없다는 것입니다.** 이러한 한계가 존재하는 한, 가정용 식물이 진정한 의미에서의 '반려 식물'이 되는 것은 불가능합니다.

이러한 한계를 극복하기 위해 개발된 것이 바로 PlantTycoon입니다. **PlantTycoon은 식물의 현재 상태를 표시하고, 이에 따른 식물의 감정을 표출하는 등 식물과의 상호작용을 강화함으로써 가정용 식물이 '반려 식물'로 거듭나게 합니다.** 예를 들어, 식물이 물이 부족할 때 화면에 슬픈 표정을 보여주거나, 적절한 환경에서 건강하게 자랄 때 기쁜 표정을 나타냅니다. 이외에도 PlantTycoon은 식물 별 적정 환경 정보와 자동 급수 기능 등을 제공하여 식물 육성의 편의성을 높여 줍니다. 이러한 노력이 시들어가는 '반려 식물'에 새로운 생명을 불어넣고, 사용자에게 더 큰 행복과 만족감을 선사할 것입니다.

## 💻 개발 환경
- **Version** : Java 11
- **Framework** : Spring 4.3.8.RELEASE
- **SQL Mapper** : Mybatis

## 기술 스택
Java, Spring(legacy), JavaScript, Oracle Database, HTML, CSS, SQL, Arduino

## 구현 기능
Spring Security 인증 및 인가, 이메일로 비밀번호 찾기, 데이터베이스 모델링, Gituhub Actions 파일 백업 및 테스트 자동화

## 주요 경험

**1. 회원 정보 수정 시 Principal 객체가 수정 이전의 정보를 표시하던 문제 해결**
- Controller에서 회원 정보 수정 시 변경된 내용으로 새롭게 인증 절차를 밟은 뒤 Principal 객체에 전달하는 로직을 추가하여 해결

**2. Github Actions에서 테스트 자동화가 동적으로 이루어지지 않던 문제 해결**
- 개인 정보 노출 방지를 위해 Github Secrets를 활용하고, 로컬과 원격 테스트 자동화 문제를 해결하기 위해 pom.xml에 profile 기능을 사용하여 환경별로 동적으로 설정 파일을 적용. 이를 통해 로컬과 원격 테스트 환경 모두에서 테스트가 일관되게 작동하도록 구성

## 배운 점

**1. Github을 이용한 협업**
- Github Flow 브랜치 전략을 채택하여 각자의 브랜치에서 작업하고 Pull Request를 활용해 형상 관리하는 방법 터득

**2. 일정 관리**
- 일정이 밀리고 소통이 단절되는 것을 방지하기 위해 Gantt Chart와 Kanban Board를 통해 전체 진행도 및 각자가 맡은 기능의 진행상황 및 직면한 문제 등 공유

- 일정 확인을 습관화하고 프로젝트 전체 일정의 약 30% 여유분을 남겨 문제 상황에 대비할 수 있도록 해야 함을 학습

**3. 팀원 간 잦은 소통의 중요성**
- 프로젝트 말미에 소통이 부족해지며 프로젝트의 방향성에 대한 이해에 불일치가 있음을 뒤늦게 발견

- Daily Scrum 및 Kanban 등 상황에 맞는 협업 기술을 선택하고 활용하여 팀원 모두가 같은 방향을 바라보도록 해야 함을 학습

**4. 보안**
- Spring Security를 공부하며 salt, key stretching, CSRF attack, rainbow table attack 등 보안 관련 내용 학습

- Spring Security를 통해 비교적 간단한 절차만으로도 여러 형태의 공격을 효과적으로 막을 수 있음을 학습

## 화면별 기능 요약
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




  
