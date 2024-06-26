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
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>식물타이쿤</title>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css">
	<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>
    <link rel="stylesheet" href="${ctx}/resources/css/reset.css">
    <link rel="stylesheet" href="${ctx}/resources/css/layout.css">
    <link rel="stylesheet" href="${ctx}/resources/css/login.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="${ctx}/resources/script/main.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // JSTL을 사용하여 Flash Attribute 값을 자바스크립트 변수로 설정
            const flashMessage = "${passwordChangeResult}";

            // Flash Message가 있는 경우 자바스크립트에서 처리
            if (flashMessage) {
                console.log(flashMessage);
                // 예: 알림 표시
                alert(flashMessage);
            }
        });
    </script>
    <style>
    /* Chrome, Safari, Edge, Opera */
	input::-webkit-outer-spin-button,
	input::-webkit-inner-spin-button {
	  -webkit-appearance: none;
	  margin: 0;
	}
	
	/* Firefox  */
	input[type='number'] {
	  -moz-appearance: textfield;
	}
    </style>
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
                    <form id="findAuthForm">
                    	<sec:csrfInput/>
                        <p>기존에 가입한 이메일을 입력하면 인증용 메일을 보내드립니다.</p>
                        <input id="memberId" type="text" name="memberId" placeholder="이메일을 입력하세요">
                        <div id="result"></div>
                        <button type="submit">인증번호 받기</button>
                    </form>
                    <form id="verifyAuthForm" action="${ctx}/verifyAuth" method="POST" style="display: none;">
                    	<sec:csrfInput/>
                    	<input id="authNumber" type="number" name="authNumber" placeholder="인증번호를 입력하세요">
                    	<button type="submit">인증번호 제출</button>
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
    
    <script>
        $(document).ready(function() {
            $("#findAuthForm").submit(function(e) {
                e.preventDefault();
                
                function getCsrfToken() {
    	    	    return $('meta[name="_csrf"]').attr('content');
    	    	}

    	    	function getCsrfHeader() {
    	    	    return $('meta[name="_csrf_header"]').attr('content');
    	    	}

                const memberId = $("#memberId").val();
                
                $.ajax({
                    type: "POST",
                    url: "${ctx}/findAuth",
                    data: {
                        memberId: memberId
                    },
		            beforeSend: function(xhr) {
		                xhr.setRequestHeader(getCsrfHeader(), getCsrfToken());
		            },
                    success: function(response) {
                    	console.log(response.num);
                        if (response.status) {
                            $("#result").html("인증번호가 전송되었습니다.");
                            $('#verifyAuthForm').css("display", "block");
                        } else {
                            $("#result").html("<p>Error: " + response.message + "</p>");
                        }
                    },
                    error: function(xhr, status, error) {
                        $("#result").html("<p>서버 오류가 발생했습니다.</p>");
                    }
                });
            });
            
            $("#verifyAuthForm").submit(function(e) {
                e.preventDefault();
                
                function getCsrfToken() {
    	    	    return $('meta[name="_csrf"]').attr('content');
    	    	}

    	    	function getCsrfHeader() {
    	    	    return $('meta[name="_csrf_header"]').attr('content');
    	    	}

                const authNumberString = $("#authNumber").val();
                const authNumber = parseInt(authNumberString);
                
                $.ajax({
                    type: "POST",
                    url: "${ctx}/verifyAuth",
                    data: {
                    	authNumber: authNumber
                    },
		            beforeSend: function(xhr) {
		                xhr.setRequestHeader(getCsrfHeader(), getCsrfToken());
		            },
                    success: function(response) {
                    	console.log(response.num);
                    	if (response.status) {
                            alert(response.message);
                            authToken = response.authToken; // 토큰 저장
                            window.location.href = "/changePassword?token=" + authToken;
                        } else {
                            $("#verifyResult").html("<p>Error: " + response.message + "</p>");
                        }
                    },
                    error: function(xhr, status, error) {
                        $("#verifyResult").html("<p>서버 오류가 발생했습니다.</p>");
                    }
                });
            });
        });
    </script>
</body>
</html>