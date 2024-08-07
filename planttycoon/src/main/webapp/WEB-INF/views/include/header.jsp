<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>식물타이쿤</title>
    <c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css">
    <link rel="stylesheet" href="${ctx}/resources/css/reset.css">
    <link rel="stylesheet" href="${ctx}/resources/css/layout.css">
    
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="${ctx}/resources/script/main.js"></script>
    <script>
	    var ctx = '${ctx}';
	</script>
    <script>
	    $(document).ready(function() {
	    	
	        fetch('${ctx}/resources/json/plantsData.json')
	        	.then(response => response.json())
	            .then(data => {
	            	const select = $('#plant-select');
	            	$.each(data, function (index, plant) {
		                const option = $('<option></option>').val(plant.plant_name).text(plant.plant_name);
		                
		                const currentPlant = $('#currentPlant').val();
		                
		                if (plant.plant_name === currentPlant) {
		                	option.attr('selected', 'selected');
		                }
		                
		                select.append(option);
	            	});
	            })
	            .catch(error => console.error('Error fetching data:', error));
	    });
    </script>
    <script>
    	$(document).ready(function() {
    		
	    	const nicknameRegEx = /^[a-zA-Z0-9\uAC00-\uD7A3_-]{3,15}$/;	// 알파벳 대소문자, 한글, 숫자, 밑줄(_), 하이픈(-)만 허용, 최소 3자 ~ 최대 15자
	    
	    	function showError(message, focusSelector) {
		        $('#signup-error-message').text(message);
		        if (focusSelector) {
		            $(focusSelector).focus();
		        }
		    }
	    	
	    	$("#memberModify").click(function() {
		        // 사용자 입력 값 가져오기
		        const nickname = $('#inputNickname').val();
		   
		      	if (!nickname) {
		            showError('닉네임을 입력해 주세요.', '#inputNickname');
		        } else if (!nicknameRegEx.test(nickname)) {
		            showError('닉네임은 알파벳 대소문자, 한글, 숫자, 밑줄(_), 하이픈(-)만 사용 가능하며, 3~15자 사이여야 합니다.', '#inputNickname');
		        } else {
		            $('form[name="memberModifyForm"]').submit();
		        }
		    });
		});
    </script>
    <script>
	    $(document).ready(function() {
	        <c:if test="${not empty modifyMemberResult}">
	            <c:choose>
	                <c:when test="${modifyMemberResult == 'success'}">
	                    alert('회원 정보가 성공적으로 수정되었습니다.');
	                </c:when>
	                <c:otherwise>
	                    alert('회원 정보 수정에 실패했습니다.');
	                </c:otherwise>
	            </c:choose>
	        </c:if>
	    });
    </script>
</head>
<body>
    <div id="wrapper">
    	<!-- 내정보 팝업 -->
        <div class="my_popup">
            <div class="white_box">
                <div class="popup_title">
                    내 정보
                    <a href="#" class="popup_close">
                        <img src="${ctx}/resources/images/ic_popup_close.png" alt="닫기버튼">
                    </a>
                </div>
                <div class="myinfo_con">
                    <form name="memberModifyForm" action="${ctx}/members/modify" method="post">
                    	<sec:csrfInput/>
                        <div class="id_input">
                            <p>Email</p>
                            <input type="text" name="memberId" placeholder="이메일을 입력하세요"
                            	value='<sec:authentication property='principal.member.memberId'/>' class="readonly" readonly>
                        </div>
                        <div class="name_input">
                            <p>Name</p>
                            <input type="text" id="inputNickname" name="nickname" placeholder="닉네임을 입력하세요"
                            	value='<sec:authentication property='principal.member.nickname'/>'>
                        </div>
                        <div class="name_input">
                            <p>Plant</p>
		                    <select name="plant" id="plant-select">
								<option value="">식물 선택하지 않음</option>
							</select>
                        </div>
                        <div class="modify_warning">
                        	<span id="signup-error-message" class="font_red" style="width: 100%; margin-top: 20px; text-align: center; font-size: 15px;"></span>
                        </div>
                        <button id="memberModify" type="button">내 정보 수정</button>
                    </form>
                    <input type="hidden" id="currentPlant" value='<sec:authentication property='principal.member.plant'/>'>
                    <input type="hidden" id="temperature" value='${latestMeasurement.temperature}'>
                </div>
            </div>
        </div>
        
        <!-- 로그아웃 모달 -->
        <div class="logout_popup">
            <div class="white_box">
                <div class="logout_confirm_message">
	                <p>정말 로그아웃 하시겠습니까?</p>
                </div>
		        <div class="logout_con">
		        	<form action="${ctx}/customLogout" method="post">
						<sec:csrfInput/>
						<button class="btn_white">로그아웃</button>
						<button type="button" class="btn_white logout_popup_close">취소</button>
					</form>
		        </div>
	        </div>
        </div>
        
        <div class="header">
            <div class="mobile_menu">
                <div class="header_btn not-active">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
            <div class="logo">
                <a href="${ctx}/home">
                    <img src="${ctx}/resources/images/logo.png" alt="로고">
                </a>
            </div>
            <div class="login_info">
                <ul>
                    <li>
                        <a href="javascript:void(0);" class="myinfo">내 정보</a>      
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
                                <a href="${ctx}/home" class="menu_depth1">홈</a>
                            </li>
                            <li>
                                <p class="menu_depth1 haslnb">식물현황</p>
                                <div class="menu_depth2">
                                    <a href="${ctx}/plant/monitoring"><span>실시간 모니터링</span></a>
                                    <a href="${ctx}/plant/status"><span>온도/습도/조도</span></a>
                                    <a href="${ctx}/plant/watering"><span>급수관리</span></a>
                                </div>
                            </li>
                            <li>
                                <a href="${ctx}/journal/list" class="menu_depth1">관찰일지</a>
                            </li>
                            <li>
                                <a href="${ctx}/notice/list" class="menu_depth1">공지사항</a>
                            </li>
                            <sec:authorize access="hasRole('ROLE_ADMIN')">
			                    <li> <!--메뉴 선택 시 on클래스 붙음-->
			                        <a href="${ctx}/management" class="menu_depth1">회원관리</a>
			                    </li>
		                    </sec:authorize>
                            <li class="btn_zone">
                                <a href="javascript:void(0);" class="mypage btn_green">내 정보</a>
                                <a href="javascript:void(0);" class="mobileLogout btn_green">로그아웃</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="main">