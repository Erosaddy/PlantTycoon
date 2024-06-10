/**
 * 로그인 페이지에서 이메일 혹은 패스워드 입력창이 비어있는지 확인
 */
$(document).ready(function() {
	function CheckEmptyFieldAndSubmit() {
	    const email = $('#inputEmail').val();
	    const password = $('#inputPassword').val();
	    
	    if (email === '') {
	        $('#loginErrorMessage').text('아이디를 입력해 주세요.').show();
	        $('#inputEmail').focus();
	        return;
	    } else if (password === '') {
	        $('#loginErrorMessage').text('비밀번호를 입력해 주세요.').show();
	        $('#inputPassword').focus();
	        return;
	    }
	    
	    $('form[name="loginForm"]').submit();
	}
	
	$('#login').click(CheckEmptyFieldAndSubmit);
	
	$(document).keydown(function(event) {
	    if (event.keyCode === 13) {
	        CheckEmptyFieldAndSubmit();
	    }
	});
});