<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="${ctx}/resources/css/detail.css">
			<script>
				function confirmDelete(journalId) {
				    if (confirm("정말 삭제하시겠습니까?")) {
				        location.href = "${ctx}/journal/remove?journalId=" + journalId;
				    }
				}
			    
				// 수정 버튼 클릭 이벤트 핸들러
			    document.addEventListener('DOMContentLoaded', function() {
			        const modifyButton = document.querySelector('.btn_edit');
			        modifyButton.addEventListener('click', function() {
			            const journalId = ${journal.journalId}; // 게시글 ID 가져오기
			            location.href = '${ctx}/journal/modify?journalId=' + journalId; // 수정 페이지로 이동
			        });
			    });
			</script>			
            <div class="side">
                <ul class="gnb">
                    <li> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/" class="menu1 nolnb">홈</a> <!--2뎁스 메뉴 없을 때 nolnb클래스 붙음-->
                    </li>
                    <li>
                        <a href="javascript:void(0);" class="menu2">식물현황</a>
                        <ul class="lnb">
                            <li> <!--메뉴 선택 시 on클래스 붙음-->
                                <a href="${ctx}/plant/monitoring">실시간 모니터링</a>
                            </li>
                            <li> <!--메뉴 선택 시 on클래스 붙음-->
                                <a href="${ctx}/plant/status">온도/습도/조도</a>
                            </li>
                            <li> <!--메뉴 선택 시 on클래스 붙음-->
                                <a href="${ctx}/plant/watering">급수관리</a>
                            </li>
                        </ul>
                    </li>
                    <li class="on"> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/journal/list" class="menu3 nolnb">관찰일지</a>
                    </li>
                    <li> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/notice/list" class="menu4 nolnb">공지사항</a>
                    </li>
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
	                    <li> <!--메뉴 선택 시 on클래스 붙음-->
	                        <a href="${ctx}/management" class="menu5 nolnb">회원관리</a>
	                    </li>
                    </sec:authorize>
                </ul>
            </div>
            <div class="container">
                <div class="container_inner">
                    <div class="sub_title">
                        <h3>관찰일지</h3>
                        	<button type="button" onclick="history.back()"> 
				                <span><img src="${ctx}/resources/images/ic_backlist.png" alt="목록으로 돌아가기 아이콘"></span>
				                목록으로 돌아가기
				            </button>
<%--                        <button type="button">
                            	<span><img src="${ctx}/resources/images/ic_backlist.png" alt="목록으로 돌아가기 아이콘"></span>
                            	목록으로 돌아가기
                        	</button> --%>
                            <div class="writer_btn_wrap">
                            	<button type="button" class="btn_edit">수정</button>
								<button type="button" class="btn_del" onclick="confirmDelete(${journal.journalId})">삭제</button>
				            </div>
<!--                         <div class="writer_btn_wrap">
	                            <button type="button" class="btn_edit">수정</button>
	                            <button type="button" class="btn_del">삭제</button>
	                        </div> -->
                    </div>
                           <div class="detail">
				            <div class="detail_top">
				                <h3>${journal.journalTitle}</h3>
				                <div class="info">
				                    <span class="name">${journal.nickname}</span> <%-- nickname 출력 --%>
				                    <span class="date"><fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${journal.journalRegdate}" /></span>
				                </div>
				            </div>
				            <div class="detail_cont">
				                ${journal.journalContent}
				            </div>
				        </div>
<%--                     <div class="detail">
	                       <div class="detail_top">
	                            <h3>산세베리아 키우기 80일차! 무럭무럭 잘 자라는중!</h3>
	                            <div class="info">
	                                <span class="name">치즈젤리</span>
	                                <span class="date">2024.05.23 09:23:58</span>
	                            </div>
	                       </div>
	                       <div class="detail_cont">
	                            <p>산세베리아 키우기 80일차! 무럭무럭 잘 자라는중!</p>
	                            <p>산세베리아 키우기 80일차! 무럭무럭 잘 자라는중!</p>
	                            <br>
	                            <img src="${ctx}/resources/images/test_img_01.jpg" alt="게시물 이미지">
	                            <br>
	                            <p>산세베리아 키우기 80일차! 무럭무럭 잘 자라는중!</p>
	                       </div>
	                    </div> --%>
                </div>
            </div>
        </div>
    </div>
</body>
</html>