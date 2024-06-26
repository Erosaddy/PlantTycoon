<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
    <title>Change Password</title>
    <c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>
    <link rel="stylesheet" href="${ctx}/resources/css/layout.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
    <h1>Change Password</h1>
    <!-- 비밀번호 변경 폼 -->
    <form id="changePasswordForm" name="changePasswordForm" action="${ctx}/changePassword" method="post">
    	<sec:csrfInput/>
    	<div>
	        <input type="password" id="newPassword" name="newPassword" placeholder="새로운 비밀번호를 입력하세요.">
    	</div>
    	<div>
	        <input type="password" id="newPasswordCheck" placeholder="비밀번호를 다시 한 번 입력하세요.">
    	</div>
        <input type="hidden" name="token" value='<c:out value="${sessionScope.authToken}"/>'>
        <span id="password_error_message"></span>
        <span id="submit_password_error_message"></span>
        <button id="resetPassword" type="button">Reset Password</button>
    </form>
    <script>
    $(document).ready(function() {
    	$('#newPassword, #newPasswordCheck').on("blur", async function() {
            const password = $('#newPassword').val();
            const passwordCheck = $('#newPasswordCheck').val();

            // 비동기 함수 호출
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