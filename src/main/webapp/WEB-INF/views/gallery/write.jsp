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
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	
	<!-- 커스텀 CSS 스타일 -->
	<link rel='stylesheet' type='text/css' href='../css/reset.css'>
	<link rel='stylesheet' type='text/css' href='../css/fonts.css'>
	<link rel='stylesheet' type='text/css' href='../css/fixed.css'>
	<link rel='stylesheet' type='text/css' href='../css/write.css'>
	
	<!-- 제이쿼리 로컬 -->
	<script src='../js/lib/jquery-1.12.4.min.js'></script>
	<script src='../js/lib/jquery.easing.1.3.js'></script>
	<script src='../js/lib/jquery.touchSwipe.js'></script>

	<!-- 브라우저별 접두사 쓸 필요 없음 -->
	<script src='../js/lib/prefixfree.min.js'></script>

	<!-- 아이콘 -->
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

</head>

<!-- 등록/취소버튼에 대한 클릭 이벤트 -->
<script>
$(document).ready(function(){
	// 등록버튼 클릭 시 폼 제출
	$("#registBtn").click(function(){
		$("form").submit();
	});

	// 취소버튼 클릭시 이전 페이지로 이동
	$(".cancelBtn").click(function(){
		history.back();
	});
});
</script>

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

                        <form name="writeFrm" action="/galleryWrite" method="post" enctype="multipart/form-data" id="artworkUploadForm">
	                        <div class="writeForm_wrap">
	                            <ul>
	                                <li class="row">
	                                    <div class="col-lg-2 title_wrap">
	                                        <h2>전시 유형</h2>
	                                    </div>
	                                    <div class="col-lg-2 write_wrap">
	                                        <select name="${galleryDTO.ga_type }" class="form-select">
	                                            <option value="${galleryDTO.ga_type }">현대미술</option>
	                                            <option value="${galleryDTO.ga_type }">순수미술</option>
	                                            <option value="${galleryDTO.ga_type }">추상화</option>
	                                            <option value="${galleryDTO.ga_type }">인물전</option>
	                                            <option value="${galleryDTO.ga_type }">개인전</option>
	                                        </select>
	                                    </div>
	                                </li>
	                                <li class="row">
	                                    <div class="col-lg-2 title_wrap">
	                                        <h2>제목</h2>
	                                    </div>
	                                    <div class="col-lg-10 write_wrap">
	                                        <input type="text" name="ga_title" class="form-control" placeholder="제목을 입력하세요.">
	                                    </div>
	                                </li>
	                                <li class="row">
	                                    <div class="col-lg-2 title_wrap">
	                                        <h2>작가 이름</h2>
	                                    </div>
	                                    <div class="col-lg-10 write_wrap">
	                                        <input type="text" name="user_id" class="form-control" placeholder="작가 이름을 입력하세요.">
	                                    </div>
	                                </li>
	                                <li class="row">
	                                    <div class="col-lg-2 title_wrap">
	                                        <h2>관람 기간</h2>
	                                    </div>
	                                    <div class="col-lg-2 write_wrap">
	                                        <input type="date" name="ga_sdate" class="form-control" placeholder="날짜 선택" required>
	                                    </div>
																				~
	                                    <div class="col-lg-2 write_wrap">
	                                        <input type="date" name="ga_edate" class="form-control" placeholder="날짜 선택" required>
	                                    </div>
	                                </li>
	                                <li class="row">
	                                    <div class="col-lg-2 title_wrap">
	                                        <h2>내용</h2>
	                                    </div>
	                                    <div class="col-lg-10 write_wrap">
	                                        <textarea name="ga_content" id="ga_content" cols="30" rows="10" placeholder="내용을 입력해주세요."></textarea>
	                                    </div>
	                                </li>
	                            </ul>
															<ul>
																<li class="row">
																	<div class="col-lg-12 title_wrap" style="text-align: center;">
																		<h2>작품 업로드</h2>
																	</div>
																</li>
																<li class="row">
																	<div class="col-lg-8 artWrite_wrap">
																		<input type="text" name="art_title1" class="form-control mb-3" placeholder="작품1 제목을 입력해주세요">
																		<input type="date" name="art_date1" class="form-control mb-3" placeholder="작품1 제작일" required>
																		<textarea name="art_content1" id="" cols="30" rows="10" placeholder="작품1 내용을 입력해주세요."></textarea>
																	</div>
																	<div class="col-lg-4 artImg_wrap">
	                                  <label for="artImgFile1">
	                                      <div class="uploadBtn">작품1 올리기</div>
	                                  </label>
	                                  <input type="file" name="art_image1" id="artImgFile1" accept="image/gif, image/jpeg, image/png">
																		<img id="preview1" src="" alt="">
																	</div>
																</li>
																<li class="row">
																	<div class="col-lg-8 artWrite_wrap">
																		<input type="text" name="art_title2" class="form-control mb-3" placeholder="작품2 제목을 입력해주세요">
																		<input type="date" name="art_date2" class="form-control mb-3" placeholder="작품2 제작일" required>
																		<textarea name="art_content2" id="" cols="30" rows="10" placeholder="작품2 내용을 입력해주세요."></textarea>
																	</div>
																	<div class="col-lg-4 artImg_wrap">
			                               <label for="artImgFile2">
			                                   <div class="uploadBtn">작품2 올리기</div>
			                               </label>
			                               <input type="file" name="art_image2" id="artImgFile2" accept="image/gif, image/jpeg, image/png">
																		 <img id="preview2" src="" alt="">
																	</div>																	
																</li>
																<li class="row">
																	<div class="col-lg-8 artWrite_wrap">
																		<input type="text" name="art_title3" class="form-control mb-3" placeholder="작품3 제목을 입력해주세요">
																		<input type="date" name="art_date3"  class="form-control mb-3" placeholder="작품3 제작일" required>
																		<textarea name="art_content3" id="" cols="30" rows="10" placeholder="작품3 내용을 입력해주세요."></textarea>
																	</div>
																	<div class="col-lg-4 artImg_wrap">
		                                <label for="artImgFile3">
		                                    <div class="uploadBtn">작품3 올리기</div>
		                                </label>
		                                <input type="file" name="art_image3" id="artImgFile3" accept="image/gif, image/jpeg, image/png">
																		<img id="preview3" src="" alt="">
																	</div>
																</li>
																<li class="row">
																	<div class="col-lg-8 artWrite_wrap">
																		<input type="text" name="art_title4" class="form-control mb-3" placeholder="작품4 제목을 입력해주세요">
																		<input type="date" name="art_date4"  class="form-control mb-3" placeholder="작품4 제작일" required>
																		<textarea name="art_content4" id="" cols="30" rows="10" placeholder="작품4 내용을 입력해주세요."></textarea>
																	</div>
																	<div class="col-lg-4 artImg_wrap">
	                                  <label for="artImgFile4">
	                                      <div class="uploadBtn">작품4 올리기</div>
	                                  </label>
	                                  <input type="file" name="art_image4" id="artImgFile4" accept="image/gif, image/jpeg, image/png">
																		<img id="preview4" src="" alt="">
																	</div>
																</li>
																<li class="row">
																	<div class="col-lg-8 artWrite_wrap">
																		<input type="text" name="art_title5" class="form-control mb-3" placeholder="작품5 제목을 입력해주세요">
																		<input type="date" name="art_date5"  class="form-control mb-3" placeholder="작품5 제작일" required>
																		<textarea name="art_content5" id="" cols="30" rows="10" placeholder="작품5 내용을 입력해주세요."></textarea>
																	</div>
																	<div class="col-lg-4 artImg_wrap">
	                                  <label for="artImgFile5">
	                                      <div class="uploadBtn">작품5 올리기</div>
	                                  </label>
	                                  <input type="file" name="art_image5" id="artImgFile5" accept="image/gif, image/jpeg, image/png">
																		<img id="preview5" src="" alt="">
																	</div>
																</li>
															</ul>
	                        </div>

	                        <div class="button_wrap">
	                            <a href="" class="btn btn-light cancelBtn">취소하기</a>
	                            <a href="javascript:void(0);" class="btn btn-dark registBtn" id="registBtn">등록하기</a>
	                        </div>

                    	</form>
                        
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
	<script src='../js/gaWrite.js'></script>
	
	<!-- 파일 업로드 JS -->
	<script src="../js/gaFileUpload.js"></script>
	
</div>  
</body>
</html>
    