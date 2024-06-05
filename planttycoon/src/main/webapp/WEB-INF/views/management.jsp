<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>
<link rel="stylesheet" href="${ctx}/resources/css/management.css">
			<script>
			document.addEventListener('DOMContentLoaded', function () {
			    updateListNumbers(); // 초기 로드 시 번호 업데이트
			
			    const searchForm = document.querySelector('.search');
			    searchForm.addEventListener('submit', updateListNumbers); 
			
			    const pagingLinks = document.querySelectorAll('.paging a');
			    pagingLinks.forEach(link => {
			        link.addEventListener('click', function(event) {
			            event.preventDefault();
			            const url = new URL(this.href); // 클릭한 링크의 URL 가져오기
			            
			            // 페이지 이동 및 검색 조건 유지
			            location.href = url.toString();
			            updateListNumbers(); // 페이지 이동 후 번호 업데이트
			        });
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
                        <div class="total">총 <span>81</span>명</div>
                        <div class="search">
                            <div class="search_box">
                            
                            
	                            <form action="${ctx}/management" method="get"> <%-- 폼 태그 추가 --%>
									<div class="search">
										<div class="search_box">
											<select name="type">
												<option value="" ${cri.type == '' ? 'selected' : ''}>전체</option>
												<option value="N" ${cri.type == 'N' ? 'selected' : ''}>제목</option>
												<option value="E" ${cri.type == 'E' ? 'selected' : ''}>내용</option>
											</select>
										</div>
										<div class="search_box">
											<input type="text" name="keyword" value="${cri.keyword}" placeholder="검색어를 입력하세요">
											<button type="submit" class="btn_search">검색</button>
										</div>
									</div>
								</form>
                            
	                            <%-- <form id="searchForm" action="${ctx}/management" method="get">
									<select name="type">
										<option value=""
											<c:out value="${pageMaker.cri.type eq null ? 'selected' : ''}" />>전체</option>
										<option value="N"
											<c:out value="${pageMaker.cri.type eq 'N' ? 'selected' : ''}" />>닉네임</option>
										<option value="E"
											<c:out value="${pageMaker.cri.type eq 'E' ? 'selected' : ''}" />>이메일</option>
									</select>
									<input type="text" name="keyword" placeholder="검색어를 입력하세요" value="${pageMaker.cri.keyword }">
									<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }"> 
									<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
									<button type="submit" class="btn_search">Search</button>
								</form> --%>
                            
                            </div>
                            <div class="search_box">
                            	
                                <!-- <input type="search" placeholder="검색어를 입력하세요">
                                <button type="button" class="btn_search">검색</button> -->
                            </div>
                        </div>
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
                        			<div>${member.regDate}</div>
                        			<div>${member.lastLogin}</div>
                        			<div>
	                        			<label for="toggle" class="toggleSwitch active">
	                                        <span class="toggleButton"></span>
	                                    </label>
                                    </div>
                        		</li>
                        	</c:forEach>
                     
                        </ul>
                        <div class="paging">
			                <p>
			                
			                	<c:if test="${pageMaker.prev}">
						            <span class="numPN over left">
						                <a href="${ctx}/management?pageNum=${pageMaker.prevPageNum}&amount=${pageMaker.cri.amount}&type=${cri.type}&keyword=${cri.keyword}" title="이전 페이지로 이동하기">
						                    <img src="${ctx}/resources/images/ic_prev.png" alt="이전 페이지">
						                </a>
						            </span>
						        </c:if>
						
						        <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
						            <span class="Present ${pageMaker.cri.pageNum == num ? 'on' : ''}">
						                <a href="${ctx}/management?pageNum=${num}&amount=${pageMaker.cri.amount}&type=${cri.type}&keyword=${cri.keyword}">${num}</a>
						            </span>
						        </c:forEach>
						
						        <c:if test="${pageMaker.next}">
						            <span class="numPN over right">
						                <a href="${ctx}/management?pageNum=${pageMaker.nextPageNum}&amount=${pageMaker.cri.amount}&type=${cri.type}&keyword=${cri.keyword}" title="다음 페이지로 이동하기">
						                    <img src="${ctx}/resources/images/ic_next.png" alt="다음 페이지">
						                </a>
						            </span>
						        </c:if>
			                
			                    <%-- <c:if test="${pageMaker.prev}">
			                        <span class="numPN over left">
			                            <a href="${ctx}/management?pageNum=${pageMaker.startPage - 1}&amount=${pageMaker.cri.amount}" title="이전 페이지로 이동하기">
			                                <img src="${ctx}/resources/images/ic_prev.png" alt="이전 페이지">
			                            </a>
			                        </span>
			                    </c:if>
			
			                    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
			                        <span class="${pageMaker.cri.pageNum == num ? 'Present' : ''}">
			                            <a href="${ctx}/management?pageNum=${num}&amount=${pageMaker.cri.amount}" class= "${pageMaker.cri.pageNum == num ? 'on' : ''}">${num}</a>
			                        </span>
			                    </c:forEach>
			
			                    <c:if test="${pageMaker.next}">
			                        <span class="numPN over right">
			                            <a href="${ctx}/management?pageNum=${pageMaker.endPage + 1}&amount=${pageMaker.cri.amount}" title="다음 페이지로 이동하기">
			                                <img src="${ctx}/resources/images/ic_next.png" alt="다음 페이지">
			                            </a>
			                        </span>
			                    </c:if> --%>
			                </p>
			            </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        const toggleList = document.querySelectorAll(".toggleSwitch");

        toggleList.forEach(($toggle) => {
            $toggle.onclick = () => {
                $toggle.classList.toggle('active');
            }
        });
    </script>
</body>
</html>