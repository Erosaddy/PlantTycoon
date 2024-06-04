<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="${ctx}/resources/css/list.css">
            <div class="side">
                <ul class="gnb">
                    <li> <!--메뉴 선택 시 on클래스 붙음-->
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
                    <li class="on"> <!--메뉴 선택 시 on클래스 붙음-->
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
                        <h3>공지사항</h3>
                    </div>
                    <div class="list_top">
                        <div class="total">총 <span>81</span>건</div>
                        <div class="btn_wrap">
                            <button type="button" class="btn_write">
                                <img src="${ctx}/resources/images/ic_write.png" alt="작성하기 버튼 아이콘">
                                작성하기
                            </button>
                        </div>
                        <div class="search">
                            <div class="search_box">
                                <select>
                                    <option value="0">전체</option>
                                    <option value="1">제목</option>
                                    <option value="2">내용</option>
                                </select>
                            </div>
                            <div class="search_box">
                                <input type="search" placeholder="검색어를 입력하세요">
                                <button type="button" class="btn_search">검색</button>
                            </div>
                        </div>
                    </div>
                    <div class="list news">
                        <ul class="list_head">
                           <li>번호</li> 
                           <li>제목</li> 
                           <li>작성자</li> 
                           <li>작성일</li> 
                        </ul>
                        <ul class="list_body">
                            <li>
                                <div class="num">81</div>
                                <div class="tit"><a href="javascript:void(0);" class="txt_cut1">산세베리아 키우기 80일차! 무럭무럭 잘 자라는중!</a></div>
                                <div class="name" class="txt_cut1">관리자</div>
                                <div class="date">2024.05.23</div>
                            </li>
                            <li>
                                <div class="num">81</div>
                                <div class="tit"><a href="javascript:void(0);" class="txt_cut1">산세베리아 키우기 80일차! 무럭무럭 잘 자라는중!</a></div>
                                <div class="name">관리자</div>
                                <div class="date">2024.05.23</div>
                            </li>
                            <li>
                                <div class="num">81</div>
                                <div class="tit"><a href="javascript:void(0);" class="txt_cut1">산세베리아 키우기 80일차! 무럭무럭 잘 자라는중!</a></div>
                                <div class="name">관리자</div>
                                <div class="date">2024.05.23</div>
                            </li>
                            <li>
                                <div class="num">81</div>
                                <div class="tit"><a href="javascript:void(0);" class="txt_cut1">산세베리아 키우기 80일차! 무럭무럭 잘 자라는중!</a></div>
                                <div class="name">관리자</div>
                                <div class="date">2024.05.23</div>
                            </li>
                            <li>
                                <div class="num">81</div>
                                <div class="tit"><a href="javascript:void(0);" class="txt_cut1">산세베리아 키우기 80일차! 무럭무럭 잘 자라는중!</a></div>
                                <div class="name">관리자</div>
                                <div class="date">2024.05.23</div>
                            </li>
                            <li>
                                <div class="num">81</div>
                                <div class="tit"><a href="javascript:void(0);" class="txt_cut1">산세베리아 키우기 80일차! 무럭무럭 잘 자라는중!</a></div>
                                <div class="name">관리자</div>
                                <div class="date">2024.05.23</div>
                            </li>
                            <li>
                                <div class="num">81</div>
                                <div class="tit"><a href="javascript:void(0);" class="txt_cut1">산세베리아 키우기 80일차! 무럭무럭 잘 자라는중!</a></div>
                                <div class="name">관리자</div>
                                <div class="date">2024.05.23</div>
                            </li>
                            <li>
                                <div class="num">81</div>
                                <div class="tit"><a href="javascript:void(0);" class="txt_cut1">산세베리아 키우기 80일차! 무럭무럭 잘 자라는중!</a></div>
                                <div class="name">관리자</div>
                                <div class="date">2024.05.23</div>
                            </li>
                            <li>
                                <div class="num">81</div>
                                <div class="tit"><a href="javascript:void(0);" class="txt_cut1">산세베리아 키우기 80일차! 무럭무럭 잘 자라는중!</a></div>
                                <div class="name">관리자</div>
                                <div class="date">2024.05.23</div>
                            </li>
                            <li>
                                <div class="num">81</div>
                                <div class="tit"><a href="javascript:void(0);" class="txt_cut1">산세베리아 키우기 80일차! 무럭무럭 잘 자라는중!</a></div>
                                <div class="name">관리자</div>
                                <div class="date">2024.05.23</div>
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
</body>
</html>