<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css">
<link rel="stylesheet" href="${ctx}/resources/css/reset.css">
<style>
html, body{width: 100%; height: 100%;}
#wrapper{background: #fff; width: 100%; height: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center;}
.error_img{width: 560px; margin-bottom: 20px;}
.error_img img{width: 100%;}
.error_txt{width: 100%; text-align: center; margin-bottom: 20px;}
.error_txt p{font-size: 20px; font-weight: 500; color: #707687;}
a{display: flex; font-size: 16px; color: #40c866; border-bottom: 1px solid #40c866; font-weight: 600;}
</style>
</head>
<body>
<div id="wrapper">
<!-- 	<h1>권한 없음</h1> -->
	
<%-- 	<h2><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage() }"/></h2> --%>
<%-- 	<h2><c:out value="${msg }"/></h2> --%>
	<div class="error_img">
		<img src="${ctx}/resources/images/bg_accesserror.jpg" alt="권한에러 이미지">
	</div>
	<div class="error_txt">
		<p>이 페이지에 대한 접근권한이 없습니다.</p>
	</div>
	<a href="${ctx }/home">이전 페이지로 돌아가기</a>

</div>
	
</body>
</html>