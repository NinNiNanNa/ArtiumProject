(function($,window,document,undefined){

    var mypage = {

        init: function(){
            var that = this;
                that.mypage1Fn();
                that.mypage6Fn();

        },
        mypage1Fn : function(){
            
            // 파일업로드 미리보기
            $("#imageFile").on("change", function(event) {

                var file = event.target.files[0];
            
                var reader = new FileReader(); 
                reader.onload = function(e) {
            
                    $("#preview").attr("src", e.target.result);
                }
            
                reader.readAsDataURL(file);
            });
            
            // 비밀번호 정규식(8~16자 영문, 숫자, 특수문자를 최소 한가지씩 조합)
            function isPassword(asValue) {
                var regExp = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
             
                return regExp.test(asValue);
            }
            // 닉네임 정규식(2~16자 영문, 숫자, 한글로 구성, 초성 및 모음X)
            function isName(asValue) {
                var regExp = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$/;
             
                return regExp.test(asValue);
            }
            // 이메일 아이디 정규식
            function isEmail(asValue) {
                var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
             
                return regExp.test(asValue);
            }
            
            // 비밀번호에 입력했을때(keydown) delBtn과 pwBtn 띄우기, addClass 지우기
            $('#pw1').keydown(function(){
                $('.inputBoxPw1 input').removeClass('addInputWrong');
                $('.inputBoxPw1 p').removeClass('addInputWrong');
                $('.inputBoxPw1 .delBtn').show();
                $('.inputBoxPw1 .pwBtn').show();
            });
            $('#pw2').keydown(function(){
                $('.inputBoxPw2 input').removeClass('addInputWrong');
                $('.inputBoxPw2 p').removeClass('addInputWrong');
                $('.inputBoxPw2 .delBtn').show();
                $('.inputBoxPw2 .pwBtn').show();
            });

            // 비밀번호 delBtn 누르면 입력한 내용과 delBtn, pwBtn 삭제
            $('.inputBoxPw1 .delBtn').on({
                click: function(){
                    $('#pw1').val('');
                    $(this).hide();
                    $('.inputBoxPw1 .pwBtn').hide();
                    $('#pw1').attr('type','password');
                    $('.inputBoxPw1 .pwBtn img').attr('src','./img/icon_pw_hide.svg');
                }
            });
            $('.inputBoxPw2 .delBtn').on({
                click: function(){
                    $('#pw2').val('');
                    $(this).hide();
                    $('.inputBoxPw2 .pwBtn').hide();
                    $('#pw2').attr('type','password');
                    $('.inputBoxPw2 .pwBtn img').attr('src','./img/icon_pw_hide.svg');
                }
            });

            // 비밀번호 pwBtn 누르면 입력한 내용 보이게하기
            $('.inputBoxPw1 .pwBtn').on({
                click: function(){
                    if( $('#pw1').attr('type') == 'password' ){
                        $('#pw1').attr('type','text');
                        $('.inputBoxPw1 .pwBtn img').attr('src','./img/icon_pw_show.svg');
                    }
                    else{
                        $('#pw1').attr('type','password');
                        $('.inputBoxPw1 .pwBtn img').attr('src','./img/icon_pw_hide.svg');
                    }
                }
            })
            $('.inputBoxPw2 .pwBtn').on({
                click: function(){
                    if( $('#pw2').attr('type') == 'password' ){
                        $('#pw2').attr('type','text');
                        $('.inputBoxPw2 .pwBtn img').attr('src','./img/icon_pw_show.svg');
                    }
                    else{
                        $('#pw2').attr('type','password');
                        $('.inputBoxPw2 .pwBtn img').attr('src','./img/icon_pw_hide.svg');
                    }
                }
            })

            // 닉네임에 입력했을때(keydown) delBtn 띄우기, addClass 지우기
            $('#name').keydown(function(){
                $('.inputBoxName input').removeClass('addInputWrong');
                $('.inputBoxName p').removeClass('addInputWrong');
                $('.inputBoxName .delBtn').show();
            });
            // 닉네임 delBtn 누르면 입력한 내용과 delBtn 삭제
            $('.inputBoxName .delBtn').on({
                click: function(){
                    $('#name').val('');
                    $(this).hide();
                }
            });

            // 이메일에 입력했을때(keydown) delBtn 띄우기, addClass 지우기
            $('#email').keydown(function(){
                $('.inputBoxEmail input').removeClass('addInputWrong');
                $('.inputBoxEmail p').removeClass('addInputWrong');
                $('.inputBoxEmail .delBtn').show();
            });
            // 이메일 delBtn 누르면 입력한 내용과 delBtn 삭제
            $('.inputBoxEmail .delBtn').on({
                click: function(){
                    $('#email').val('');
                    $(this).hide();
                }
            });

            $('.joinConBtn').on({
                click: function(e){
                    if( $('#pw1').val()=='' ){
                        $('.inputBoxPw1 input').addClass('addInputWrong');
                        $('.inputBoxPw1 p').addClass('addInputWrong').text('비밀번호를 입력해 주세요.');
                        $('#pw1').focus();
                    }
                    else if( !isPassword($('#pw1').val()) ){
                        $('.inputBoxPw1 input').addClass('addInputWrong');
                        $('.inputBoxPw1 p').addClass('addInputWrong').text('비밀번호는 영문,숫자,특수문자 조합하여 8~16자리입니다.');
                        $('#pw1').focus();
                    }

                    if( $('#pw2').val()=='' ){
                        $('.inputBoxPw2 input').addClass('addInputWrong');
                        $('.inputBoxPw2 p').addClass('addInputWrong').text('비밀번호를 입력해 주세요.');
                        $('#pw2').focus();
                    }
                    else if( !($('#pw1').val() == $('#pw2').val()) ){
                        $('.inputBoxPw2 input').addClass('addInputWrong');
                        $('.inputBoxPw2 p').addClass('addInputWrong').text('비밀번호가 일치하지 않습니다.');
                        $('#pw2').focus();
                    }

                    if( $('#name').val()=='' ){
                        $('.inputBoxName input').addClass('addInputWrong');
                        $('.inputBoxName p').addClass('addInputWrong').text('닉네임을 입력해 주세요.');
                        $('#name').focus();
                    }
                    else if( !isName($('#name').val()) ){
                        $('.inputBoxName input').addClass('addInputWrong');
                        $('.inputBoxName p').addClass('addInputWrong').text('닉네임은 영문 또는 숫자 또는 한글로 구성된 2~16자리입니다.');
                        $('#name').focus();
                    }

                    if( $('#email').val()=='' ){
                        $('.inputBoxEmail input').addClass('addInputWrong');
                        $('.inputBoxEmail p').addClass('addInputWrong').text('이메일을 입력해 주세요.');
                        $('#email').focus();
                    }
                    else if( !isEmail($('#email').val()) ){
                        $('.inputBoxEmail input').addClass('addInputWrong');
                        $('.inputBoxEmail p').addClass('addInputWrong').text('잘못된 이메일 형식입니다.');
                        $('#email').focus();
                    }
                }
            });

        },
        mypage6Fn: function(){

            $('#calendar').fullCalendar({
                header: {
                  right: 'custom2 prevYear,prev,next,nextYear'
                },
                // 출석체크를 위한 버튼 생성
                customButtons: { 
                    custom2: {
                      text: '출석체크하기',
                      id: 'check',
                      click: function() {	
                            // ajax 통신으로 출석 정보 저장하기 
                            // POST "/users/attendances" -> { status: "success", date:"2018-07-01"}
                            // 통신 성공시 버튼 바꾸고, property disabled 만들기 
                      }
                    }
                },
               // 달력 정보 가져오기 
                eventSources: [
                    {
                        // ajax 통신으로 달력 정보 가져오기 
                        // GET "/users/attendances" -> {dateList:[ date: "2016-03-21", ... ]}
                        color: 'purple',   
                         textColor: 'white' 
                    }
                ]
              }); 

        }

    }
    mypage.init();

})(jQuery,window,document);