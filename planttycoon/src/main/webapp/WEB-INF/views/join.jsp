<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>식물타이쿤</title>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css">
	<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>
    <link rel="stylesheet" href="${ctx}/resources/css/reset.css">
    <link rel="stylesheet" href="${ctx}/resources/css/layout.css">
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
                            <p>Register your account</p>
                        </div>
                        <form action="${ctx}/join" name="joinForm" method="post">
                        	<sec:csrfInput/>
                            <div class="id_input">
                                <p>Email</p>
                                <input id="inputEmail" type="text" name="memberId" placeholder="이메일을 입력하세요">
                                <span id="join_id_error_message" class="font_red"></span>
                            </div>
                            <div class="pw_input">
                                <p>Password</p>
                                <input id="inputPassword" type="password" name="memberPw" placeholder="비밀번호를 입력하세요">
                            </div>
                            <div class="pw_input2">
                                <p>Confirm Password</p>
                                <input id="inputPasswordCheck" type="password" placeholder="비밀번호를 다시 입력하세요">
                                <span id="join_password_error_message"></span>
                            </div>
                            <div class="name_input">
                                <p>Name</p>
                                <input id="inputNickname" type="text" name="nickname" placeholder="닉네임을 입력하세요">
                            </div>
                            <span id="signup-error-message" class="font_red" style="width: 100%; margin-top: 20px; text-align: center; font-size: 15px;"></span>
                            <div class="join_btn">
                                <button id="join" type="button">회원가입</button>
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
    
    <script>
	    $(document).ready(function() {
	        $('#inputPassword, #inputPasswordCheck').on('blur', async function() {
	            const password = $('#inputPassword').val();
	            const passwordCheck = $('#inputPasswordCheck').val();
	
	            // 비동기 함수 호출
	            await checkPasswords(password, passwordCheck);
	        });
	
	        async function checkPasswords(password, passwordCheck) {
	            return new Promise((resolve) => {
	                setTimeout(() => {
	                	if (passwordCheck === '') {
	                		$('#join_password_error_message').text('');
	                	} else {
		                    if (password === passwordCheck) {
		                        $('#join_password_error_message').text('비밀번호가 일치합니다.').attr('class', 'font_green');
		                    } else {
		                        $('#join_password_error_message').text('비밀번호가 일치하지 않습니다.').attr('class', 'font_red');
		                    }
		                    resolve();
	                	}
	                		
	                }, 500); // 0.5초 후에 비밀번호 비교 결과 출력
	            });
	        }
	        
	        let idIsAvailable = false;	// signup 버튼을 눌렀을 때 아이디가 적절한지 검사하는 용도
	    	
	    	function getCsrfToken() {
	    	    return $('meta[name="_csrf"]').attr('content');
	    	}

	    	function getCsrfHeader() {
	    	    return $('meta[name="_csrf_header"]').attr('content');
	    	}
	    	
	    	$('#inputEmail').on('blur', function() {
		    	const idRegEx = /^(?=.{1,254}$)(?=.{1,64}@.{1,253}$)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(?:\.[a-zA-Z]{2,})?$/;

		        const email = $('#inputEmail').val();
		        
		        $.ajax({
		            url:'${ctx}/idCheck', // Controller에서 요청 받을 주소
		            type:'post',
		            data:{memberId: email},
		            // 시큐리티를 사용하고 있기 때문에, GET을 제외한 POST, PUT, PATCH, DELETE의 상태 변경 API를 사용할 경우 토큰을 함께 보내지 않는다면 요청에 응하지 않는다.
		            beforeSend: function(xhr) {
		                xhr.setRequestHeader(getCsrfHeader(), getCsrfToken());
		            },
		            success:function(cnt){ // 컨트롤러에서 넘어온 cnt값을 받음 
		                if(cnt == 0){ // cnt가 1이 아니면(=0일 경우) -> 사용 가능한 이메일
		                	if (email == "") {
		                		$('#join_id_error_message').text('');
		                	} else if (!idRegEx.test(email)) {
		                		$('#join_id_error_message').text('올바른 이메일 형식을 입력해 주세요.').attr('class', 'font_red');
		                	} else {
		                		$('#join_id_error_message').text('사용 가능한 이메일입니다.').attr('class', 'font_green');
		                		idIsAvailable = true;
		                	}
		                } else { // cnt가 1일 경우 -> 이미 존재하는 이메일
		                	$('#join_id_error_message').text('이미 사용중인 이메일입니다.');
		                }
		            },
		            error:function(){
		                alert("에러가 발생했습니다.");
		            }
		        });
	    	});
		   
		    const pwCharLenRegEx = /^[A-Za-z\d@$!%*#?&]{7,60}$/;	// 알파벳 대소문자, 숫자, 특수문자만 사용 가능하며 7~60자리 사이일 것
		    const pwRequirementsRegEx = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&]).*$/	// 알파벳, 숫자, 특수문자 적어도 하나씩 사용해야 함
		    const nicknameRegEx = /^[a-zA-Z0-9\uAC00-\uD7A3_-]{3,15}$/;	// 알파벳 대소문자, 한글, 숫자, 밑줄(_), 하이픈(-)만 허용, 최소 3자 ~ 최대 15자

		    function showError(message, focusSelector) {
		        $('#signup-error-message').text(message);
		        if (focusSelector) {
		            $(focusSelector).focus();
		        }
		    }

		    $("#join").click(function() {
		        // 사용자 입력 값 가져오기
		        const email = $('#inputEmail').val();
		        const password = $('#inputPassword').val();
		        const passwordCheck = $('#inputPasswordCheck').val();
		        const nickname = $('#inputNickname').val();

		        if (!email) {
		            showError('이메일을 입력해 주세요.', '#inputEmail');
		        } else if (!password) {
		            showError('비밀번호를 입력해 주세요.', '#inputPassword');
		            $('#inputPasswordCheck').val('');
		        } else if (!passwordCheck) {
		            showError('비밀번호 확인을 입력해 주세요.', '#inputPasswordCheck');
		        } else if (!nickname) {
		            showError('닉네임을 입력해 주세요.', '#inputNickname');
		        } else if (!idIsAvailable) {
		            showError('이메일을 다시 확인해 주세요.', '#inputEmail');
		        } else if (password !== passwordCheck) {
		            showError('확인용 비밀번호가 입력한 비밀번호와 일치하지 않습니다.', '#inputPassword');
		            $('#inputPasswordCheck').val('');
		        } else if (!pwCharLenRegEx.test(password)) {
		            showError('비밀번호는 알파벳 대소문자, 숫자, 특수문자만 사용 가능하며, 7~60자 사이여야 합니다.', '#inputPassword');
		            $('#inputPassword').val('');
		            $('#inputPasswordCheck').val('');
		        } else if (!pwRequirementsRegEx.test(password)) {
		            showError('비밀번호는 각각 적어도 하나의 영문자, 숫자, 특수문자(@$!%*#?&)를 포함해야 합니다.', '#inputPassword');
		            $('#inputPasswordCheck').val('');
		        } else if (!nicknameRegEx.test(nickname)) {
		            showError('닉네임은 알파벳 대소문자, 한글, 숫자, 밑줄(_), 하이픈(-)만 사용 가능하며, 3~15자 사이여야 합니다.', '#inputNickname');
		        } else {
		            $('form[name="joinForm"]').submit();
		        }
		    });
	    });
    </script>
</body>
</html>