<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="${ctx}/resources/css/plant.css">   
<script src="${ctx}/resources/script/html2canvas.js"></script>
            <div class="side">
                <ul class="gnb">
                    <li> <!--메뉴 선택 시 on클래스 붙음-->
                        <a href="${ctx}/" class="menu1 nolnb">홈</a> <!--2뎁스 메뉴 없을 때 nolnb클래스 붙음-->
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
                                <!-- 카메라 들어갈 영역 -->
                            	<p>흠흠</p>
                            </div>
                       </div>
                       <div class="monitoring_right">
                            <div class="status_wrap">
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
                            <div class="click_btn">
                                <button type="button" class="water">물주기<img src="${ctx}/resources/images/ic_water.png" alt="물주기 아이콘"></button>
                                <button type="button" class="led">조명켜기<img src="${ctx}/resources/images/ic_led.png" alt="조명켜기 아이콘"></button>
                                <button type="button" class="img btn_download">촬영하기<img src="${ctx}/resources/images/ic_img.png" alt="촬영하기 아이콘"></button>
                            </div>
                       </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<script>
$(function(){
    $(".btn_download").click(function(e){
        html2canvas(document.getElementById("capture_area")).then(function(canvas) {
            var el = document.createElement("a")
            el.href = canvas.toDataURL("image/jpeg")
            el.download = 'image.jpg' //다운로드 할 파일명 설정
            el.click()
        })
    })
})
</script>
</body>
</html>