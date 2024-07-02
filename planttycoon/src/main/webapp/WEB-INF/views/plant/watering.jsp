<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="${ctx}/resources/css/watering.css">   
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
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
                                        <input type="number" min="1" max="999" placeholder="7" name="wateringInterval" value="${wateringInterval}" required>
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
	                                    <c:choose>
							                <c:when test="${empty records}">

							                	<div class="nodata">데이터가 없습니다</div>

							                </c:when>
							                <c:otherwise>
							                    <c:forEach var="record" items="${records}">
							                        <li>
							                            <div><fmt:formatDate value="${record.wateredRegdate}" pattern="yyyy.MM.dd HH:mm:ss"/></div>
							                            <div>${record.wateringType}</div>
							                        </li>
							                    </c:forEach>
							                </c:otherwise>
							            </c:choose>
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
                                <canvas id="monthlyWatering"></canvas>
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
		
		// 월별 급수 현황 데이터 가져오기
		$.ajax({
		    url: '${ctx}/api/monthlyWateringData',
		    type: 'GET',
		    dataType: 'json',
		    success: function(data) {
		        var today = new Date();
		        var currentMonth = today.getMonth() + 1; // 현재 월
		        var months = [];
		        
		        // 1월부터 현재 월까지의 월 데이터 생성
		        for (var i = 1; i <= currentMonth; i++) {
		            months.push(i + '월');
		        }
		        
		        // 데이터 처리
		        var autoCounts = Array.from({ length: currentMonth }, () => 0);
		        var manualCounts = Array.from({ length: currentMonth }, () => 0);
		        
		        if (data && data.length > 0) {
		            // 서버에서 받은 데이터를 월별 카운트에 반영
		            data.forEach(function(item) {
		                var index = parseInt(item.month) - 1; // month는 1부터 시작하므로 -1 해줍니다.
		                autoCounts[index] = item.autoCount;
		                manualCounts[index] = item.manualCount;
		            });
		        }
		        
		        // Chart.js 설정
		        const ctx = document.getElementById('monthlyWatering').getContext('2d');
		        new Chart(ctx, {
		            type: 'bar',
		            data: {
		                labels: months,
		                datasets: [
		                    {
		                        label: '자동 급수',
		                        data: autoCounts,
		                        backgroundColor: 'rgba(254, 97, 130, 0.5)',
		                        borderColor: 'rgba(254, 97, 130, 1)',
		                        borderWidth: 1
		                    },
		                    {
		                        label: '수동 급수',
		                        data: manualCounts,
		                        backgroundColor: 'rgba(48, 160, 234, 0.5)',
		                        borderColor: 'rgba(48, 160, 234, 1)',
		                        borderWidth: 1
		                    }
		                ]
		            },
		            options: {
		                maintainAspectRatio: false,
		                responsive: true,
		                scales: {
		                    x: {
		                        stacked: true,
		                    },
		                    y: {
		                        stacked: true,
		                        ticks: {
		                            beginAtZero: true,
		                            stepSize: 1,
		                        },
		                    }
		                }
		            }
		        });
		    },
		    error: function(jqXHR, textStatus, errorThrown) {
		        console.error('AJAX error:', textStatus, errorThrown);
		    }
		});
    });
</script>
</body>
</html>