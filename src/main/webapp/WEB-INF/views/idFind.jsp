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
	<link rel='stylesheet' type='text/css' href='./css/idpwFind.css'>
	
	<!-- 제이쿼리 로컬 -->
	<script src='./js/lib/jquery-1.12.4.min.js'></script>
	<script src='./js/lib/jquery.easing.1.3.js'></script>
	<script src='./js/lib/jquery.touchSwipe.js'></script>

	<!-- 브라우저별 접두사 쓸 필요 없음 -->
	<script src='./js/lib/prefixfree.min.js'></script>
	
	<script type="text/javascript">
	    function sendNumber(){
	        $("#mail_number").css("display","block");
	        $.ajax({
	            url:"/idFind/searchId",
	            type:"post",
	            data:{"email" : $("#email").val(),
	            	"name" : $("#name").val()},
	            success: function(data){
	            	checkId(data);
	            }
	        });
	    }
	    
	    function checkId(data){
	        if(!data){
	            alert("아이디가 존재하지 않습니다.");
	        }else{
	        	alert("아이디가 발송되었습니다.");
	        }
	    }
    </script>

	<!-- 아이콘 -->
    <link href="./vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

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
								<h1>가입정보 확인</h1>
								<p>가입시 입력한 정보를 확인바랍니다.</p>
							</div>
							<div class="content_wrap">
								<ul class="tabBtn_wrap clearfix">
									<li>
										<div>
											<a href="./idFind" class="idSearchBtn addSelectBtn">아이디 찾기</a>
										</div>
									</li>
									<li>
										<div>
											<a href="./pwFind" class="pwSearchBtn">비밀번호 찾기</a>
										</div>
									</li>
								</ul>
								<ul class="inputText_wrap">
									<li>
										<h2>닉네임</h2>
										<div class="inputBox inputBoxName">
											<input type="text" name="user_name" id="name" placeholder="닉네임을 입력해주세요.">
											<a href="javascript:void(0);" class="delBtn"><img src="./img/icon_close_circle.svg" alt=""></a>
											<p></p>
										</div>
									</li>
									<li>
										<h2>이메일</h2>
										<div class="inputBox inputBoxEmail" id="mail_number">
											<input type="text" name="user_email" id="email" placeholder="이메일을 입력해주세요.">
											<a href="javascript:void(0);" class="delBtn"><img src="./img/icon_close_circle.svg" alt=""></a>
											<p></p>
										</div>
									</li>
									<li>
										<div class="buttonBox">
											<a href="javascript:void(0);" onclick="sendNumber()" class="conBtn">확인</a>
										</div>
									</li>
								</ul>
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
	<script src='./js/idpwFind.js'></script>
	
</div>  
</body>

</html>