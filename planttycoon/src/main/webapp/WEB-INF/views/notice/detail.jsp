<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="${ctx}/resources/css/detail.css">
			<script>
				function confirmDelete(journalId) {
				    if (confirm("정말 삭제하시겠습니까?")) {
				        location.href = "${ctx}/notice/remove?noticeId=" + noticeId;
				    }
				}
			    
				// 수정 버튼 클릭 이벤트 핸들러
			    document.addEventListener('DOMContentLoaded', function() {
			        const modifyButton = document.querySelector('.btn_edit');
			        modifyButton.addEventListener('click', function() {
			            const noticeId = ${notice.noticeId}; // 게시글 ID 가져오기
			            location.href = '${ctx}/notice/modify?noticeId=' + noticeId; // 수정 페이지로 이동
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
                    <li> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/journal/list" class="menu3 nolnb">관찰일지</a>
                    </li>
                    <li class="on"> <!--메뉴 선택 시 on클래스 붙음-->
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
                        <h3>공지사항</h3>
                        	<button type="button" onclick="history.back()"> 
				                <span><img src="${ctx}/resources/images/ic_backlist.png" alt="목록으로 돌아가기 아이콘"></span>
				                목록으로 돌아가기
				            </button>
				        <sec:authorize access="hasRole('ROLE_ADMIN')">
                        <div class="writer_btn_wrap">
                           	<button type="button" class="btn_edit">수정</button>
							<button type="button" class="btn_del" onclick="confirmDelete(${notice.noticeId})">삭제</button>
			            </div>
			            </sec:authorize>
                    </div>
                        <div class="detail">
				            <div class="detail_top">
				                <h3>${notice.noticeTitle}</h3>
				                <div class="info">
				                    <span class="name">${notice.nickname}</span> <%-- nickname 출력 --%>
				                    <span class="date"><fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${notice.regdate}" /></span>
				                </div>
				            </div>
				            <div class="detail_cont">
				                ${notice.noticeContent}
				            </div>
				        </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>