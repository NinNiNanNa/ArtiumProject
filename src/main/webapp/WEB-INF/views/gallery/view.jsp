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
	<link rel='stylesheet' type='text/css' href='../css/reset.css'>
	<link rel='stylesheet' type='text/css' href='../css/fonts.css'>
	<link rel='stylesheet' type='text/css' href='../css/fixed.css'>
	<link rel='stylesheet' type='text/css' href='../css/gaView.css'>
	
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
							<h2>GALLERY</h2>
							<p>온라인 전시회에 오신걸 환영합니다.</p>
						</div>

                    </div>
                </div>
            </div>
        </section>

        <section id="section2">
            <div class="wrap1440">
                <div class="gap1440">
                    <div class="container1440">
                    
                    <form name="writeFrm" action="">
                    	<input type="hidden" name="ga_id" value="${galleryDTO.ga_id }" />
                    </form>
                        <div class="view_content">
                            <div>
								<span class="status">#현대미술</span>
                                <h2>${ galleryDTO.ga_title }</h2>
                                <ul>
                                    <li>
                                        <div>
                                            <span>관람 기간</span>
                                            <i>${ galleryDTO.ga_sdate } ~ ${ galleryDTO.ga_edate }</i>
                                        </div>
                                    </li>
                                    <li>
                                        <div>
                                            <span>작가 이름</span>
                                            <i>${ galleryDTO.user_id }</i>
                                        </div>
                                    </li>
                                </ul>
                                <div class="longContent">
                                    <p>${ galleryDTO.ga_content }</p>
                                </div>
                                
																<div class="galleryBtn_wrap">
																	<a href="/galleryRoom" class="galleryBtn">ONLINE GALLERY</a>
																</div>
                                <div class="memInfo_wrap">
                                    <div class="profileImg_wrap">
                                        <img src="../img/profile.png" alt="">
                                    </div>
                                    <div class="profileInfo_wrap">
                                     		 <h4>${ galleryDTO.user_id }</h4>
                                         <span>작성일<i>${ galleryDTO.ga_postdate }</i></span>
                                         <span>조회수<i>${ galleryDTO.ga_visitcount }</i></span>
                                    </div>
																		<div class="bmBtn_wrap">
																			<a href="javascript:;" class="bmBtn">저장하기</a>
																		</div>
                                </div>
                            </div>
                        </div>

											<div class="viewBtn_wrap">
												<a href="" class="btn btn-light" onclick="">삭제하기</a>
												<a href="" class="btn btn-secondary" onclick="">수정하기</a>
												<a href="/galleryList" class="btn btn-dark" >목록보기</a>
											</div>

                    </div>
                </div>
            </div>
        </section>

        <section id="section3">
            <div class="wrap1440">
                <div class="gap1440">
                    <div class="container1440">

                        <div class="comment_wrap">
                            <div class="comment_title">
                                <h1><i>5</i>개의 댓글을 확인해보세요!</h1>
                            </div>
                            <div class="comment_content">
															<ul class="comList_wrap">
																<li>
																	<div class="row">
																		<div class="col-lg-2 comImg_wrap">
																			<img src="../img/profile.png" alt="">
																		</div>
																		<div class="col-lg-9 comWrite_wrap">
																			<div class="user_wrap">
																				<span>닉네임</span>
																			</div>
																			<div class="content_wrap">
																				<textarea name="" id="" cols="30" rows="2" placeholder="댓글을 남겨주세요."></textarea>
																			</div>
																		</div>
																		<div class="col-lg-1 commentBtn_wrap">
																			<button type="button" class="btn btn-dark">등록</button>
																		</div>
																	</div>
																</li>
																<li>
																	<div class="row">
																		<div class="col-lg-2 comImg_wrap">
																			<img src="../img/profile.png" alt="">
																		</div>
																		<div class="col-lg-10 comText_wrap">
																			<div class="user_wrap">
																				<span>닉네임</span>
																			</div>
																			<div class="content_wrap">
																				댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용<br>
																				댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용<br>
																			</div>
																		</div>
																		<div class="btn_wrap">
																			<a href="">수정</a>
																			<a href="">삭제</a>
																		</div>
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
	<script src='../js/fixed.js'></script>
	<!-- <script src='../js/'></script> -->
	
</div>  
</body>
</html>
    