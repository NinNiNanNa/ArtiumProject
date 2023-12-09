<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html lang='ko' class=''>
<head>
	<title>ARTIUM</title>
	<meta charset='utf-8'>
	<meta name='Viewport'    content='width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0'>
	<meta name='Title'       content='ARTIUM'>
	<meta name='Subject'     content='전시회 플랫폼'>
	<meta name='format-detection' content='telephone=no'>	
	<meta name='Description' content='전시회 정보, 리뷰, 메이트, 일반 작가 갤러리 등을 경험할 수 있는 사이트'>
	<meta name='Author'      content='청일홍사'>
	<meta name='Author-Date' content='2023-11-24'>
	<meta name='Robots'      content='index,follow'>

	<!-- 파비콘 -->	
	<link rel='shortcut icon' href='./img/brando-114x114-1.png'>
	<link rel='apple-touch-icon' href='./img/brando-114x114-1.png'>
	
	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>	
	
	<!-- 커스텀 CSS 스타일 -->
	<link rel='stylesheet' type='text/css' href='./css/reset.css'>
	<link rel='stylesheet' type='text/css' href='./css/fonts.css'>
	<link rel='stylesheet' type='text/css' href='./css/fixed.css'>
	<link rel='stylesheet' type='text/css' href='./css/login.css'>
	
	<!-- 제이쿼리 로컬 -->
	<script src='./js/lib/jquery-1.12.4.min.js'></script>
	<script src='./js/lib/jquery.easing.1.3.js'></script>
	<script src='./js/lib/jquery.touchSwipe.js'></script>

	<!-- 브라우저별 접두사 쓸 필요 없음 -->
	<script src='./js/lib/prefixfree.min.js'></script>

	<!-- 아이콘 -->
    <link href="./vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    
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
// 로그인 체크 함수
function loginCheck(){
    $.ajax({
        url:"/login/loginCheck",
        type:"post",
        data:{"id" : $("#id").val(),
        	"pw" : $("#pw").val()},
        success: function(result){
        	if(result == 0){
        	} else{
        		alert("로그인되었습니다.");
        		
        		// 아이디 저장 체크박스 확인
                if ($('#idCheck').is(':checked')) {
                    // 쿠키에 아이디 저장
                    document.cookie = "savedId=" + $("#id").val() + "; expires=Thu, 01 Jan 2026 00:00:00 UTC; path=/";
                } else {
                    // 체크박스가 해제되면 쿠키 삭제
                    document.cookie = "savedId=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/";
                }
        		
        		window.location.href = "../";
        	}
        },
        error:function(request,status,error){        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       }
        
    });
}
</script>

</head>
<body>
<div id='wrap'>
	
	<ul id='skip'>
		<li><a href='#header'>메뉴바로가기</a></li>
		<li><a href='#main'>메인바로가기</a></li>
		<li><a href='#footer'>하단바로가기</a></li>
	</ul>
	
	<%@ include file="/header.jsp"%>
	
	<main id='main'>

		<section id="section">
			<div class="wrap1440">
				<div class="gap1440">
					<div class="container1440">

						<div class="wrap470">
							<div class="title_wrap">
								<h1>로그인</h1>
							</div>
							<div class="content_wrap">
								<form action="" id="loginForm">
								<ul>
									<li>
										<h2>아이디</h2>
										<div class="inputBox inputBoxId">
											<input type="text" name="id" id="id" placeholder="아이디를 입력해 주세요.">
											<a href="javascript:void(0);" class="delBtn"><img src="./img/icon_close_circle.svg" alt=""></a>
											<p></p>
										</div>
									</li>
									<li>
										<h2>비밀번호</h2>
										<div class="inputBox inputBoxPw">
											<input type="password" name="pw" id="pw" placeholder="비밀번호를 입력해 주세요.">
											<a href="javascript:void(0);" class="delBtn"><img src="./img/icon_close_circle.svg" alt=""></a>
											<a href="javascript:void(0);" class="pwBtn"><img src="./img/icon_pw_hide.svg" alt=""></a>
											<p></p>
										</div>
									</li>
									<li>
	                  <label for='idCheck' class="clearfix">
	                      <input type='checkbox' name='idCheck' id='idCheck' class=''>
	                      <span>아이디 저장</span>
	                  </label>
									</li>
									<li>
										<a href="javascript:void(0);" class="buttons loginBtn" onclick="loginCheck()">로그인</a>
										<a href="javascript:void(0);" class="buttons kakaoBtn"><img src="./img/icon_kakao_02.svg" alt="icon_kakao"> 카카오 로그인</a>
										<a href="javascript:void(0);" class="buttons naverBtn"><img src="./img/icon_naver_02.svg" alt="icon_naver"> 네이버 로그인</a>
									</li>
									<li>
										<hr>
										<a href="./join" class="buttons joinBtn">회원가입</a>
										<a href="javascript:void(0);" class="buttons searchBtn">아이디 / 비밀번호 찾기</a>
									</li>
								</ul>
								</form>
							</div>
						</div>

					</div>
				</div>
			</div>
		</section>

	</main>
	
	<%@ include file="/footer.jsp"%>

	<!-- GoTop 버튼 -->
	<span class='goTop'>
		<a href='#wrap' class='smoothBtn goTopBtn'><i class='fas fa-angle-up'><span class='blind'>goTop</span></i></a>
	</span>
	
	<!-- 커스텀 JS -->
	<script src='./js/fixed.js'></script>
	<script src='./js/login.js'></script>
	
</div>  
</body>
</html>