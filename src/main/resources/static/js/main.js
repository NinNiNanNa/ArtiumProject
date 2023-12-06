(function($,window,document,undefined){

    var main = {

        init: function(){
            var that = this;
                that.section1Fn();
                that.section2Fn();
                that.section3Fn();

        },
        section1Fn : function(){
            var winH = 0;

            function resizeFn(){
                winH = $(window).innerHeight();
			
			    $('#section1, #section1 .wrap1440 .gap1440 .container1440').css({ height: winH });
                
            }   
            setTimeout(resizeFn,100);

            $(window).resize(function(){
               clearTimeout(setId);
               setId = setTimeout(resizeFn,100);
            });

        },
        section2Fn : function(){

            $(window).scroll(function(event){
				event.preventDefault();
				if( $(window).scrollTop() >= $('#section1').offset().top+450 ){
					$('#section2 .content ul li:nth-child(1)').stop().animate({ top:0, opacity:1 },600);
					$('#section2 .content ul li:nth-child(2)').stop().animate({ top:0, opacity:1 },900);
					$('#section2 .content ul li:nth-child(3)').stop().animate({ top:0, opacity:1 },1200);
				}
				else{
					$('#section2 .content ul li').stop().animate({ top:600, opacity:0 },600);
					
				}
			});

        },
        section3Fn : function(){
            
        }

    }
    main.init();

})(jQuery,window,document);