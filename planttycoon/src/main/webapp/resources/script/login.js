/**
 * Checks if email or password window is empty in login page.
 */

function validateAndSubmit() {
    const inputEmail = $('#inputEmail').val();
    const inputPassword = $('#inputPassword').val();
    
    if (inputEmail === '') {
        $('#loginErrorMessage').text('아이디를 입력해 주세요.').show();
        $('#inputEmail').focus();
        return;
    } else if (inputPassword === '') {
        $('#loginErrorMessage').text('비밀번호를 입력해 주세요.').show();
        $('#inputPassword').focus();
        return;
    }
    
    $('form[name="loginForm"]').submit();
}

$('#login').click(validateAndSubmit);

$(document).keydown(function(event) {
    if (event.keyCode === 13) {
        validateAndSubmit();
    }
});