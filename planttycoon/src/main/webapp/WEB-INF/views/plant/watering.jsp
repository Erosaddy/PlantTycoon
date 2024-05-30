<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="${ctx}/resources/css/watering.css">   
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
                    <div class="watering">
                        <div class="watering_left">
                            <div class="auto_watering">
                                <h4>자동 급수 관리</h4>  
                                <form>
                                    <div class="wataring_input">
                                        <input type="text" placeholder="7">
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
</body>
</html>