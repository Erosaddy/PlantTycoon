<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="${ctx}/resources/css/detail.css">
            <div class="side">
                <ul class="gnb">
                    <li> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/" class="menu1 nolnb">홈</a> <!--2뎁스 메뉴 없을 때 nolnb클래스 붙음-->
                    </li>
                    <li>
                        <a href="javascript:void(0);" class="menu2">식물현황</a>
                        <ul class="lnb">
                            <li> <!--메뉴 선택 시 on클래스 붙음-->
                                <a href="${ctx}/plant/monitoring">실시간 모니터링</a>
                            </li>
                            <li> <!--메뉴 선택 시 on클래스 붙음-->
                                <a href="${ctx}/plant/status">온도/습도/조도</a>
                            </li>
                            <li> <!--메뉴 선택 시 on클래스 붙음-->
                                <a href="${ctx}/plant/watering">급수관리</a>
                            </li>
                        </ul>
                    </li>
                    <li> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/journal/list" class="menu3 nolnb">관찰일지</a>
                    </li>
                    <li class="on"> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/notice/list" class="menu4 nolnb">공지사항</a>
                    </li>
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
	                    <li> <!--메뉴 선택 시 on클래스 붙음-->
	                        <a href="${ctx}/management" class="menu5 nolnb">회원관리</a>
	                    </li>
                    </sec:authorize>
                </ul>
            </div>
            <div class="container">
                <div class="container_inner">

                    <div class="sub_title">
                        <h3>공지사항</h3>
                        <button type="button">
                            <span><img src="${ctx}/resources/images/ic_backlist.png" alt="목록으로 돌아가기 아이콘"></span>
                            목록으로 돌아가기
                        </button>
                        <div class="writer_btn_wrap">
                            <button type="button" class="btn_edit">수정</button>
                            <button type="button" class="btn_del">삭제</button>
                        </div>
                    </div>
                    <div class="detail">
                       <div class="detail_top">
                            <h3>공지사항입니다. 필독해주세요.</h3>
                            <div class="info">
                                <span class="name">최고관리자</span>
                                <span class="date">2024.05.23 09:23:58</span>
                            </div>
                       </div>
                       <div class="detail_cont">
                            <p>안녕하세요, 식물타이쿤입니다.<br>
                                <br>
                                식물타이쿤 비정기 업데이트가 2024년 5월 30일(목)에 진행됩니다.<br>
                                자세한 업데이트 사항은 아래 내용을 확인해 주시기 바랍니다.<br>
                                <br>
                                ■ 업데이트 일정 : 2024년 5월 30일(목) 오후 2시경<br>
                                ※ 앱 노출 시간은 앱스토어 사정에 따라 상이할 수 있습니다.<br>
                                ※ Mobile앱은 선택 업데이트 방식으로 [Mobile앱 > 더보기 > 애플리케이션 정보]를 통해서도 최신 버전으로 업데이트 할 수 있습니다.
                            </p>
                       </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>