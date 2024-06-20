<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="${ctx}/resources/css/plant.css">   
<script src="${ctx}/resources/script/html2canvas.js"></script>
            <div class="side">
                <ul class="gnb">
                    <li> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/home" class="menu1 nolnb">홈</a> <!--2뎁스 메뉴 없을 때 nolnb클래스 붙음-->
                    </li>
                    <li class="on">
                        <a href="javascript:void(0);" class="menu2">식물현황</a>
                        <ul class="lnb">
                            <li class="on"> <!--메뉴 선택 시 on클래스 붙음-->
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

                    <div class="sub_title">
                        <h3>식물현황</h3>
                    </div>
                    <div class="monitoring">
                       <div class="monitoring_left">
                            <h4>실시간 모니터링</h4>
                            <div class="cam" id="capture_area">
<!--                                 <img src="http://192.168.0.192:91/stream"> -->
                            </div>
                       </div>
                       <div class="monitoring_right">
                            <div class="status_wrap">
                                <div class="status_con">
                                    <div class="txt" id="temperatureStatus">
                                        <p>온도 <span class="status-indicator"></span></p>
						                <strong><span id="temperatureValue">${Math.round(latestMeasurement.temperature)}</span>˚C</strong>
						                <p class="gray">적정 온도 18 ~ 26˚C</p>
                                    </div>
                                    <div class="icon">
                                        <img src="${ctx}/resources/images/ic_status1.png" alt="온도 아이콘">
                                    </div>
                                </div>
                                <div class="status_con">
                                    <div class="txt" id="humidityStatus">
                                        <p>대기 습도 <span class="status-indicator"></span></p>
						                <strong><span id="humidityValue">${Math.round(latestMeasurement.humidity)}</span>%</strong>
						                <p class="gray">적정 습도 40 ~ 70%</p>
                                    </div>
                                    <div class="icon">
                                        <img src="${ctx}/resources/images/ic_status2.png" alt="온도 아이콘">
                                    </div>
                                </div>
                                <div class="status_con">
                                    <div class="txt" id="lightStatus">
                                        <p>조도 <span class="status-indicator"></span></p>
						                <strong><span id="lightValue">${latestMeasurement.illuminance}</span>lux</strong>
						                <p class="gray">적정 조도 300 lux 이상</p>
                                    </div>
                                    <div class="icon">
                                        <img src="${ctx}/resources/images/ic_status3.png" alt="온도 아이콘">
                                    </div>
                                </div>
                                <div class="status_con">
                                    <div class="txt" id="soilMoistureStatus">
                                        <p>토양 습도 <span class="status-indicator"></span></p>
						                <strong><span id="soilMoistureValue">${latestMeasurement.soilMoisture}</span>%</strong>
						                <p class="gray">적정 습도 20 ~ 30%</p>
                                    </div>
                                    <div class="icon">
                                        <img src="${ctx}/resources/images/ic_status4.png" alt="온도 아이콘">
                                    </div>
                                </div>
                            </div>
                            <div class="click_btn">
                                <button type="button" class="water">물주기<img src="${ctx}/resources/images/ic_water.png" alt="물주기 아이콘"></button>
                                <button type="button" class="led" id="toggleLed">조명 켜기<img src="${ctx}/resources/images/ic_led.png" alt="조명 켜기 아이콘"></button>
<%--                                 <button type="button" class="led">조명켜기<img src="${ctx}/resources/images/ic_led.png" alt="조명켜기 아이콘"></button> --%>
<%--                                 <button type="button" class="img" id="btn_download">촬영하기<img src="${ctx}/resources/images/ic_img.png" alt="촬영하기 아이콘"></button> --%>
                            </div>
                       </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<script>
document.getElementById('btn_download').addEventListener('click', function() {
    html2canvas(document.getElementById('capture_area'), {
        useCORS: true,
        allowTaint: false,
        logging: true
    }).then(function(canvas) {
        // 이미지 데이터를 얻어와서 다운로드
        let link = document.createElement('a');
        link.href = canvas.toDataURL('image/png');
        link.download = 'image.png';
        link.click();
    }).catch(function(error) {
        console.error('캡처 중 오류 발생:', error);
    });
});
// $(function(){
//     $(".btn_download").click(function(e){
//         html2canvas(document.getElementById("capture_area")).then(function(canvas) {
//             var el = document.createElement("a")
//             el.href = canvas.toDataURL("image/jpeg")
//             el.download = 'image.jpg' //다운로드 할 파일명 설정
//             el.click()
//         })
//     })
// })
</script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    // 온도
    const temperature = parseInt(document.getElementById('temperatureValue').textContent);
    const temperatureStatus = document.getElementById('temperatureStatus').querySelector('.status-indicator');
    if (temperature < 18) {
        temperatureStatus.classList.add('low');
        temperatureStatus.classList.remove('high', 'ok');
    } else if (temperature > 26) {
        temperatureStatus.classList.add('high');
        temperatureStatus.classList.remove('low', 'ok');
    } else {
        temperatureStatus.classList.add('ok');
        temperatureStatus.classList.remove('low', 'high');
    }

    // 대기 습도
    const humidity = parseInt(document.getElementById('humidityValue').textContent);
    const humidityStatus = document.getElementById('humidityStatus').querySelector('.status-indicator');
    if (humidity < 40) {
        humidityStatus.classList.add('low');
        humidityStatus.classList.remove('high', 'ok');
    } else if (humidity > 70) {
        humidityStatus.classList.add('high');
        humidityStatus.classList.remove('low', 'ok');
    } else {
        humidityStatus.classList.add('ok');
        humidityStatus.classList.remove('low', 'high');
    }

    // 조도
    const illuminance = parseInt(document.getElementById('lightValue').textContent);
    const lightStatus = document.getElementById('lightStatus').querySelector('.status-indicator');
    if (illuminance < 300) {
        lightStatus.classList.add('low');
        lightStatus.classList.remove('high', 'ok');
    } else {
        lightStatus.classList.add('ok');
        lightStatus.classList.remove('low', 'high');
    }

    // 토양 습도
    const soilMoisture = parseInt(document.getElementById('soilMoistureValue').textContent);
    const soilMoistureStatus = document.getElementById('soilMoistureStatus').querySelector('.status-indicator');
    if (soilMoisture < 20) {
        soilMoistureStatus.classList.add('low');
        soilMoistureStatus.classList.remove('high', 'ok');
    } else if (soilMoisture > 30) {
        soilMoistureStatus.classList.add('high');
        soilMoistureStatus.classList.remove('low', 'ok');
    } else {
        soilMoistureStatus.classList.add('ok');
        soilMoistureStatus.classList.remove('low', 'high');
    }
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
</body>
</html>