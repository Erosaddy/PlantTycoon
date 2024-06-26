<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
    <title>Change Password</title>
    <c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>
</head>
<body>
    <h1>Change Password</h1>
    <!-- 비밀번호 변경 폼 -->
    <form id="changePasswordForm" action="${ctx}/changePassword" method="post">
    	<sec:csrfInput/>
        <input type="password" id="newPassword" name="newPassword" placeholder="새로운 비밀번호를 입력하세요." required>
        <input type="hidden" name="token" value='<c:out value="${sessionScope.authToken}"/>'>
        <button type="submit">Reset Password</button>
    </form>
</body>
</html>