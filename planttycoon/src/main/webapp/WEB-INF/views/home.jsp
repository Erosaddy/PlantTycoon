<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<link rel="stylesheet" href="${ctx}/resources/css/plant.css">   
<link rel="stylesheet" href="${ctx}/resources/css/home.css">   
            <div class="side">
                <ul class="gnb">
                    <li class="on"> <!--메뉴 선택 시 on클래스 붙음-->
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
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
	                    <li> <!--메뉴 선택 시 on클래스 붙음-->
	                        <a href="${ctx}/management" class="menu5 nolnb">회원관리</a>
	                    </li>
                    </sec:authorize>
                </ul>
            </div>
            <div class="container">
                <div class="container_inner">
                
	                <sec:authorize access="isAuthenticated()">
					    <sec:authentication property="principal.member.plant" var="plant"/>
					</sec:authorize>
                
                	<div class="sub_title">
                        <h3>홈 화면
	                    	<c:choose>
							    <c:when test="${not empty plant}">
							        <span>[<sec:authentication property="principal.member.plant"/>]</span>
							    </c:when>
							    <c:otherwise>
							        <span>[선택된 식물 없음]</span>
							    </c:otherwise>
							</c:choose>
                        </h3>
                    </div>

                    <div class="status">
                       <div class="status_top">
                            <div class="status_con">
                                <div class="txt" id="temperatureStatus">
					                <p>온도 <span class="status-indicator"></span></p>
					                
					                <c:choose>
						                <c:when test="${not empty latestMeasurement.temperature}">
						                	<c:set var="temp" value="${latestMeasurement.temperature}"/>
						                	<!-- Math.round가 jstl에서 작동하지 않아 수작업으로 반올림 처리 -->
						                	<c:set var="roundedTemperature" value="${temp+((temp%1>0.5)?(1-(temp%1))%1:-(temp%1))}" />
											<c:set var="formattedTemperature" value="${fn:replace(roundedTemperature, '.0', '')}" />
							                <strong><span id="temperatureValue">${formattedTemperature}</span>˚C</strong>
					                	</c:when>
					                	<c:otherwise>
					                		<strong>N/A</strong>
					                	</c:otherwise>
					                </c:choose>
					                
					                <p class="gray">적정 온도 
					                	<span id="minTemperature"></span> ~ <span id="maxTemperature"></span>˚C
				                	</p>
					            </div>
					            <div class="icon">
					                <img src="${ctx}/resources/images/ic_status1.png" alt="온도 아이콘">
					            </div>
                            </div>
                            <div class="status_con">
                                <div class="txt" id="humidityStatus">
					                <p>대기 습도 <span class="status-indicator"></span></p>
					                <c:choose>
						                <c:when test="${not empty latestMeasurement.humidity}">
						                	<c:set var="hum" value="${latestMeasurement.humidity}"/>
						                	<!-- 대기 습도 반올림 -->
						                	<c:set var="roundedHumidity" value="${hum+((hum%1>0.5)?(1-(hum%1))%1:-(hum%1))}" />
											<c:set var="formattedHumidity" value="${fn:replace(roundedHumidity, '.0', '')}" />
							                <strong><span id="humidityValue">${formattedHumidity}</span>%</strong>
					                	</c:when>
					                	<c:otherwise>
					                		<strong>N/A</strong>
					                	</c:otherwise>
					                </c:choose>
					                
					                <p class="gray">적정 습도
					                	<span id="minHumidity"></span> ~ <span id="maxHumidity"></span>%
					                </p>
					            </div>
					            <div class="icon">
					                <img src="${ctx}/resources/images/ic_status2.png" alt="습도 아이콘">
					            </div>
                            </div>
                            <div class="status_con">
                                <div class="txt" id="lightStatus">
					                <p>조도 <span class="status-indicator"></span></p>
					                
					                <c:choose>
						                <c:when test="${not empty latestMeasurement.illuminance}">
							                <strong><span id="lightValue">${latestMeasurement.illuminance}</span>lux</strong>
					                	</c:when>
					                	<c:otherwise>
					                		<strong>N/A</strong>
					                	</c:otherwise>
					                </c:choose>
					                
					                <p class="gray">적정 조도
					                	<span id="minLight"></span> lux 이상
					                </p>
					            </div>
					            <div class="icon">
					                <img src="${ctx}/resources/images/ic_status3.png" alt="조도 아이콘">
					            </div>
                            </div>
                            <div class="status_con">
                                <div class="txt" id="soilMoistureStatus">
					                <p>토양 습도 <span class="status-indicator"></span></p>
					                
					                <c:choose>
						                <c:when test="${not empty latestMeasurement.soilMoisture}">
						                	<c:set var="soilMo" value="${latestMeasurement.soilMoisture}"/>
						                	<!-- 토양 습도 반올림 -->
						                	<c:set var="roundedSoilMoisture" value="${soilMo+((soilMo%1>0.5)?(1-(soilMo%1))%1:-(soilMo%1))}" />
											<c:set var="formattedSoilMoisture" value="${fn:replace(roundedSoilMoisture, '.0', '')}" />
							                <strong><span id="soilMoistureValue">${formattedSoilMoisture}</span>%</strong>
					                	</c:when>
					                	<c:otherwise>
					                		<strong>N/A</strong>
					                	</c:otherwise>
					                </c:choose>
					                
					                <p class="gray">적정 습도
					                <span id="minSoilMoisture"></span> ~ <span id="maxSoilMoisture"></span>%
					                </p>
					            </div>
					            <div class="icon">
					                <img src="${ctx}/resources/images/ic_status4.png" alt="토양 습도 아이콘">
					            </div>
                            </div>
                       </div>
                       <div class="home">
                            <div class="home_left">
                                <div id="plant_emotion" class="plant_emotion"> <!-- 모두 만족일때 smile, 온도 높을때 high_t, 온도 낮을때 low_t, 토양습도 높을때 high_m, 토양습도 낮을때 low_m 클래스 붙음-->
                                    <div class="plant_bg">
                                    </div>
                                    <div class="plant_txt">
                                        <img src="${ctx}/resources/images/plant_text_bg.png" alt="식물 말풍선">
                                        <p>식물을<br>선택해 주세요!</p>
                                    </div>
                                </div>
                                <div class="plant_btn">
                                    <button type="button" class="water" onclick="startPump()">물주기<img src="${ctx}/resources/images/ic_water.png" alt="물주기 아이콘"></button>
                                	<button type="button" class="led" id="toggleLed">조명 켜기<img src="${ctx}/resources/images/ic_led.png" alt="조명 켜기 아이콘"></button>
                                </div>
                            </div>
                            <div class="home_right">
                                <div class="wataring_dday">
                                    <p>다음 급수일까지<span><strong>${daysLeft}</strong>일 <strong>${hoursLeft}</strong>시간 <strong>${minutesLeft}</strong>분</span>남았습니다.</p>
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
							                
							                	<form id="actionForm" action="${ctx }/home" method="get">
													<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">                            
													<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
					                            </form>
							                
							                </p>
							            </div>
                                    </div>
                                </div>
                            </div>
                       </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="module">
	import { plantMessages } from '${ctx}/resources/script/plantmessages.js';

	    $(window).on("load", function() {
	    	const currentPlant = $('#currentPlant').val();
	        fetch(`${ctx}/resources/json/plantsData.json`)
	        	.then(response => response.json())
	            .then(data => {
	            	const selectedPlant = data.find(plant => plant.plant_name === currentPlant);
	            	if (selectedPlant) {
	            		
	            		const minTemperature = selectedPlant.min_temperature_celcius;
	        		    const maxTemperature = selectedPlant.max_temperature_celcius;
	        		    
	        		    const minHumidity = selectedPlant.min_humidity_percentage;
	        		    const maxHumidity = selectedPlant.max_humidity_percentage;
	        		    
	        		    const minLight = selectedPlant.min_light_lux;
	        		    const maxLight = selectedPlant.max_light_lux;
	        		    
	        		    const minSoilMoisture = selectedPlant.min_soil_moisture_percentage;
	        		    const maxSoilMoisture = selectedPlant.max_soil_moisture_percentage;
	            		
	    			    $('#minTemperature').html(minTemperature);
	    			    $('#maxTemperature').html(maxTemperature);
	    			    $('#minHumidity').html(minHumidity);
	    			    $('#maxHumidity').html(maxHumidity);
	    			    $('#minLight').html(minLight);
	    			    $('#maxLight').html(maxLight);
	    			    $('#minSoilMoisture').html(minSoilMoisture);
	    			    $('#maxSoilMoisture').html(maxSoilMoisture);
	    			    
	    			 	// 온도
	    			    const temperature = parseInt(document.getElementById('temperatureValue').textContent);
	    			    const temperatureStatus = document.getElementById('temperatureStatus').querySelector('.status-indicator');
	    			    if (temperature < minTemperature) {
	    			        temperatureStatus.classList.add('low');
	    			        temperatureStatus.classList.remove('high', 'ok');
	    			    } else if (temperature > maxTemperature) {
	    			        temperatureStatus.classList.add('high');
	    			        temperatureStatus.classList.remove('low', 'ok');
	    			    } else {
	    			        temperatureStatus.classList.add('ok');
	    			    }
	    			    
	    			    // 대기 습도
	    			    const humidity = parseInt(document.getElementById('humidityValue').textContent);
	    			    const humidityStatus = document.getElementById('humidityStatus').querySelector('.status-indicator');
	    			    if (humidity < minHumidity) {
	    			        humidityStatus.classList.add('low');
	    			        humidityStatus.classList.remove('high', 'ok');
	    			    } else if (humidity > maxHumidity) {
	    			        humidityStatus.classList.add('high');
	    			        humidityStatus.classList.remove('low', 'ok');
	    			    } else {
	    			        humidityStatus.classList.add('ok');
	    			        humidityStatus.classList.remove('low', 'high');
	    			    }
	
	    			    // 조도
	    			    const illuminance = parseInt(document.getElementById('lightValue').textContent);
	    			    const lightStatus = document.getElementById('lightStatus').querySelector('.status-indicator');
	    			    if (illuminance < minLight) {
	    			        lightStatus.classList.add('low');
	    			        lightStatus.classList.remove('high', 'ok');
	    			    } else {
	    			        lightStatus.classList.add('ok');
	    			        lightStatus.classList.remove('low', 'high');
	    			    }
	
	    			    // 토양 습도
	    			    const soilMoisture = parseInt(document.getElementById('soilMoistureValue').textContent);
	    			    const soilMoistureStatus = document.getElementById('soilMoistureStatus').querySelector('.status-indicator');
	    			    if (soilMoisture < minSoilMoisture) {
	    			        soilMoistureStatus.classList.add('low');
	    			        soilMoistureStatus.classList.remove('high', 'ok');
	    			    } else if (soilMoisture > maxSoilMoisture) {
	    			        soilMoistureStatus.classList.add('high');
	    			        soilMoistureStatus.classList.remove('low', 'ok');
	    			    } else {
	    			        soilMoistureStatus.classList.add('ok');
	    			        soilMoistureStatus.classList.remove('low', 'high');
	    			    }
	    			    
						// 해당 이름의 클래스 존재 여부에 따라 true or false 반환
	    			    const soilMoistureHigh = $('#soilMoistureStatus .status-indicator').hasClass("high");
	    			    const soilMoistureLow = $('#soilMoistureStatus .status-indicator').hasClass("low");
	    			    const temperatureHigh = $('#temperatureStatus .status-indicator').hasClass("high");
	    			    const temperatureLow = $('#temperatureStatus .status-indicator').hasClass("low");
	    			    const humidityHigh = $('#humidityStatus .status-indicator').hasClass("high");
	    			    const humidityLow = $('#humidityStatus .status-indicator').hasClass("low");
	    			    
						const plantEmotion = $('#plant_emotion');
						const randomNum = Math.floor(Math.random()*5);
						const plantTxt = $('.plant_txt p');
	
	    			    if (soilMoistureHigh) {
	    			    	plantTxt.html(plantMessages.highSoilMoisture[randomNum]);
	    			    } else if (soilMoistureLow) {
	    			    	plantTxt.html(plantMessages.lowSoilMoisture[randomNum]);							
	    			    } else if (temperatureHigh) {
	    			    	plantTxt.html(plantMessages.highTemperature[randomNum]);
	    			    } else if (temperatureLow) {
	    			    	plantTxt.html(plantMessages.lowTemperature[randomNum]);
	    			    } else if (humidityHigh) {
	    			    	plantTxt.html(plantMessages.highHumidity[randomNum]);
	    			    } else if (humidityLow) {
	    			    	plantTxt.html(plantMessages.lowHumidity[randomNum]);
	    			    } else {
							plantTxt.html(plantMessages.optimal[randomNum]);
	    			    	plantEmotion.addClass('smile');
	    			    }
	    			    
	            	} else {
						// 아무 식물도 선택되지 않았을 때
	            		$('#minTemperature').html('');
	    			    $('#maxTemperature').html('');
	    			    $('#minHumidity').html('');
	    			    $('#maxHumidity').html('');
	    			    $('#minLight').html('');
	    			    $('#maxLight').html('');
	    			    $('#minSoilMoisture').html('');
	    			    $('#maxSoilMoisture').html('');
	    			    const statusIndicator = $('.status-indicator');
	    			    statusIndicator.css('display','none');
	    			    const optimalConditionText = $('.gray');
	    			    optimalConditionText.css('display', 'none');

						const plantEmotion = $('#plant_emotion');
	    			    plantEmotion.addClass('smile');
	            	}
	            })
	            .catch(error => console.error('Error fetching data:', error));
	    });
    </script>
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
<script>
$(document).ready(function() {
    $('#toggleLed').click(function() {
        // CSRF 토큰 가져오기
        const csrfToken = $('meta[name="_csrf"]').attr('content');
        const csrfHeader = $('meta[name="_csrf_header"]').attr('content');
        
        // LED 상태 토글 API 호출
        $.ajax({
            url: "${ctx}/led/toggle",
            type: "POST",
            headers: {
                'Content-Type': 'application/json',
                [csrfHeader]: csrfToken // CSRF 토큰 추가
            },
            success: function(data) {
                // 성공적으로 LED 상태를 토글한 경우, 버튼 텍스트를 업데이트
                if (data === "T") {
                    $('#toggleLed').html('조명 끄기 <img src="${ctx}/resources/images/ic_led.png" alt="조명 끄기 아이콘">');
                } else {
                    $('#toggleLed').html('조명 켜기 <img src="${ctx}/resources/images/ic_led.png" alt="조명 켜기 아이콘">');
                }
            },
            error: function() {
                alert('LED 상태를 변경하는 중 오류가 발생했습니다.');
            }
        });
    });
});
</script>
<script>
    function startPump() {
        fetch('<c:url value="/startPump"/>')
            .then(response => response.text())
            .then(data => alert(data));
    }
</script>
</body>
</html>