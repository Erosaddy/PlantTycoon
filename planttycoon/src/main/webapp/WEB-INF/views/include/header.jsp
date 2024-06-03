<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>식물타이쿤</title>
    <c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css">
    <link rel="stylesheet" href="${ctx}/resources/css/reset.css">
    <link rel="stylesheet" href="${ctx}/resources/css/layout.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="${ctx}/resources/script/main.js"></script>
    
    <script type="text/javascript">
        window.onload = function() {
            <c:if test="${not empty modifyNicknameResult}">
                <c:choose>
                    <c:when test="${modifyNicknameResult == 'success'}">
                        alert('닉네임이 성공적으로 수정되었습니다.');
                    </c:when>
                    <c:otherwise>
                        alert('닉네임 수정에 실패했습니다.');
                    </c:otherwise>
                </c:choose>
            </c:if>
        }
    </script>
    
</head>
<body>
    <div id="wrapper">
    	<!-- 내정보 팝업 -->
        <div class="my_popup">
            <div class="white_box">
                <div class="popup_title">
                    내 정보
                    <a href="#" class="popup_close">
                        <img src="${ctx}/resources/images/ic_popup_close.png" alt="닫기버튼">
                    </a>
                </div>
                <div class="myinfo_con">
                    <form action="${ctx}/modifyNickname" method="post">
                    	<sec:csrfInput/>
                        <div class="id_input">
                            <p>Email</p>
                            <input type="text" name="memberId" placeholder="이메일을 입력하세요" value='<sec:authentication property="principal.member.memberId"/>' class="readonly" readonly>
                        </div>
                        <div class="name_input">
                            <p>Name</p>
                            <input type="text" name="nickname" placeholder="닉네임을 입력하세요" value='<sec:authentication property="principal.member.nickname"/>'>
                        </div>
                        <button type="submit">내 정보 수정</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="header">
            <div class="mobile_menu">
                <div class="header_btn not-active">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
            <div class="logo">
                <a href="${ctx}/">
                    <img src="${ctx}/resources/images/logo.png" alt="로고">
                </a>
            </div>
            <div class="login_info">
                <ul>
                    <li>
                        <a href="javascript:void(0);" class="myinfo">내 정보</a>      
                    </li>
                    <li>
                        <form action="${ctx}/customLogout" method="post">
							<sec:csrfInput/>
							<button>로그아웃</button>
						</form>
                    </li>
                </ul>
            </div>
            <div class="mobile_menu">
                <div class="side_menu active" style="display: none; opacity: 0;">
                    <div class="menu_wrap">
                        <ul class="menu_list">
                            <li>
                                <a href="${ctx}/" class="menu_depth1">홈</a>
                            </li>
                            <li>
                                <p class="menu_depth1 haslnb">식물현황</p>
                                <div class="menu_depth2">
                                    <a href="${ctx}/plant/monitoring"><span>실시간 모니터링</span></a>
                                    <a href="${ctx}/plant/status"><span>온도/습도/조도</span></a>
                                    <a href="${ctx}/plant/watering"><span>급수관리</span></a>
                                </div>
                            </li>
                            <li>
                                <a href="${ctx}/journal/list" class="menu_depth1">관찰일지</a>
                            </li>
                            <li>
                                <a href="${ctx}/notice/list" class="menu_depth1">공지사항</a>
                            </li>
                            <li>
                                <a href="${ctx}/management" class="menu_depth1">회원관리</a>
                            </li>
                            <li class="btn_zone">
                                <a href="javascript:void(0);" class="mypage btn_green">내 정보</a>
                                <form action="${ctx}/customLogout" method="post">
									<sec:csrfInput/>
									<button class="btn_white">로그아웃</button>
								</form>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="main">