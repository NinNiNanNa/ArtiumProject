<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Artium 관리자</title>

  <!-- Custom fonts for this template-->
  <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link
      href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
      rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="../css/sb-admin-2.min.css" rel="stylesheet">

  <!-- CSS 스타일 -->
  <link href="../css/admin.css" rel="stylesheet">

  <!-- 부트스트랩5 CDN -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  
	<!-- jQuery 라이브러리 로드 -->
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
   
<style>
.search_wrap { text-align: right; }
.search_wrap .searchField_wrap { display: inline-block; margin-right: 15px; }
.search_wrap .searchField_wrap select {width: 150px; }
.galleryRow { justify-content: space-between; }
</style>

<script>
<!-- 전시유형 -->
$(function() {
	 let ga_type = '${param.ga_type}';
	 switch (ga_type) {
	 	case '현대미술':
	 		$("#modernArtBtn").addClass("active");
	 		break;
	 	case '순수미술':
	 		$("#fineArtBtn").addClass("active");
	 		break;
	 	case '인물화':
	 		$("#portraitPaintingBtn").addClass("active");
	 		break;
	 	case '추상화':
	 		$("#abstractBtn").addClass("active");
	 		break;
	 	case '개인전':
	 		$("#soloExhibitionBtn").addClass("active");
	 		break;
	 	default:
	 		break;
	 }
});

<!-- 게시글 삭제하기 -->
 function deletePost(formIndex){
	var confirmed = confirm("정말로 삭제하겠습니까?");
	var form = document.forms["adminGaListFrm_" + formIndex];
	if (confirmed) {
	    form.method = "post";  
	    form.action = "/admin/gaList";
	    form.submit();  
	}
} 
</script>

</head>

<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

<%@ include file="/adminHeader.jsp"%>

            <!-- Begin Page Content -->
            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="d-sm-flex align-items-center justify-content-between mb-4">
                    <h1 class="h4 mb-0 text-gray-800">작가 갤러리</h1>
                </div>

                <!-- Content Row -->
                <div class="row ">
                  <div class="col">
                      <div class="row galleryRow">
												<form name="writeFrm" action="/gaList" method="post">
												<input type="hidden" name="ga_id" value="${galleryDTO.ga_id }" />
													<ul class="nav nav-pills mb-4" style="justify-content: left; font-size: 17px; " role="tablist">
														<li class="nav-item">
															<a id="modernArtBtn" class="nav-link tabColor" href="?ga_type=현대미술">#현대미술</a>
														</li>
														<li class="nav-item">
															<a id="fineArtBtn" class="nav-link tabColor" href="?ga_type=순수미술">#순수미술</a>
														</li>
														<li class="nav-item">
															<a id="portraitPaintingBtn" class="nav-link tabColor" href="?ga_type=인물화">#인물화</a>
														</li>
														<li class="nav-item">
															<a id="abstractBtn" class="nav-link tabColor" href="?ga_type=추상화">#추상화</a>
														</li>
														<li class="nav-item">
															<a id="soloExhibitionBtn" class="nav-link tabColor" href="?ga_type=개인전">#개인전</a>
														</li>
													</ul>								
												</form>
                     	<form method="get" class="col-lg-6" style="padding: 0;">
												<div class="search_wrap clearfix">
													<div class="searchField_wrap">
														<select class="form-control" name="searchField">
															<option value="ga_title">제목</option>
															<option value="user_name">닉네임</option>
														</select>
													</div>
													<div class="searchWord_wrap" style="position: relative;">
														<input type="text" class="form-control" name="searchKeyword" placeholder="제목 또는 닉네임을 입력하세요.">
														<button type="submit" class="btn btn-dark searchBtn"><i class="fas fa-search"></i></button>
													</div>
												</div>
											</form>
										</div>
										
                 	
										
										
										<div class="col">
											<div class="tab-content">
											<div id="#현대미술" class="tab-pane active">
                        <ul class="list_wrap row">
                        <c:forEach items="${gaList }" var="gallery" varStatus="loop">
                        <form name="adminGaListFrm_${loop.index}">
													<input type="hidden" name="ga_id" value="${gallery.ga_id }" />
												</form>
                            <li class="col-lg-3">
                            
                                <div class="listInfo">
                                    <div class="image_wrap">
	                                   	 <img src="../uploads/${gallery.art_image1 }" alt="art_image" />
                                        <ul class="listBtn_wrap">
                                            <li>
                                                <select class="form-control customSelect" name="approve">
                                                    <option value="">미승인</option>
                                                    <option value="">승인</option>
                                                </select>
                                            </li>
                                            <li>
                                                <a href="javascript:void(0);" class="deleteBtn btn" onclick="deletePost(${loop.index})">
                                                    <i class="fas fa-trash-alt"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="title_wrap">
                                        <div>
                                            <a class="txtSkip" href="/galleryView?ga_id=${ gallery.ga_id }">${ gallery.ga_title }</a>
                                            <h6>${ gallery.user_name }</h6>
                                            <h5>${ gallery.ga_sdate } ~ ${ gallery.ga_edate }</h5>
                                            <ul class="info_wrap">
                                                <li>
                                                    <span>조회수 <i>${ gallery.ga_visitcount }</i></span>
                                                </li>
                                                <li>
                                                    <span>북마크 <i>${ gallery.ga_bmcount }</i></span>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            </c:forEach>
                       		 </ul>
	                        <div class="paging_wrap">
														${ pagingImg }
													</div>
                        </div>
											</div>
                    </div>

									
                </div>
              </div>
            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- End of Main Content -->

<%@ include file="/adminFooter.jsp"%>

<!-- Bootstrap core JavaScript-->
<script src="../vendor/jquery/jquery.min.js"></script>
<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="../vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="../js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="../vendor/chart.js/Chart.min.js"></script>

<!-- Page level custom scripts -->
<script src="../js/demo/chart-area-demo.js"></script>
<script src="../js/demo/chart-pie-demo.js"></script>

</body>

</html>