(function($,window,document,undefined){

    var fixed = {

        init: function(){
            var that = this;
                that.headerFn();

        },
        headerFn : function(){
            var url = 0;

            //스무스 스크롤 이벤트
            $('.smoothBtn').on({
                click:	function(event){
                    event.preventDefault();	
                    
                    url = $(this).attr('href');
                    $('html,body').stop().animate({ scrollTop: $( url ).offset().top },800);		
                }
            });

            //상단에서 스크롤 탑값이 10px이상이면 헤더 높이 그리고 배경 모두 변경 10px미만이면 해제
            $(window).scroll(function(){
                if( $(this).scrollTop() >=10 ){
                    $('#header').addClass('addFixed');
                }
                else{
                    $('#header').removeClass('addFixed');
                }
            });

            //3선메뉴버튼 클릭 이벤트 Toggle
            $('.appbarBtn').on({
                click:	function(e){
                    // 이벤트 전달 제거
                    e.stopPropagation();
                    $(this).toggleClass('addEffect');
                    $('.menu_wrap').toggleClass('addEffect');

                }
            });
            //메뉴 제외한 영역 클릭시 메뉴 닫기, 3선메뉴 초기화
            $('#wrap').click(function(e){
                if( !$('.menu_wrap').has(e.target).length ){
                    $('.appbarBtn').removeClass('addEffect');
                    $('.menu_wrap').removeClass('addEffect');
                }
            });

        }

    }
    fixed.init();

})(jQuery,window,document);