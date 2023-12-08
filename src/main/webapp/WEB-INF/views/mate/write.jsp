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
	<link rel='stylesheet' type='text/css' href='../css/write.css'>
	
	<!-- 제이쿼리 로컬 -->
	<script src='../js/lib/jquery-1.12.4.min.js'></script>
	<script src='../js/lib/jquery.easing.1.3.js'></script>
	<script src='../js/lib/jquery.touchSwipe.js'></script>

	<!-- 브라우저별 접두사 쓸 필요 없음 -->
	<script src='../js/lib/prefixfree.min.js'></script>

	<!-- 아이콘 -->
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
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

                        <form action="./mateWrite" id="mtForm" name="mtForm" method="post" >
                        <div class="writeForm_wrap">
                            <ul>
                                <li class="row">
                                    <div class="col-lg-2 title_wrap">
                                        <h2>모집상태</h2>
                                    </div>
                                    <div class="col-lg-2 write_wrap">
                                        <select name="mt_status" class="form-select">
                                            <option value="모집중">모집중</option>
                                            <option value="모집완료">모집완료</option>
                                        </select>
                                    </div>
                                </li>
                                <li class="row">
                                    <div class="col-lg-2 title_wrap">
                                        <h2>제목</h2>
                                    </div>
                                    <div class="col-lg-10 write_wrap">
                                        <input type="text" name="mt_title" class="form-control" placeholder="제목을 입력하세요.">
                                    </div>
                                </li>
                                <li class="row">
                                    <div class="col-lg-2 title_wrap">
                                        <h2>모임장소</h2>
                                    </div>
                                    <div class="col-lg-10 write_wrap">
                                        <input type="text" name="mt_location" class="form-control" placeholder="모임 장소를 입력하세요.">
                                    </div>
                                </li>
                                <li class="row">
                                    <div class="col-lg-2 title_wrap">
                                        <h2>전시회정보</h2>
                                    </div>
                                    <div class="col-lg-10 write_wrap">
                                    	<button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#exhibitionModal" name="">전시회 선택하기</button>
                                        <!-- <button type="button" class="btn btn-dark">전시회 선택하기</button> -->
                                    </div>
                                   <!-- 전시회 정보 모달 -->
                                </li>
                                <li class="row">
                                    <div class="col-lg-2 title_wrap">
                                        <h2>관람 예정일</h2>
                                    </div>
                                    <div class="col-lg-2 write_wrap">
                                        <input type="date" name="mt_viewdate" class="form-control" placeholder="날짜 선택" required>
                                    </div>
                                </li>
                                <li class="row">
                                    <div class="col-lg-2 title_wrap">
                                        <h2>메이트 성별</h2>
                                    </div>
                                    <div class="col-lg-2 write_wrap">
                                        <select name="mt_gender" class="form-select">
                                            <option value="1">성별무관</option>
                                            <option value="2">남성</option>
                                            <option value="3">여성</option>
                                        </select>
                                    </div>
                                </li>
                                <li class="row">
                                    <div class="col-lg-2 title_wrap">
                                        <h2>메이트 나이</h2>
                                    </div>
                                    <div class="col-lg-2 write_wrap">
                                        <select name="mt_age" class="form-select">
                                            <option value="연령무">연령무관</option>
                                            <option value="20대초">20대 초반</option>
                                            <option value="20대중">20대 중반</option>
                                            <option value="20대후">20대 후반</option>
                                            <option value="30대초">30대 초반</option>
                                            <option value="30대중">30대 중반</option>
                                            <option value="30대후">30대 후반</option>
                                            <option value="40대초">40대 초반</option>
                                            <option value="40대중">40대 중반</option>
                                            <option value="40대후">40대 후반</option>
                                        </select>
                                    </div>
                                        ~
                                    <div class="col-lg-2 write_wrap">
                                        <select name="mt_age" class="form-select">
                                            <option value="연령무관">연령무관</option>
                                            <option value="20대초">20대 초반</option>
                                            <option value="20대중">20대 중반</option>
                                            <option value="20대후">20대 후반</option>
                                            <option value="30대초">30대 초반</option>
                                            <option value="30대중">30대 중반</option>
                                            <option value="30대후">30대 후반</option>
                                            <option value="40대초">40대 초반</option>
                                            <option value="40대중">40대 중반</option>
                                            <option value="40대후">40대 후반</option>
                                        </select>
                                    </div>
                                </li>
                                <li class="row">
                                    <div class="col-lg-2 title_wrap">
                                        <h2>내용</h2>
                                    </div>
                                    <div class="col-lg-10 write_wrap">
                                        <textarea name="mt_content" id="" cols="30" rows="10"></textarea>
                                    </div>
                                </li>
                            </ul>
                        </div>

                        <div class="button_wrap">
                            <!-- <a href="" class="btn btn-light cancelBtn">취소하기</a> -->
                            <!-- <a href="avascript:void(0);" class="btn btn-dark registBtn" id="registBtn" onclick="validateForm(mtForm, event");">등록하기</a>  -->
                            <a class="btn btn-light cancelBtn">취소하기</a>
                            <a href="javascript:void(0);" class="btn btn-dark registBtn" id="registBtn" onclick="validateForm(mtForm);">등록하기</a>
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
    