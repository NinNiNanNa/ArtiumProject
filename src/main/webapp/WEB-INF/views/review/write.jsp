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
<script>
function validateForm(form) {
   if (form.rv_title.value == ""){
      alert("제목을 입력하세요.");
      form.rv_title.focus();
      
      return false;
   }
   if (form.rv_date.value == ""){
      alert("관람일 날짜를 선택하세요.");
      form.rv_date.focus();
      return false;
   }
   if (form.rv_stime.value == ""){
      alert("관람 시작시간을 선택하세요.");
      form.rv_stime.focus();
      return false;
   }
   if (form.rv_etime.value == ""){
      alert("관람 종료시간을 선택하세요.");
      form.rv_etime.focus();
      return false;
   }
   if (form.rv_congestion.value == ""){
      alert("혼잡도를 선택하세요.");
      form.rv_congestion.focus();
      return false;
   }
   if (form.rv_transportation.value == ""){
      alert("교통수단을 선택하세요.");
      form.rv_transportation.focus();
      return false;
   }
   if (form.rv_revisit.value == ""){
      alert("재방문 의향을 선택하세요.");
      form.rv_revisit.focus();
      return false;
   }
   if (form.rv_content.value == ""){
      alert("내용을 입력하세요.");
      form.rv_content.focus();
      return false;
   }
   document.getElementById('rvForm').submit();
}
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

                        <form action="/reviewWrite" id="rvForm" name="rvForm" method="post" enctype="multipart/form-data">
                        <div class="writeForm_wrap">
                            <ul>
                                <li class="row">
                                    <div class="col-lg-2 title_wrap">
                                        <h2>제목</h2>
                                    </div>
                                    <div class="col-lg-10 write_wrap">
                                        <input type="text" name="rv_title" class="form-control" placeholder="제목을 입력하세요.">
                                    </div>
                                </li>
                                <li class="row">
                                    <div class="col-lg-2 title_wrap">
                                        <h2>전시회정보</h2>
                                    </div>
                                    <div class="col-lg-10 write_wrap">
                                        <button type="button" class="btn btn-dark">전시회 선택하기</button>
                                    </div>
                                </li>
                                <li class="row">
                                    <div class="col-lg-2 title_wrap">
                                        <h2>관람일</h2>
                                    </div>
                                    <div class="col-lg-2 write_wrap">
                                        <input type="date" name="rv_date" class="form-control" placeholder="날짜 선택" required>
                                    </div>
                                </li>
                                <li class="row">
                                    <div class="col-lg-2 title_wrap">
                                        <h2>관람시간</h2>
                                    </div>
                                    <div class="col-lg-2 write_wrap">
                                        <select name="rv_stime" class="form-select">
                                            <option value="">관람시작시간</option>
                                            <option value="00">00시</option>
                                            <option value="01">01시</option>
                                            <option value="02">02시</option>
                                            <option value="03">03시</option>
                                            <option value="04">04시</option>
                                            <option value="05">05시</option>
                                            <option value="06">06시</option>
                                            <option value="07">07시</option>
                                            <option value="08">08시</option>
                                            <option value="09">09시</option>
                                            <option value="10">10시</option>
                                            <option value="11">11시</option>
                                            <option value="12">12시</option>
                                            <option value="13">13시</option>
                                            <option value="14">14시</option>
                                            <option value="15">15시</option>
                                            <option value="16">16시</option>
                                            <option value="17">17시</option>
                                            <option value="18">18시</option>
                                            <option value="19">19시</option>
                                            <option value="20">20시</option>
                                            <option value="21">21시</option>
                                            <option value="22">22시</option>
                                            <option value="23">23시</option>
                                            <option value="24">24시</option>
                                        </select>
                                    </div>
                                        ~
                                    <div class="col-lg-2 write_wrap">
                                        <select name="rv_etime" class="form-select">
                                            <option value="">관람종료시간</option>
                                            <option value="00">00시</option>
                                            <option value="01">01시</option>
                                            <option value="02">02시</option>
                                            <option value="03">03시</option>
                                            <option value="04">04시</option>
                                            <option value="05">05시</option>
                                            <option value="06">06시</option>
                                            <option value="07">07시</option>
                                            <option value="08">08시</option>
                                            <option value="09">09시</option>
                                            <option value="10">10시</option>
                                            <option value="11">11시</option>
                                            <option value="12">12시</option>
                                            <option value="13">13시</option>
                                            <option value="14">14시</option>
                                            <option value="15">15시</option>
                                            <option value="16">16시</option>
                                            <option value="17">17시</option>
                                            <option value="18">18시</option>
                                            <option value="19">19시</option>
                                            <option value="20">20시</option>
                                            <option value="21">21시</option>
                                            <option value="22">22시</option>
                                            <option value="23">23시</option>
                                            <option value="24">24시</option>
                                        </select>
                                    </div>
                                </li>
                                <li class="row">
                                    <div class="col-lg-2 title_wrap">
                                        <h2>혼잡도</h2>
                                    </div>
                                    <div class="col-lg-2 write_wrap">
                                        <select name="rv_congestion" class="form-select">
                                            <option value="">혼잡도</option>
                                            <option value="1">한산</option>
                                            <option value="2">보통</option>
                                            <option value="3">북적거림</option>
                                            <option value="4">매우혼잡</option>
                                        </select>
                                    </div>
                                </li>
                                <li class="row">
                                    <div class="col-lg-2 title_wrap">
                                        <h2>교통수단</h2>
                                    </div>
                                    <div class="col-lg-2 write_wrap">
                                        <select name="rv_transportation" class="form-select">
                                            <option value="">교통수단</option>
                                            <option value="1">도보</option>
                                            <option value="2">버스</option>
                                            <option value="3">지하철</option>
                                            <option value="4">차</option>
                                        </select>
                                    </div>
                                </li>
                                <li class="row">
                                    <div class="col-lg-2 title_wrap">
                                        <h2>재방문 의향</h2>
                                    </div>
                                    <div class="col-lg-2 write_wrap">
                                        <select name="rv_revisit" class="form-select">
                                            <option value="">재방문 의향</option>
                                            <option value="1">모르겠다</option>
                                            <option value="2">전혀없다</option>
                                            <option value="3">조금있다</option>
                                            <option value="4">재방문예정</option>
                                        </select>
                                    </div>
                                </li>
                                <li class="row">
                                    <div class="col-lg-2 title_wrap">
                                        <h2>파일첨부</h2>
                                    </div>
                                    <div class="col-lg-10 write_wrap">
                                        <div class="uploadimg_wrap">

                                        </div>
                                        <label for="rvImgFile">
                                            <div class="uploadBtn">사진 올리기</div>
                                        </label>
                                        <input type="file" multiple name="rvUpload" id="rvImgFile" accept="image/gif, image/jpeg, image/png">
                                    </div>
                                </li>
                                <li class="row">
                                    <div class="col-lg-2 title_wrap">
                                        <h2>내용</h2>
                                    </div>
                                    <div class="col-lg-10 write_wrap">  
                                        <textarea name="rv_content" id="" cols="30" rows="10"></textarea>
                                    </div>
                                </li>
                            </ul>
                        </div>

                        <div class="button_wrap">
                            <a href="/reviewList" class="btn btn-light cancelBtn">취소하기</a>
                            <a href="javascript:void(0);" class="btn btn-dark registBtn" onclick="validateForm(rvForm);">등록하기</a>
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
	<script src='../js/rvWrite.js'></script>
	
</div>  
</body>
</html>
    