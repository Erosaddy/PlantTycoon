<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- admin only -->
	<h1>/sample/admin page</h1>
	
	<p>principal : <sec:authentication property="principal"/></p>
	<p>principal.member : <sec:authentication property="principal.member"/></p>
	<p>사용자 이름 : <sec:authentication property="principal.member.nickname"/></p>
	<p>사용자 아이디 : <sec:authentication property="principal.member.memberId"/></p>
	<p>사용자 권한 리스트 : <sec:authentication property="principal.member.authorityList"/></p> 
	
	<a href="/customLogout">Logout</a>
	
	<script>
		var principal = "<sec:authentication property='principal'/>"
		console.log(principal)
	</script>
</body>
</html>