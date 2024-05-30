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
                                    <canvas id="myChart"></canvas>
                                </div>
                            </div>
                            <div class="status_chart">
                                <h4>대기 습도</h4>
                                <div class="chart">
                                    <!-- 차트 들어갈 영역 -->
                                </div>
                            </div>
                            <div class="status_chart">
                                <h4>조도</h4>
                                <div class="chart">
                                    <!-- 차트 들어갈 영역 -->
                                </div>
                            </div>
                            <div class="status_chart">
                                <h4>토양 습도</h4>
                                <div class="chart">
                                    <!-- 차트 들어갈 영역 -->
                                </div>
                            </div>
                       </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<script>
const ctx = document.getElementById('myChart').getContext('2d');
const myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
        datasets: [{
            label: '# of Votes',
            data: [12, 19, 3, 5, 2, 3],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});
</script>
</body>
</html>