<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
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
	<link rel='stylesheet' type='text/css' href='../css/reset.css'>
	<link rel='stylesheet' type='text/css' href='../css/fonts.css'>
	<link rel='stylesheet' type='text/css' href='../css/fixed.css'>
	<link rel='stylesheet' type='text/css' href='../css/rvList.css'>
	
	<!-- 제이쿼리 로컬 -->
	<script src='../js/lib/jquery-1.12.4.min.js'></script>
	<script src='../js/lib/jquery.easing.1.3.js'></script>
	<script src='../js/lib/jquery.touchSwipe.js'></script>

	<!-- 브라우저별 접두사 쓸 필요 없음 -->
	<script src='../js/lib/prefixfree.min.js'></script>

	<!-- 아이콘 -->
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

</head>
<body>
<div id='wrap'>
	
	<ul id='skip'>
		<li><a href='#header'>메뉴바로가기</a></li>
		<li><a href='#main'>메인바로가기</a></li>
		<li><a href='#footer'>하단바로가기</a></li>
	</ul>
	
	<%@ include file="/header.jsp"%>
	
	<main id="main">

		<section id="section1">
			<div class="wrap1440">
				<div class="gap1440">
					<div class="container1440">

						<div class='main-title'>
							<h2>REVIEW</h2>
							<p>다양한 전시 리뷰를 찾아보세요.</p>
						</div>

					</div>
				</div>
			</div>
		</section>

		<section id="section2">
			<div class="wrap1440">
				<div class="gap1440">
					<div class="container1440">

						<div class='content'>

							<!-- Content Row -->
							<div class="row">
								
								<div class="search_wrap clearfix">
									<div class="searchField_wrap">
										<select class="form-select" name="searchField">
											<option value="">제목</option>
											<option value="">닉네임</option>
										</select>
									</div>
									<div class="searchWord_wrap">
										<input type="text" class="form-control" name="searchWord" placeholder="제목 또는 닉네임을 입력하세요.">
										<button type="button" class="btn btn-dark searchBtn"><i class="fas fa-search"></i></button>
									</div>
								</div>
								<div class="writeBtn_wrap">
									<a href="/reviewWrite">리뷰 등록</a>
								</div>
								
								<div class="col" style="margin-top: 30px;">

									<ul class='list_wrap row'>
									
									<c:forEach items="${ lists }" var="row" varStatus="loop">
										<li class="col-lg-3">
											<div class="listInfo">
												<div class="image_wrap">
													<img src="../img/imgex1.jpg" alt="">
													<div class="listBtn_wrap">
														<a href="#" class="bookMarkBtn">
															<i class="fas fa-bookmark"></i>
														</a>
													</div>
												</div>
												<div class="title_wrap">
													<div>
														<a class="txtSkip" href="/reviewView?rv_id=${row.rv_id }">${row.rv_title }</a>
														<h6>사용자 닉네임</h6>
														<h5>${row.rv_postdate }</h5>
														<ul class="info_wrap">
															<li>
																<span>조회수 <i>${row.rv_visitcount }</i></span>
															</li>
															<li>
																<span>북마크 <i>${row.rv_bmcount }</i></span>
															</li>
														</ul>
													</div>
												</div>
											</div>
										</li>
									</c:forEach>
									</ul>
									
								</div>

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
	<script src='../js/fixed.js'></script>
	<!-- <script src='../js/'></script> -->
	
</div>  
</body>
</html>
    