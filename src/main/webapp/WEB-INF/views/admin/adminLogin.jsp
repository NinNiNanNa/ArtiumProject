<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Artium 로그인</title>

    <!-- Custom fonts for this template-->
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="../css/sb-admin-2.min.css" rel="stylesheet">
    
    <!-- jQuery 라이브러리 로드 -->
   <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    
<script type="text/javascript">
$(document).ready(function () {
    // 페이지 로드 시 실행되는 함수
    // 저장된 아이디가 있는지 확인
    var savedId = getCookie("savedId");
    if (savedId !== "") {
        // 아이디 입력란에 저장된 아이디 설정
        $("#id").val(savedId);
        // 아이디 저장 체크박스 체크
        $("#idCheck").prop("checked", true);
    }
   
    // 로그인 버튼 클릭 시 이벤트 처리
    $("#loginBtn").click(function () {
        loginCheck();
    });
});
//쿠키를 가져오는 함수
function getCookie(cookieName) {
    var name = cookieName + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var cookieArray = decodedCookie.split(';');
    for (var i = 0; i < cookieArray.length; i++) {
        var cookie = cookieArray[i].trim();
        if (cookie.indexOf(name) === 0) {
            return cookie.substring(name.length, cookie.length);
        }
    }
    return "";
}
//로그인 체크 함수
function loginCheck(){
    $.ajax({
        url:"/admin/adminLogin",
        type:"post",
        data:{"id" : $("#id").val(),
        	"pw" : $("#pw").val()},
        success: function(result){  
        	if(result == 0){
        		alert("로그인에 실패하였습니다.");
        	} else{
        		alert("로그인되었습니다.");
        		
        		// 아이디 저장 체크박스 확인
                if ($('#idCheck').is(':checked')) {
                    // 쿠키에 아이디 저장
                    document.cookie = "savedId=" + $("#id").val() + "; expires=Thu, 01 Jan 2026 00:00:00 UTC; path=/admin";
                } else {
                    // 체크박스가 해제되면 쿠키 삭제
                    document.cookie = "savedId=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/admin";
                }
        		
        		window.location.href ="/adminMain";
        	}
        },
        error:function(request,status,error){        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       }
        
    });
}
</script>

</head>

<body class="bg-gradient-dark">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center align-items-center vh-100">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                            <div class="col-lg-6">
                                <div class="" style="padding: 5rem 3rem;">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-5">Artium Admin</h1>
                                    </div>
                                    <form class="admin" id="loginForm">
                                        <div class="form-group">
                                            <input type="text" name="id" class="form-control form-control-user"
                                                id="id" aria-describedby="emailHelp"
                                                placeholder="이메일을 입력해주세요.">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" name="pw" class="form-control form-control-user"
                                                id="pw" placeholder="비밀번호를 입력해주세요.">
                                        </div>
                                        <div class="form-group mb-4">
                                            <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" class="custom-control-input" id="idCheck" name="idCheck">
                                                <label class="custom-control-label" for="idCheck">아이디 저장</label>
                                            </div>
                                        </div>
                                        <a class="btn btn-dark btn-user btn-block" onclick="loginCheck()">
                                            로그인
                                        </a>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="../vendor/jquery/jquery.min.js"></script>
    <script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="../vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="../js/sb-admin-2.min.js"></script>

</body>

</html>