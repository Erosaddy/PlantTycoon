<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
    <meta http-equiv="Content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>식물타이쿤</title>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css">
	<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>
    <link rel="stylesheet" href="${ctx}/resources/css/reset.css">
    <link rel="stylesheet" href="${ctx}/resources/css/layout.css">
    <link rel="stylesheet" href="${ctx}/resources/css/login.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="${ctx}/resources/script/main.js"></script>
</head>
<body>
    <div id="wrapper">
        <!-- 비밀번호 찾기 팝업 -->
        <div class="pw_popup">
            <div class="white_box">
                <div class="popup_title">
                    비밀번호 찾기
                    <a href="#" class="popup_close">
                        <img src="${ctx}/resources/images/ic_popup_close.png" alt="닫기버튼">
                    </a>
                </div>
                <div class="forgot_password">
                    <form action="${ctx}/findAuth" method="post">
                    	<sec:csrfInput/>
                        <p>기존에 가입한 이메일을 입력하면 인증용 메일을 보내드립니다.</p>
                        <input type="text" name="memberId" placeholder="이메일을 입력하세요">
                        <button type="submit">비밀번호 변경 메일 받기</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="login_wrap">
            <div class="login">
                <div class="login_box">
                    <div class="login_top">
                        <div class="login_tit">
                            <div class="logo">
                                <img src="${ctx}/resources/images/login_logo.png" alt="로고 이미지">
                            </div>
                            <p>Login to your account</p>
                        </div>
                        <form name="loginForm" action="${ctx}/login" method="post">
                        	<sec:csrfInput/>
                            <div class="id_input">
                                <p>Email</p>
                                <input id="inputEmail" type="text" name="username" placeholder="이메일을 입력하세요" autocomplete="off">
                            </div>
                            <div class="pw_input">
                                <p>Password</p>
                                <input id="inputPassword" type="password" name="password" placeholder="비밀번호를 입력하세요" autocomplete="off">
                            </div>
                            <div class="remember_me">
                            	<label>
                            		<input type="checkbox" name="remember-me">
                            		로그인 상태 유지
                            	</label>
                            </div>
                            
                            <p id="loginErrorMessage" class="font_red" style="width: 100%; margin-top: 20px; text-align: center; font-size: 15px;">
	                            <c:out value="${error }" />
								<c:out value="${logout }"/>
                            </p>
							
                            <div class="login_btn">
                                <button id="login" type="button">로그인</button>
                            </div>
                        </form>
                    </div>
                    <div class="login_bottom">
                        <a href="${ctx}/join">회원가입</a>
                        <a href="javascript:void(0);" class="forgot_password_btn">비밀번호 찾기</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="${ctx}/resources/script/login.js"></script>
    
</body>
</html>