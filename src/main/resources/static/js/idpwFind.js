(function($,window,document,undefined){

    var idpwFind = {

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

            $('.conBtn').on({
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

        }

    }
    idpwFind.init();

})(jQuery,window,document);