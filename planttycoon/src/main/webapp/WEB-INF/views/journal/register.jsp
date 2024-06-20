<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script src="${ctx}/resources/ckeditor/ckeditor.js"></script>
<link rel="stylesheet" href="${ctx}/resources/css/write.css">   
		<!-- 사이드 메뉴 -->
            <div class="side">
                <ul class="gnb">
                    <li> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/home" class="menu1 nolnb">홈</a> <!--2뎁스 메뉴 없을 때 nolnb클래스 붙음-->
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
           <!-- 사이드 메뉴 -->
            
           <!-- 메인 메뉴 --> 
            <div class="container">
                <div class="container_inner">

                    <div class="sub_title">
                        <h3>관찰일지</h3>
                       	<button type="button" onclick="location.href='${ctx}/journal/list'">
			                <span><img src="${ctx}/resources/images/ic_backlist.png" alt="목록으로 돌아가기 아이콘"></span>
			                목록으로 돌아가기
			            </button>
                    </div>
                    <div class="write_form">
                        <form action="${ctx}/journal/register" method="post">
                        	<sec:csrfInput/>
				           				
				            <div class="write_box">
				                <p>제목</p>
				                <input type="text" id="journalTitle" name="journalTitle" placeholder="제목을 입력하세요" class="form-control" required>
				            </div>
				
				            <div class="write_box">
				                <p>내용</p>
				                <textarea id="editor" name="journalContent"></textarea> <%-- name 속성 추가 --%>
				            </div>
				
				            <div class="write_btn_wrap">
				                <button type="button" class="btn_white" onclick="location.href='${ctx}/journal/list'">취소</button>
				                <button type="submit" class="btn_green">등록</button>
				            </div>
				        </form>
                    </div>
                </div>
            </div>
            <!-- 메인 메뉴 -->
            <!-- 헤더 연결 div 마무리 -->
        </div>
    </div>
    <!-- 헤더 연결 div 마무리 -->
    <script>
	    ClassicEditor
	    .create(document.querySelector('#editor'), {
	    	 ckfinder: {
	             uploadUrl: '${ctx}/upload/image',
	             withCredentials: true, // CSRF 토큰을 쿠키로 전송하도록 설정
	             headers: {
	            	  '${_csrf.headerName}': document.querySelector('meta[name="_csrf"]').getAttribute('content') // CSRF 토큰 헤더 추가
	                /*  'X-CSRF-TOKEN': document.querySelector('meta[name="_csrf"]').getAttribute('content') // CSRF 토큰 헤더 추가 */
	             }
	         }
	     })
	    .catch(error => {
	        console.error(error);
	    });
	</script>
</body>
</html>