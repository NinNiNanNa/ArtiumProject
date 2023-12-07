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
	<link rel='stylesheet' type='text/css' href='./css/join.css'>
	
	<!-- 제이쿼리 로컬 -->
	<script src='./js/lib/jquery-1.12.4.min.js'></script>
	<script src='./js/lib/jquery.easing.1.3.js'></script>
	<script src='./js/lib/jquery.touchSwipe.js'></script>

	<!-- 브라우저별 접두사 쓸 필요 없음 -->
	<script src='./js/lib/prefixfree.min.js'></script>

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
            <div class="wrap">
                <div class="gap">
                    <div class="container">
                        
											<div class="wrap470">
												<div class="title_wrap">
													<h1>회원가입</h1>
													<div>
														<h2>필수입력사항</h2>
													</div>
												</div>
												<div class="content_wrap">
													<ul class="inputText_wrap">
														<li>
															<h2>회원구분</h2>
															<div class="inputBox">
																<label for='userMember' class="clearfix">
																	<input type='radio' name='member' id='userMember' value='' checked>
																	<span>일반회원</span>
																</label>
																<label for='authorMember' class="clearfix">
																	<input type='radio' name='member' id='authorMember' value=''>
																	<span>작가회원</span>
																</label>
															</div>
														</li>
														<li>
															<h2>아이디</h2>
															<div class="inputBox inputBoxId">
																<input type="text" name="id" id="id" placeholder="아이디를 입력해 주세요.">
																<a href="javascript:void(0);" class="delBtn"><img src="./img/icon_close_circle.svg" alt=""></a>
																<a href="javascript:void(0);" class="addChkBtn">중복확인</a>
																<p></p>
															</div>
														</li>
														<li>
															<h2>비밀번호 입력</h2>
															<div class="inputBox inputBoxPw1">
																<input type="password" name="pw1" id="pw1" placeholder="비밀번호를 입력해 주세요.">
																<a href="javascript:void(0);" class="delBtn"><img src="./img/icon_close_circle.svg" alt=""></a>
																<a href="javascript:void(0);" class="pwBtn"><img src="./img/icon_pw_hide.svg" alt=""></a>
																<p></p>
															</div>
														</li>
														<li>
															<h2>비밀번호 확인</h2>
															<div class="inputBox inputBoxPw2">
																<input type="password" name="pw2" id="pw2" placeholder="비밀번호를 다시 입력해 주세요.">
																<a href="javascript:void(0);" class="delBtn"><img src="./img/icon_close_circle.svg" alt=""></a>
																<a href="javascript:void(0);" class="pwBtn"><img src="./img/icon_pw_hide.svg" alt=""></a>
																<p></p>
															</div>
														</li>
														<li>
															<h2>닉네임</h2>
															<div class="inputBox inputBoxName">
																<input type="text" name="name" id="name" placeholder="닉네임을 입력해 주세요.">
																<a href="javascript:void(0);" class="delBtn"><img src="./img/icon_close_circle.svg" alt=""></a>
																<p></p>
															</div>
														</li>
														<li>
															<h2>성별</h2>
															<div class="inputBox">
																<label for='genderM' class="clearfix">
																	<input type='radio' name='gender' id='genderM' value='' checked>
																	<span>남성</span>
																</label>
																<label for='genderW' class="clearfix">
																	<input type='radio' name='gender' id='genderW' value=''>
																	<span>여성</span>
																</label>
															</div>
														</li>
														<li>
															<h2>이메일</h2>
															<div class="inputBox inputBoxEmail">
																<input type="text" name="email" id="email" placeholder="이메일을 입력해 주세요.">
																<a href="javascript:void(0);" class="delBtn"><img src="./img/icon_close_circle.svg" alt=""></a>
																<a href="javascript:void(0);" class="addChkBtn">본인인증</a>
																<p></p>
															</div>
														</li>
													</ul>
						
													<ul class="button_wrap clearfix">
														<li>
															<div>
																<a href="javascript:void(0);" class="joinCanBtn">취소</a>
															</div>
														</li>
														<li>
															<div>
																<a href="javascript:void(0);" class="joinConBtn">확인</a>
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
	<script src='./js/join.js'></script>
	
</div>  
</body>
</html>