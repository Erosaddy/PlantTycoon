<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>
<link rel="stylesheet" href="${ctx}/resources/css/management.css">
            <div class="side">
                <ul class="gnb">
                    <li> <!--메뉴 선택 시 on클래스 붙음요-->
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
                    <li> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/journal/list" class="menu3 nolnb">관찰일지</a>
                    </li>
                    <li> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/notice/list" class="menu4 nolnb">공지사항</a>
                    </li>
                    <li class="on"> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/management" class="menu5 nolnb">회원관리</a>
                    </li>
                </ul>
            </div>
            <div class="container">
                <div class="container_inner">

                    <div class="sub_title">
                        <h3>회원관리</h3>
                    </div>
                    <div class="list_top">
                        <div class="total">총 <span>${pageMaker.total}</span>명</div>
                        <form id="searchForm" action="${ctx}/management" method="get">
	                        <div class="search">
	                            	<div class="search_box">
	                            
										<select name="type">
											<option value=""   <c:out value="${pageMaker.cri.type == null ? 'selected' : ''}" />>-------</option>
											<option value="N"  <c:out value="${pageMaker.cri.type eq 'N'  ? 'selected' : ''}" />>닉네임</option>
											<option value="E"  <c:out value="${pageMaker.cri.type eq 'E'  ? 'selected' : ''}" />>이메일</option>
										</select>
	                            
		                            </div>
		                            <div class="search_box">
										<input type="text" name="keyword" placeholder="검색어를 입력하세요" value="${pageMaker.cri.keyword }">
										<button class="btn_search">Search</button>
		                            </div>
									<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }"> 
									<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	                        </div>
						</form>
                    </div>
                    <div class="list">
                        <ul class="list_head">
                           <li>닉네임</li> 
                           <li>이메일</li> 
                           <li>회원등급</li> 
                           <li>가입일</li>
                           <li>마지막 로그인</li> 
                           <li>활성화 여부</li> 
                        </ul>
                        <ul class="list_body">
                        	<c:if test="${empty memberList}">
                        		<li class="no_result">
                        			<p>회원 정보가 존재하지 않습니다.</p>
                        		</li>
                        	</c:if>
                        	<c:forEach items="${memberList}" var="member">
                        		<li>
                        			<div>${member.nickname}</div>
                        			<div>${member.memberId}</div>
                        			<c:choose>
                        				<c:when test="${member.authorityList[0].authority eq 'ROLE_ADMIN'}">
                        					<div>관리자</div>
                        				</c:when>
                        				<c:otherwise>
                        					<div>일반 회원</div>
                        				</c:otherwise>
                        			</c:choose>
                        			<div><fmt:formatDate pattern="yyyy.MM.dd" value="${member.regDate}" /></div>
                        			<div><fmt:formatDate pattern="yyyy.MM.dd" value="${member.lastLogin}" /></div>
                        			<div>
                        				<c:if test="${member.authorityList[0].authority eq 'ROLE_MEMBER'}">
	                        				<c:choose>
	                        					<c:when test="${member.enabled}">
	                        						<label for="toggle" class="toggleSwitch active" data-member-id="${member.memberId}" >
				                                        <span class="toggleButton"></span>
				                                    </label>
	                        					</c:when>
	                        					<c:otherwise>
	                        						<label for="toggle" class="toggleSwitch" data-member-id="${member.memberId}">
				                                        <span class="toggleButton"></span>
				                                    </label>
	                        					</c:otherwise>
	                        				</c:choose>
                        				</c:if>
                                    </div>
                        		</li>
                        	</c:forEach>
                        </ul>
                        <div class="paging">
			                <p>
	                            	
                           		<c:if test="${pageMaker.prev }">
                           			<span class="paginate_button numPN over left">
                           				<a href="${pageMaker.startPage - 1}"> 
											<img src="${ctx}/resources/images/ic_prev.png" alt="이전 페이지">
										</a>
                           			</span>
                           		</c:if>
                           		
                        		<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
                        			<span class="paginate_button ${pageMaker.cri.pageNum == num ? 'Present' : '' }"><a href="${num }">${num }</a></span>
                        		</c:forEach>
                          			
                          		<c:if test="${pageMaker.next }">
                           			<span class="paginate_button numPN over right">
                           				<a href="${pageMaker.endPage + 1}"> 
											<img src="${ctx}/resources/images/ic_next.png" alt="다음 페이지">
										</a>
                           			</span>
                           		</c:if>
			                
			                	<form id="actionForm" action="${ctx }/management" method="get">
									<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">                            
									<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
									<input type="hidden" name="type" value="${pageMaker.cri.type }">
	                            	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">                           
	                            </form>
			                
			                </p>
			            </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
    $(document).ready(function() {
	    var actionForm = $("#actionForm");
		
		$(".paginate_button a").on("click", function(e) {
			e.preventDefault();
			
			console.log("click");
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		var searchForm = $("#searchForm");
		$("#searchForm button").on("click", function(e) {
			if(!searchForm.find("option:selected").val()) {
				alert("검색 종류를 선택하세요");
				
				return false;
			}
			
			if(!searchForm.find("input[name='keyword']").val()) {
				alert("검색어를 입력하세요");
				
				return false;
			}
			
			searchForm.find("input[name='pageNum']").val("1");
			
			e.preventDefault();
			searchForm.submit();
		});
		
		function getCsrfToken() {
    	    return $('meta[name="_csrf"]').attr('content');
    	}

    	function getCsrfHeader() {
    	    return $('meta[name="_csrf_header"]').attr('content');
    	}
		
		$('.toggleSwitch').on('click', function() {
	        var $toggle = $(this);
	        var enabled = $toggle.hasClass('active') ? '0' : '1';
	        var memberId = String($toggle.data('member-id'));
	        
	        $.ajax({
	            url: '${ctx}/toggleEnabled',
	            type: 'post',
	            data: {
	            	enabled: enabled,
	                memberId: memberId
	            },
	            beforeSend: function(xhr) {
	                xhr.setRequestHeader(getCsrfHeader(), getCsrfToken());
	            },
	            success: function(cnt) {
	                if (cnt == "1") {
	                    $toggle.toggleClass('active');
	                } else {
	                    alert("변경에 실패했습니다.");
	                }
	            },
	            error: function() {
	                alert("에러입니다");
	            }
	        });
	    });
    });
    </script>
</body>
</html>