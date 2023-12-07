(function($,window,document,undefined){

    var join = {

        init: function(){
            var that = this;
                that.sectionFn();

        },
        sectionFn : function(){
            // 아이디 정규식(4~12자 영문, 숫자 조합, 첫자리는 숫자X)
            function isId(asValue) {
                var regExp = /^[A-Za-z]{1}[A-Za-z0-9]{3,11}$/;
             
                return regExp.test(asValue);
            }
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

            // 아이디에 입력했을때(keydown) delBtn 띄우기, addClass 지우기
            $('#id').keydown(function(){
                $('.inputBoxId input').removeClass('addInputWrong');
                $('.inputBoxId p').removeClass('addInputWrong');
                $('.inputBoxId .delBtn').show();
            });
            // 아이디 delBtn 누르면 입력한 내용과 delBtn 삭제
            $('.inputBoxId .delBtn').on({
                click: function(){
                    $('#id').val('');
                    $(this).hide();
                }
            });

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
            $('#email2').keydown(function(){
                $('.inputBoxEmail2 input').removeClass('addInputWrong');
                $('.inputBoxEmail2 p').removeClass('addInputWrong');
                $('.inputBoxEmail2 .delBtn').show();
            });
            // 이메일 delBtn 누르면 입력한 내용과 delBtn 삭제
            $('.inputBoxEmail .delBtn').on({
                click: function(){
                    $('#email').val('');
                    $(this).hide();
                }
            });
            $('.inputBoxEmail2 .delBtn').on({
                click: function(){
                    $('#email2').val('');
                    $(this).hide();
                }
            });

            
            $('.joinConBtn').on({
                click: function(e){
                    // 아이디 입력없이 로그인 버튼 누르면 빨간색 경고글과 테두리 빨간색으로 변경
                    if( $('#id').val()=='' ){
                        $('.inputBoxId input').addClass('addInputWrong');
                        $('.inputBoxId p').addClass('addInputWrong').text('아이디를 입력해 주세요.');
                        $('#id').focus();
                    }
                    // 아이디 형식이 아니면 빨간색 경고글('아이디를 다시 확인해 주세요.'로 텍스트변경)과 테두리 빨간색으로 변경
                    else if( !isId($('#id').val()) ){
                        $('.inputBoxId input').addClass('addInputWrong');
                        $('.inputBoxId p').addClass('addInputWrong').text('아이디는 영문,숫자 조합하여 4~12자리 입니다.');
                        $('#id').focus();
                    }

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
                    
                    if( $('#email2').val()=='' ){
                        $('.inputBoxEmail2 input').addClass('addInputWrong');
                        $('.inputBoxEmail2 p').addClass('addInputWrong').text('인증번호를 입력해 주세요.');
                        $('#email2').focus();
                    }
                    else if( !isEmail($('#email2').val()) ){
                        $('.inputBoxEmail2 input').addClass('addInputWrong');
                        $('.inputBoxEmail2 p').addClass('addInputWrong').text('잘못된 인증번호 입니다.');
                        $('#email2').focus();
                    }
                }
            });
        }
    }
    join.init();

})(jQuery,window,document);