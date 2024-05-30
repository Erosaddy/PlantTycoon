<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>식물타이쿤</title>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css">
    <link rel="stylesheet" href="${ctx}/resources/css/reset.css">
    <link rel="stylesheet" href="${ctx}/resources/css/layout.css">
    <link rel="stylesheet" href="${ctx}/resources/css/join.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
	<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>
    <div id="wrapper">
        <div class="join_wrap">
            <div class="join">
                <div class="join_box">
                    <div class="join_top">
                        <div class="join_tit">
                            <div class="logo">
                                <img src="${ctx}/resources/images/login_logo.png" alt="로고 이미지">
                            </div>
                            <p>Register to your account</p>
                        </div>
                        <form action="/join" method="post">
                            <div class="id_input">
                                <p>Email</p>
                                <input type="email" name="memberId" placeholder="이메일을 입력하세요">
                                <span class="font_red">이미 사용중인 이메일 입니다.</span>
                            </div>
                            <div class="pw_input">
                                <p>Password</p>
                                <input type="password" name="memberPw" placeholder="비밀번호를 입력하세요">
                            </div>
                            <div class="pw_input2">
                                <p>Confirm Password</p>
                                <input type="password" placeholder="비밀번호를 다시 입력하세요">
                                <span class="font_gray">비밀번호가 일치합니다.</span>
                            </div>
                            <div class="name_input">
                                <p>Name</p>
                                <input type="text" name="nickname" placeholder="닉네임을 입력하세요">
                            </div>
                            <div class="join_btn">
                                <button type="submit">회원가입</button>
                            </div>
                            <div>
								<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
							</div>
                        </form>
                    </div>
                    <div class="join_bottom">
                        <p>
                            아이디가 있으신가요?
                            <a href="/login">로그인</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>