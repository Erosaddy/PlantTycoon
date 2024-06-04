<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>
<link rel="stylesheet" href="${ctx}/resources/css/plant.css">   
<link rel="stylesheet" href="${ctx}/resources/css/home.css">   
            <div class="side">
                <ul class="gnb">
                    <li class="on"> <!--메뉴 선택 시 on클래스 붙음-->
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
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
	                    <li> <!--메뉴 선택 시 on클래스 붙음-->
	                        <a href="${ctx}/management" class="menu5 nolnb">회원관리</a>
	                    </li>
                    </sec:authorize>
                </ul>
            </div>
            <div class="container">
                <div class="container_inner">

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
                       <div class="home">
                            <div class="home_left">
                                <div class="plant_emotion smile"> <!-- 모두 만족일때 smile, 온도 높을때 high_t, 온도 낮을때 low_t, 토양습도 높을때 high_m, 토양습도 낮을때 low_m 클래스 붙음-->
                                    <div class="plant_bg">
                                    </div>
                                    <div class="plant_txt">
                                        <img src="${ctx}/resources/images/plant_text_bg.png" alt="식물 말풍선">
                                        <p>물이 없으니 힘이 나질 않아요</p>
                                    </div>
                                </div>
                                <div class="plant_btn">
                                    <button type="button" class="water">물주기<img src="${ctx}/resources/images/ic_water.png" alt="물주기 아이콘"></button>
                                <button type="button" class="led">조명켜기<img src="${ctx}/resources/images/ic_led.png" alt="조명켜기 아이콘"></button>
                                </div>
                            </div>
                            <div class="home_right">
                                <div class="wataring_dday">
                                    <p>다음 급수일까지<span><strong>6</strong>일 <strong>21</strong>시간</span>남았습니다.</p>
                                </div>
                                <div class="watering_log">
                                    <h4>급수기록</h4>
                                    <div class="log_list">
                                        <ul class="log_head">
                                            <li>급수날짜</li>
                                            <li>급수타입</li>
                                        </ul>
                                        <ul class="log_body">
                                            <li>
                                                <div>2024.05.28 15:33:02</div>
                                                <div>자동</div>
                                            </li>
                                            <li>
                                                <div>2024.05.28 15:33:02</div>
                                                <div>자동</div>
                                            </li>
                                            <li>
                                                <div>2024.05.28 15:33:02</div>
                                                <div>자동</div>
                                            </li>
                                            <li>
                                                <div>2024.05.28 15:33:02</div>
                                                <div>자동</div>
                                            </li>
                                            <li>
                                                <div>2024.05.28 15:33:02</div>
                                                <div>자동</div>
                                            </li>
                                            <li>
                                                <div>2024.05.28 15:33:02</div>
                                                <div>자동</div>
                                            </li>
                                            <li>
                                                <div>2024.05.28 15:33:02</div>
                                                <div>자동</div>
                                            </li>
                                            <li>
                                                <div>2024.05.28 15:33:02</div>
                                                <div>자동</div>
                                            </li>
                                            <li>
                                                <div>2024.05.28 15:33:02</div>
                                                <div>자동</div>
                                            </li>
                                            <li>
                                                <div>2024.05.28 15:33:02</div>
                                                <div>자동</div>
                                            </li>
                                        </ul>
                                        <div class="paging">
                                            <p>
                                                <!-- <span class="numPN m_ar"><a href="#" data-page="1" title="처음 페이지로 이동하기"><img src="image/ic_prev2.png" alt="처음 페이지"></a></span> -->
                                                <span class="numPN over left"><a href="#" data-page="1" title="이전 페이지로 이동하기"><img src="${ctx}/resources/images/ic_prev.png" alt="이전 페이지"></a></span>
                                                <span class="Present"><a class="on" href="#" data-page="1">1</a></span>
                                                <span><a href="#" data-page="2">2</a></span>
                                                <span><a href="#" data-page="3">3</a></span>
                                                <span><a href="#" data-page="4">4</a></span>
                                                <span><a href="#" data-page="5">5</a></span>
                                                <span class="numPN  over right"><a href="#" data-page="11" title="다음 페이지로 이동하기"><img src="${ctx}/resources/images/ic_next.png" alt="다음 페이지"></a></span>
                                                <!-- <span class="numPN m_ar"><a href="#" data-page="14" title="마지막 페이지로 이동하기"><img src="image/ic_next2.png" alt="마지막 페이지"></a></span> -->
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
</body>
</html>