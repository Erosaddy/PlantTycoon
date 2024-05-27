$(function() {
    // 사이드 메뉴
    $(".gnb > li > a").click(function() {
        $(this).next(".lnb").stop().slideToggle(300);
        $(this).parent().toggleClass('on').siblings().removeClass('on');
        $(this).parent().siblings().children(".lnb").slideUp(300); // 1개씩 펼치기
        });

        
    //모바일 메뉴
	var header = $('header');
	var hbg = $('.header_btn');
    var sideMenu = $('.side_menu');
	var depth1 = $('.side_menu .menu_depth1');

    hbg.on('click', function () {
        if (hbg.hasClass("active")) {
        hbg.addClass('not-active').removeClass("active");
        header.removeClass('open');
        sideMenu.addClass('active').show().stop()
            .animate({
            opacity: 0
            }, 250, function () {
            $(this).hide();
            })
        depth1.removeClass('active');
        $('.menu__depth2').stop().slideUp(250);
        } else {
        header.addClass('open');
        hbg.addClass('active').removeClass("not-active");
        sideMenu.show().stop()
            .animate({
            opacity: 1
            }, 250)
        }
    });
    
    depth1.on('click', function () {
      depth1.not($(this)).removeClass('active');

      $('.menu_depth2').not($(this).siblings())
        .stop().slideUp(250);

      $(this).toggleClass('active')
        .siblings('.menu_depth2').stop()
        .slideToggle(250)
    });


    //비밀번호 찾기 팝업
    $('.forgot_password_btn').click(function(){
        $('.pw_popup').css('display','block');
      });
      $('.pw_popup .popup_close').click(function(){
        $('.pw_popup').css('display','none');
      });
});