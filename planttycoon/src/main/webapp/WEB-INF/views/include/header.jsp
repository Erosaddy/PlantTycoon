<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>식물타이쿤</title>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css">
    <link rel="stylesheet" href="${ctx}/resources/css/reset.css">
    <link rel="stylesheet" href="${ctx}/resources/css/layout.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="${ctx}/resources/script/main.js"></script>
</head>
<body>
    <div id="wrapper">
        <div class="header">
            <div class="mobile_menu">
                <div class="header_btn not-active">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
            <div class="logo">
                <a href="javascript:void(0);">
                    <img src="${ctx}/resources/images/logo.png" alt="로고">
                </a>
            </div>
            <div class="login_info">
                <ul>
                    <li>
                        <a href="${ctx }/myinfo" class="myinfo">내 정보</a>      
                    </li>
                    <li>
                        <a href="javascript:void(0);" class="logout">로그아웃</a>
                    </li>
                </ul>
            </div>
            <div class="mobile_menu">
                <div class="side_menu active" style="display: none; opacity: 0;">
                    <div class="menu_wrap">
                        <ul class="menu_list">
                            <li>
                                <a href="${ctx }/" class="menu_depth1">홈</a>
                            </li>
                            <li>
                                <p class="menu_depth1 haslnb">식물현황</p>
                                <div class="menu_depth2">
                                    <a href="${ctx }/plant/monitoring"><span>실시간 모니터링</span></a>
                                    <a href="${ctx }/plant/status"><span>온도/습도/조도</span></a>
                                    <a href="${ctx }/plant/watering"><span>관수제어</span></a>
                                </div>
                            </li>
                            <li>
                                <a href="${ctx }/journal/list" class="menu_depth1">관찰일지</a>
                            </li>
                            <li>
                                <a href="${ctx }/notice/list" class="menu_depth1">공지사항</a>
                            </li>
                            <li>
                                <a href="${ctx }/management" class="menu_depth1">회원관리</a>
                            </li>
                            <li class="btn_zone">
                                <a href="${ctx }/myinfo" class="mypage btn_green">내 정보</a>
                                <a href="javascript:void(0);" class="logout btn_white">로그아웃</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="main">