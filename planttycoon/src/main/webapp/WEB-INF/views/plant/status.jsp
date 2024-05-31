<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="${ctx}/resources/css/plant.css">   
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
            <div class="side">
                <ul class="gnb">
                    <li> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/" class="menu1 nolnb">홈</a> <!--2뎁스 메뉴 없을 때 nolnb클래스 붙음-->
                    </li>
                    <li class="on">
                        <a href="javascript:void(0);" class="menu2">식물현황</a>
                        <ul class="lnb">
                            <li> <!--메뉴 선택 시 on클래스 붙음-->
                                <a href="${ctx}/plant/monitoring">실시간 모니터링</a>
                            </li>
                            <li class="on"> <!--메뉴 선택 시 on클래스 붙음-->
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
                    <li> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/management" class="menu5 nolnb">회원관리</a>
                    </li>
                </ul>
            </div>
            <div class="container">
                <div class="container_inner">

                    <div class="sub_title">
                        <h3>식물현황</h3>
                    </div>
                    <div class="status">
                       <div class="status_top">
                            <div class="status_con">
                                <div class="txt">
                                    <p>온도 <span class="high"></span></p>
                                    <strong><span>26</span>˚C</strong>
                                    <p class="gray">적정 온도 18 ~ 26˚C</p>
                                </div>
                                <div class="icon">
                                    <img src="${ctx}/resources/images/ic_status1.png" alt="온도 아이콘">
                                </div>
                            </div>
                            <div class="status_con">
                                <div class="txt">
                                    <p>대기 습도 <span class="ok"></span></p>
                                    <strong><span>42</span>%</strong>
                                    <p class="gray">적정 습도 40 ~ 70%</p>
                                </div>
                                <div class="icon">
                                    <img src="${ctx}/resources/images/ic_status2.png" alt="온도 아이콘">
                                </div>
                            </div>
                            <div class="status_con">
                                <div class="txt">
                                    <p>조도 <span class="ok"></span></p>
                                    <strong><span>320</span>lux</strong>
                                    <p class="gray">적정 조도 300 lux 이상</p>
                                </div>
                                <div class="icon">
                                    <img src="${ctx}/resources/images/ic_status3.png" alt="온도 아이콘">
                                </div>
                            </div>
                            <div class="status_con">
                                <div class="txt">
                                    <p>토양 습도 <span class="low"></span></p>
                                    <strong><span>64</span>%</strong>
                                    <p class="gray">적정 습도 20 ~ 30%</p>
                                </div>
                                <div class="icon">
                                    <img src="${ctx}/resources/images/ic_status4.png" alt="온도 아이콘">
                                </div>
                            </div>
                       </div>
                       <div class="status_bottom">
                            <div class="status_chart">
                                <h4>온도</h4>
                                <div class="chart">
                                    <canvas id="temperatureChart"></canvas>
                                </div>
                            </div>
                            <div class="status_chart">
                                <h4>대기 습도</h4>
                                <div class="chart">
                                    <canvas id="humidityChart"></canvas>
                                </div>
                            </div>
                            <div class="status_chart">
                                <h4>조도</h4>
                                <div class="chart">
                                    <canvas id="lightChart"></canvas>
                                </div>
                            </div>
                            <div class="status_chart">
                                <h4>토양 습도</h4>
                                <div class="chart">
                                    <canvas id="soilMoistureChart"></canvas>
                                </div>
                            </div>
                       </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<script>
$(document).ready(function() {
    $.ajax({
        url: '${ctx}/api/measurements',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            // 등록된 시간 정보를 추출하고 Date 객체로 변환
            const timeLabels = data.map(item => new Date(item.measurementRegdate));

            // 온도, 대기 습도, 조도, 토양 습도 데이터 추출
            const temperatureData = data.map(item => Math.round(item.temperature));
			const humidityData = data.map(item => Math.round(item.humidity));
            const lightData = data.map(item => item.illuminance);
            const soilMoistureData = data.map(item => item.soilMoisture);

            // 차트 생성
            const temperatureCtx = document.getElementById('temperatureChart').getContext('2d');
            createChart(temperatureCtx, '온도', timeLabels, temperatureData, 'rgba(254, 97, 130, 0.5)', 'rgba(254, 97, 130, 1)');

            const humidityCtx = document.getElementById('humidityChart').getContext('2d');
            createChart(humidityCtx, '대기 습도', timeLabels, humidityData, 'rgba(48, 160, 234, 0.5)', 'rgba(48, 160, 234, 1)');

            const lightCtx = document.getElementById('lightChart').getContext('2d');
            createChart(lightCtx, '조도', timeLabels, lightData, 'rgba(254, 202, 80, 0.5)', 'rgba(254, 202, 80, 1)');

            const soilMoistureCtx = document.getElementById('soilMoistureChart').getContext('2d');
            createChart(soilMoistureCtx, '토양 습도', timeLabels, soilMoistureData, 'rgba(75, 192, 192, 0.5)', 'rgba(75, 192, 192, 1)');
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error('AJAX error:', textStatus, errorThrown);
        }
    });
});

// createChart 함수 정의
function createChart(ctx, label, timeLabels, data, backgroundColor, borderColor) {
    return new Chart(ctx, {
        type: 'line',
        data: {
            labels: timeLabels.map(time => {
            	const options = { month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', hour12: false };
                const formattedDate = new Intl.DateTimeFormat('ko-KR', options).format(time);
                const [month, day, datetime] = formattedDate.split('. '); // '05. 30. 09:00'을 분리하여 월, 일, 시간으로 나눔
                return month+"/"+day+" "+datetime; // 월/일 시간 형식으로 조합하여 반환
            }),
            datasets: [{
                label: label,
                data: data,
                backgroundColor: backgroundColor,
                borderColor: borderColor,
                borderWidth: 2
            }]
        },
        options: {
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}
</script>
</body>
</html>