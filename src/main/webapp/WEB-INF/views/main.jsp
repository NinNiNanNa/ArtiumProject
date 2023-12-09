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
	<link rel='stylesheet' type='text/css' href='./css/main.css'>
	
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
	
		<section id='section1'>
			<div class='wrap1440'>
				<div class='gap1440'>
					<div class='container1440'>
						
						<div class='main-title'>
							<span class='smallTitle'>ART + INFOMATION + MUSEUM</span>
							<h2>WELCOME TO ARTIUM</h2>
							<p>국내 모든 전시 정보를 한곳에서 보세요.</p>
							<span>
								<a href='#section2' class='smoothBtn' title='OUR SERVICES'>OUR SERVICES</a>
							</span>
						</div>

					</div>
				</div>
			</div>
		</section>
		
		<section id='section2'>
			<div class='wrap1440'>
				<div class='gap1440'>
					<div class='container1440'>

						<div class='content'>
							<ul class='clearfix'>
								<li>
									<div>
										<h2>EXHIBITIONS</h2>
										<hr>
										<div class='s2Image'>
											<a href='/exhibitionCurrentList'><img src='./img/sImg2_1.jpg' alt=''></a>
										</div>
										<div class='s2Text'>
											<p>다양한 전시 정보를 찾아보세요.</p>
											<div>
												<a href='/exhibitionCurrentList'>바로가기<i class="fas fa-arrow-right"></i></a>
											</div>
										</div>
									</div>
								</li>
								<li>
									<div>
										<h2>REVIEW</h2>
										<hr>
										<div class='s2Image'>
											<a href='/reviewList'><img src='./img/sImg2_2.jpg' alt=''></a>
										</div>
										<div class='s2Text'>
											<p>다양한 전시 리뷰를 찾아보세요.</p>
											<div>
												<a href='/reviewList'>바로가기<i class="fas fa-arrow-right"></i></a>
											</div>
										</div>
									</div>
								</li>
								<li>
									<div>
										<h2>MATE</h2>
										<hr>
										<div class='s2Image'>
											<a href='/mateList'><img src='./img/sImg2_3.jpg' alt=''></a>
										</div>
										<div class='s2Text'>
											<p>전시회에 같이 갈 친구를 찾아보세요.</p>
											<div>
												<a href='/mateList'>바로가기<i class="fas fa-arrow-right"></i></a>
											</div>
										</div>
									</div>
								</li>
							</ul>
						</div>

					</div>
				</div>
			</div>
		</section>
		
		<section id='section3'>
			<div class='fullWrap'>
				<div class='fullGap'>
					<div class='fullContainer'>
						
						<div class='content'>
							<ul class='clearfix'>
								<li> <!-- 왼쪽 텍스트 박스 -->
									<div class="info">
										<h2>'오늘 참 잘 쉬었다고'<br>생각한 적이 언제인가요?</h2>
										<p>
											일상 속 미술관람을 즐기며,<br>몸과 마음, 정신까지 회복되는 힐링
											<br><br>
											잡념이 사라지고 영감을 떠오를 수 있는 곳
											<br><br>
											우리가 몰랐던 그 시대의 이야기<br>새롭게 알게되는 이야기를
											<br><br>
											우리가 걷고 듣고 생각하고<br>쉴 수 있는 공간을 찾을 수 있습니다.
										</p>
									</div>
								</li>
								<li> <!-- 오른쪽 이미지 박스 -->
								</li>
							</ul>
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
	<script src='./js/main.js'></script>
	
</div>  
</body>
</html>