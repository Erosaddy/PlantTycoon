<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="${ctx}/resources/css/list.css">
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
			
// 			function updateListNumbers() {
			   
// 			}
			</script>
			
			<c:if test="${not empty result}">
			    <script>
			        var result = '${result}';
			        if (result === 'success') {
			            alert('삭제되었습니다.');
			        } else if (result === 'fail') {
			            alert('삭제 실패했습니다.');
			        } else if (result === 'notAuthorized') {
			            alert('삭제 권한이 없습니다.');
			        }
			    </script>
			</c:if> 
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
            <div class="container">
                <div class="container_inner">

                    <div class="sub_title">
                        <h3>관찰일지</h3>
                    </div>
                    <div class="list_top">
                        <div class="total">총 <span>${total}</span>건</div>
                        <div class="btn_wrap">
                        	<div class="btn_wrap">
							    <a href="${ctx}/journal/register" class="btn_write"> <%-- a 태그로 변경 --%>
							        <img src="${ctx}/resources/images/ic_write.png" alt="작성하기 버튼 아이콘">
							        작성하기
							    </a>
							</div>
                        </div>
							<form action="${ctx}/journal/list" method="get"> <%-- 폼 태그 추가 --%>
								<div class="search">
									<div class="search_box">
										<select name="type">
											<%-- <option value="" ${cri.type == '' ? 'selected' : ''}>전체</option> --%>
											<option value="T" ${cri.type == 'T' ? 'selected' : ''}>제목</option>
											<option value="C" ${cri.type == 'C' ? 'selected' : ''}>내용</option>
										</select>
									</div>
									<div class="search_box">
										<input type="text" name="keyword" value="${cri.keyword}" placeholder="검색어를 입력하세요">
										<button type="submit" class="btn_search">검색</button>
									</div>
								</div>
							</form>
                    </div>
                    
                    <div class="list">
                        <ul class="list_head">
                           <li>번호</li> 
                           <li>제목</li> 
                           <li>작성일</li> 
                        </ul>
                        <ul class="list_body">
	                        <c:forEach items="${list}" var="journal" varStatus="status">
							    <li>
							        <div class="num">${pageMaker.total - (pageMaker.cri.skip + status.index)}</div> 
							        <div class="tit">
							            <a href="${ctx}/journal/get?journalId=${journal.journalId}" class="txt_cut1">${journal.journalTitle}</a>
							        </div>
							        <div class="date">
							            <fmt:formatDate pattern="yyyy.MM.dd" value="${journal.journalRegdate}" />
							        </div>
							    </li>
							</c:forEach>
                        </ul>
                        <div class="paging">
						    <p>
						        <c:if test="${pageMaker.prev}">
						            <span class="numPN over left">
						                <a href="${ctx}/journal/list?pageNum=${pageMaker.prevPageNum}&amount=${pageMaker.cri.amount}&type=${cri.type}&keyword=${cri.keyword}" title="이전 페이지로 이동하기">
						                    <img src="${ctx}/resources/images/ic_prev.png" alt="이전 페이지">
						                </a>
						            </span>
						        </c:if>
						
						        <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
						            <span class="paginate_button ${pageMaker.cri.pageNum == num ? 'Present' : ''}"> <%-- 클래스 수정 --%>
						                <a href="${ctx}/journal/list?pageNum=${num}&amount=${pageMaker.cri.amount}&type=${cri.type}&keyword=${cri.keyword}">${num}</a>
						            </span>
						        </c:forEach>
						
						        <c:if test="${pageMaker.next}">
						            <span class="numPN over right">
						                <a href="${ctx}/journal/list?pageNum=${pageMaker.nextPageNum}&amount=${pageMaker.cri.amount}&type=${cri.type}&keyword=${cri.keyword}" title="다음 페이지로 이동하기">
						                    <img src="${ctx}/resources/images/ic_next.png" alt="다음 페이지">
						                </a>
						            </span>
						        </c:if>
						    </p>
						</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>