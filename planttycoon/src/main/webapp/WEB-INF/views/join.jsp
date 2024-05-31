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
                        	<sec:csrfInput/>
                            <div class="id_input">
                                <p>Email</p>
                                <input id="memberId" type="text" name="memberId" placeholder="이메일을 입력하세요" onblur="checkId()">
                                <span id="join_id_error_message" class="font_red"></span>
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
    	
    	let IdIsAvailable = false;	// 추후 signup 버튼을 눌렀을 때 활용
    	
    	function getCsrfToken() {
    	    return $('meta[name="_csrf"]').attr('content');
    	}

    	function getCsrfHeader() {
    	    return $('meta[name="_csrf_header"]').attr('content');
    	}
    
	    function checkId() {
	    	const idRegEx = /^(?=.{1,254}$)(?=.{1,64}@.{1,253}$)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(?:\.[a-zA-Z]{2,})?$/;

	        const memberId = $('#memberId').val();
	        $.ajax({
	            url:'${ctx}/idCheck', // Controller에서 요청 받을 주소
	            type:'post',
	            data:{memberId: memberId},
	            // 시큐리티를 사용하고 있기 때문에, GET을 제외한 POST, PUT, PATCH, DELETE의 상태 변경 API를 사용할 경우 토큰을 함께 보내지 않는다면 요청에 응하지 않는다.
	            beforeSend: function(xhr) {
	                xhr.setRequestHeader(getCsrfHeader(), getCsrfToken());
	            },
	            success:function(cnt){ // 컨트롤러에서 넘어온 cnt값을 받음 
	                if(cnt == 0){ // cnt가 1이 아니면(=0일 경우) -> 사용 가능한 이메일
	                	if (memberId == "") {
	                		$('#join_id_error_message').text('');
	                	} else if (!idLengthRegEx.test(memberId)) {
	                		$('#join_id_error_message').text('올바른 이메일 형식을 입력해 주세요.');
	                	} else {
	                		$('#join_id_error_message').text('사용 가능한 이메일입니다.');
	                		IdIsAvailable = true;
	                	}
	                } else { // cnt가 1일 경우 -> 이미 존재하는 이메일
	                	$('#join_id_error_message').text('이미 사용중인 이메일입니다.').show();
	                }
	            },
	            error:function(){
	                alert("에러입니다");
	            }
	        });
	    };
	    
	  //회원가입
		$("#signUp").click(function() {
			
			// 사용자 입력 값 가져오기
			let inputEmail = $('#email').val();
		    let inputPassword = $('#pw').val();
		    let inputPasswordCheck = $('#pwCheck').val();
		    let inputNickname = $('#nickname').val();
		    
		    const pwUsableCharacterAndLengthRegEx = /^[A-Za-z\d@$!%*#?&]{7,60}$/;    // 알파벳 대소문자, 숫자, 특수문자만 사용 가능하며 7~60자리 사이일 것
		    const pwRequirementsRegEx = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&]).{7,}$/;  // 알파벳, 숫자, 특수문자 적어도 하나씩 사용해야 함
		    const nicknameRegEx = /^[a-zA-Z0-9_-]{3,15}$/;	// 알파벳 대소문자, 숫자, 밑줄(_), 하이픈(-)만 허용, 최소 3자 ~ 최대 15자

		    
		    // 빈값 없도록 제한
		    if (inputUsername == '') {
		        document.getElementById('signup-error-message').innerHTML = '아이디를 입력해 주세요.';
		        document.getElementById('id').focus();
		        return;
		    } else if (inputNickname == '') {
		        document.getElementById('signup-error-message').innerHTML = '닉네임을 입력해 주세요.';
		        document.getElementById('nickName').focus();
		        return;
		    } else if (inputPassword == '') {
		        document.getElementById('signup-error-message').innerHTML = '비밀번호를 입력해 주세요.';
		        document.getElementById('pwCheck').value = '';
		        document.getElementById('pw').focus();
		        return;
		    } else if (inputPasswordCheck == '') {
		        document.getElementById('signup-error-message').innerHTML = '비밀번호 확인을 입력해 주세요.';
		        document.getElementById('pwCheck').focus();
		        return;
		    } else if (inputEmail == '') {
		        document.getElementById('signup-error-message').innerHTML = '이메일을 입력해 주세요.';
		        document.getElementById('email').focus();
		        return;
		    } 
		    
		    // 비밀번호 확인 체크
		    else if (!(inputPassword == inputPasswordCheck)) {
		        document.getElementById('signup-error-message').innerHTML = '확인용 비밀번호가 입력하신 비밀번호와 일치하지 않습니다.';
		        document.getElementById('pw').value = '';
		        document.getElementById('pwCheck').value = '';
		        document.getElementById('pw').focus();
		        return;
		    }
		 	// 아이디 중복 검사
		    else if (!idAvailability) {
		    	document.getElementById('signup-error-message').innerHTML = '아이디를 다시 확인해 주세요..';
		    	document.getElementById('id').focus();
		    	return;
		    }
		    // 비밀번호 길이, 사용가능 문자
		    else if (!pwReg1.test(inputPassword)) {
		        document.getElementById('signup-error-message').innerHTML = '비밀번호는 알파벳 대소문자, 숫자, 특수문자만 사용 가능하며, 7~60자 사이여야 합니다.';
		        document.getElementById('pw').value = '';
		        document.getElementById('pwCheck').value = '';
		        document.getElementById('pw').focus();
		        return;
		    }
		    // 비밀번호 필수로 들어가야 하는 문자들 지정
		    else if (!pwRequirementsRegEx.test(inputPassword)) {
		        document.getElementById('signup-error-message').innerHTML = '비밀번호는 각각 적어도 하나의 영문자, 숫자, 특수문자(@$!%*#?&)를 포함해야 합니다.';
		        document.getElementById('pw').value = '';
		        document.getElementById('pwCheck').value = '';
		        document.getElementById('pw').focus();
		        return;
		    }
		 	// 이메일 중복 검사
		    else if (!emailIsAvailable) {
		    	document.getElementById('signup-error-message').innerHTML = '이메일을 다시 확인해 주세요.';
		    	document.getElementById('email').focus();
		    	return;
		    }
		    
			document.signUpForm.action = "${ctx}/signup";
			document.signUpForm.submit();
			
		});
    </script>
    
</body>
</html>