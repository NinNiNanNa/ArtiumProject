(function($,window,document,undefined){

    var login = {

        init: function(){
            var that = this;
                that.sectionFn();

        },
        sectionFn : function(){
            // 아이디 정규식
            function isId(asValue) {
                var regExp = /^[a-z]+[a-z0-9]{5,19}$/g;
             
                return regExp.test(asValue);
            }
            // 비밀번호 정규식(8~16자 영문, 숫자, 특수문자를 최소 한가지씩 조합)
            function isPassword(asValue) {
                var regExp = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
             
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
            $('#pw').keydown(function(){
                $('.inputBoxPw input').removeClass('addInputWrong');
                $('.inputBoxPw p').removeClass('addInputWrong');
                $('.inputBoxPw .delBtn').show();
                $('.pwBtn').show();
            });

            // 비밀번호 delBtn 누르면 입력한 내용과 delBtn, pwBtn 삭제
            $('.inputBoxPw .delBtn').on({
                click: function(){
                    $('#pw').val('');
                    $(this).hide();
                    $('.pwBtn').hide();
                    $('#pw').attr('type','password');
                    $('.pwBtn img').attr('src','./img/icon_pw_hide.svg');
                }
            });

            // 비밀번호 pwBtn 누르면 입력한 내용 보이게하기
            $('.pwBtn').on({
                click: function(){
                    if( $('#pw').attr('type') == 'password' ){
                        $('#pw').attr('type','text');
                        $('.pwBtn img').attr('src','./img/icon_pw_show.svg');
                    }
                    else{
                        $('#pw').attr('type','password');
                        $('.pwBtn img').attr('src','./img/icon_pw_hide.svg');
                    }
                }
            })

            // 아이디, 비밀번호 입력안하고 로그인 버튼 누르면 빨간색 경고글 띄우기 (.addInputWrong)
            $('.loginBtn').on({
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
                        $('.inputBoxId p').addClass('addInputWrong').text('아이디를 다시 확인해 주세요.');
                        $('#id').focus();
                    }

                    // 비밀번호 입력없이 로그인 버튼 누르면 빨간색 경고글과 테두리 빨간색으로 변경
                    if( $('#pw').val()=='' ){
                        $('.inputBoxPw input').addClass('addInputWrong');
                        $('.inputBoxPw p').addClass('addInputWrong').text('비밀번호를 입력해 주세요.');
                        $('#pw').focus();
                    }
                    // 비밀번호 형식이 아니면 빨간색 경고글('비밀번호가 일치하지 않습니다.'로 텍스트변경)과 테두리 빨간색으로 변경
                    else if( !isPassword($('#pw').val()) ){
                        $('.inputBoxPw input').addClass('addInputWrong');
                        $('.inputBoxPw p').addClass('addInputWrong').text('비밀번호가 일치하지 않습니다.');
                        $('#pw').focus();
                    }
                }
            });

            $('#idCheck').on({
                click: function(){
                    $(this).toggleClass('addIDCheck');
                }
            });

        }

    }
    login.init();

})(jQuery,window,document);