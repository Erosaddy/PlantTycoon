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
    <link rel="stylesheet" href="${ctx}/resources/css/layout.css">
    <link rel="stylesheet" href="${ctx}/resources/css/reset.css">
    <link rel="stylesheet" href="${ctx}/resources/css/join.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
	<div id="wrapper">
		<div class="join_wrap">
            <div class="join">
                <div class="join_box">
                    <div class="join_top">
                        <div class="join_tit">
                            <div class="logo">
                                <img src="${ctx}/resources/images/login_logo.png" alt="로고 이미지">
                            </div>
                            <p>Change Password</p>
                        </div>
                        <form id="changePasswordForm" name="changePasswordForm" action="${ctx}/changePassword" method="post">
                        	<sec:csrfInput/>
                            <div class="pw_input">
                                <p>New Password</p>
                                <input type="password" id="newPassword" name="newPassword" placeholder="새로운 비밀번호를 입력하세요.">
                            </div>
                            <div class="pw_input2">
                                <p>Confirm Password</p>
                                <input type="password" id="newPasswordCheck" placeholder="비밀번호를 다시 한 번 입력하세요.">
                                <span id="password_error_message"></span>
                            </div>
                            
                            <input type="hidden" name="token" value='<c:out value="${sessionScope.authToken}"/>'>
							<span id="submit_password_error_message" class="font_red" style="width: 100%; margin-top: 20px; text-align: center; font-size: 15px;"></span>
                            <div class="join_btn">
                                <button id="resetPassword" class="mt10" type="button">비밀번호 변경</button>
                            </div>
                        </form>
                    </div>
                    <div class="join_bottom">
                        <p>
                            비밀번호 변경을 취소하고 싶으신가요?
                            <a href="/login?resetSession=true">로그인</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <script>
    $(document).ready(function() {
    	$('#newPassword, #newPasswordCheck').on("blur", async function() {
            const password = $('#newPassword').val();
            const passwordCheck = $('#newPasswordCheck').val();
            await checkPasswords(password, passwordCheck);
        });

        async function checkPasswords(password, passwordCheck) {
            return new Promise((resolve) => {
                setTimeout(() => {
                	if (passwordCheck === '') {
                		$('#password_error_message').text('');
                	} else {
	                    if (password === passwordCheck) {
	                        $('#password_error_message').text('비밀번호가 일치합니다.').attr('class', 'font_green');
	                    } else {
	                        $('#password_error_message').text('비밀번호가 일치하지 않습니다.').attr('class', 'font_red');
	                    }
	                    resolve();
                	}
                		
                }, 500); // 0.5초 후에 비밀번호 비교 결과 출력
            });
        }
        
        function showError(message, focusSelector) {
	        $('#submit_password_error_message').text(message);
	        if (focusSelector) {
	            $(focusSelector).focus();
	        }
	    }
    	
	    $("#resetPassword").click(function() {
	        // 사용자 입력 값 가져오기
	        const password = $('#newPassword').val();
	        const passwordCheck = $('#newPasswordCheck').val();
	        const pwCharLenRegEx = /^[A-Za-z\d@$!%*#?&]{7,60}$/;	// 알파벳 대소문자, 숫자, 특수문자만 사용 가능하며 7~60자리 사이일 것
		    const pwRequirementsRegEx = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&]).*$/	// 알파벳, 숫자, 특수문자 적어도 하나씩 사용해야 함
	
	        if (!password) {
	            showError('비밀번호를 입력해 주세요.', '#newPassword');
	            $('#newPassword').val('');
	        } else if (!passwordCheck) {
	            showError('확인용 비밀번호를 입력해 주세요.', '#newPasswordCheck');
	            $('#newPasswordCheck').val('');
	        } else if (password !== passwordCheck) {
	            showError('확인용 비밀번호가 입력한 비밀번호와 일치하지 않습니다.', '#newPassword');
	            $('#newPasswordCheck').val('');
	        } else if (!pwCharLenRegEx.test(password)) {
	            showError('비밀번호는 알파벳 대소문자, 숫자, 특수문자만 사용 가능하며, 7~60자 사이여야 합니다.', '#newPassword');
	            $('#newPassword').val('');
	            $('#newPasswordCheck').val('');
	        } else if (!pwRequirementsRegEx.test(password)) {
	            showError('비밀번호는 각각 적어도 하나의 영문자, 숫자, 특수문자(@$!%*#?&)를 포함해야 합니다.', '#newPassword');
	            $('#newPassword').val('');
	            $('#newPasswordCheck').val('');
	        } else {
	            $('form[name="changePasswordForm"]').submit();
	        }
	    });
    });
    </script>
</body>
</html>