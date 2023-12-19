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

<style>
.search_wrap { text-align: right; }
.search_wrap .searchField_wrap { display: inline-block; margin-right: 15px; }
.search_wrap .searchField_wrap select {width: 150px; }
.galleryRow { justify-content: space-between; }
</style>

<script>
<!-- 게시글 삭제하기 -->
let deletePost = function(){
	let frm = document.forms['writeFrm'];
	if(confirm("정말 삭제할까요?")){
		frm.action = "gaList";
		frm.method = "post";
		frm.submit();
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
                		<form name="writeFrm"  action="/gaList" method="post">
                    	<input type="hidden" name="ga_id" value="${galleryDTO.ga_id }" />
                    </form>

                  <div class="col">
                      <div class="row galleryRow">
                         <ul class="col-lg-6 nav nav-pills mb-4" style="justify-content: left; font-size: 17px; " role="tablist">
												<li class="nav-item">
													<a class="nav-link active tabColor" data-bs-toggle="pill" href="#a">#현대미술</a>
												</li>
												<li class="nav-item">
													<a class="nav-link tabColor" data-bs-toggle="pill" href="#b">#순수미술</a>
												</li>
												<li class="nav-item">
													<a class="nav-link tabColor" data-bs-toggle="pill" href="#c">#인물화</a>
												</li>
												<li class="nav-item">
													<a class="nav-link tabColor" data-bs-toggle="pill" href="#d">#추상화</a>
												</li>
												<li class="nav-item">
													<a class="nav-link tabColor" data-bs-toggle="pill" href="#e">#개인전</a>
												</li>
											</ul>
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
											
										<div class="col">
											<div class="tab-content">
                        <ul class="list_wrap row">
                        <c:forEach items="${gaList }" var="gallery" varStatus="loop">
                            <li class="col-lg-3">
                                <div class="listInfo">
                                    <div class="image_wrap">
                                        <img src="./uploads/${gallery.art_image1 }" alt="">
                                        <ul class="listBtn_wrap">
                                            <li>
                                                <select class="form-control customSelect" name="">
                                                    <option value="">미승인</option>
                                                    <option value="">승인</option>
                                                </select>
                                            </li>
                                            <li>
                                                <a href="#" class="deleteBtn btn" onclick="deletePost(${ galleryDTO.ga_id });">
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