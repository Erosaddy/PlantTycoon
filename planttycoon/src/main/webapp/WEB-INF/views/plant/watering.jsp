<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="${ctx}/resources/css/watering.css">   
            <div class="side">
                <ul class="gnb">
                    <li> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/home" class="menu1 nolnb">홈</a> <!--2뎁스 메뉴 없을 때 nolnb클래스 붙음-->
                    </li>
                    <li class="on">
                        <a href="javascript:void(0);" class="menu2">식물현황</a>
                        <ul class="lnb">
                            <li> <!--메뉴 선택 시 on클래스 붙음-->
                                <a href="${ctx}/plant/monitoring">실시간 모니터링</a>
                            </li>
                            <li> <!--메뉴 선택 시 on클래스 붙음-->
                                <a href="${ctx}/plant/status">온도/습도/조도</a>
                            </li>
                            <li class="on"> <!--메뉴 선택 시 on클래스 붙음-->
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
                        <h3>식물현황</h3>
                    </div>
                    <div class="watering">
                        <div class="watering_left">
                            <div class="auto_watering">
                                <h4>자동 급수 관리</h4>  
                                <form action="${ctx}/plant/updateInterval" method="post">
                                	<sec:csrfInput/>
                                    <div class="wataring_input">
                                        <input type="text" placeholder="7" name="wateringInterval" value="${wateringInterval}">
                                        <p>일 마다 급수합니다. <span>(미입력시 7일)</span></p>
                                    </div>
                                    <button type="submit">저장</button>
                                </form>
                            </div>
                            <div class="watering_log">
                                <h4>급수기록</h4>
                                <div class="log_list">
                                    <ul class="log_head">
                                        <li>급수날짜</li>
                                        <li>급수타입</li>
                                    </ul>
                                    <ul class="log_body">
	                                    <c:forEach var="record" items="${records}">
			                                <li>
			                                    <div><fmt:formatDate value="${record.wateredRegdate}" pattern="yyyy.MM.dd HH:mm:ss"/></div>
			                                    <div>${record.wateringType}</div>
			                                </li>
			                            </c:forEach>
<!--                                         <li> -->
<!--                                             <div>2024.05.28 15:33:02</div> -->
<!--                                             <div>자동</div> -->
<!--                                         </li> -->
                                        
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
					                
					                	<form id="actionForm" action="${ctx }/plant/watering" method="get">
											<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">                            
											<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			                            </form>
					                
					                </p>
					            </div>
                                </div>
                            </div>
                        </div>
                        <div class="watering_right">
                            <h4>월별 급수 현황</h4>
                            <div class="chart">
                                <!-- 차트 들어갈 영역 -->
                            </div>
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
    });
</script>
</body>
</html>