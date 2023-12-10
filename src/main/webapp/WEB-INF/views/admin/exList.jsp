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


<style type="text/css">
/* 검색필드, 검색창 */
.search_wrap { width: 100%; text-align: right; }
.search_wrap .searchField_wrap { display: inline-block; margin-right: 15px; }
.search_wrap .searchField_wrap select {width: 150px; }
.search_wrap .searchWord_wrap { display: inline-block; position: relative; }
.search_wrap .searchWord_wrap .searchBtn { position: absolute; top: 0; right: 0; border-radius: 0 5px 5px 0; }
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
    var currentUrl = window.location.href;

    function handleExhibitionButtonClick(status) {
        var navLinks = document.querySelectorAll(".nav-link");
        navLinks.forEach(function(link) {
            link.classList.remove("active");
        });

        document.getElementById(status + "Btn").classList.add("active");
    }

    if (currentUrl.includes("/admin/exhibitionCurrentList")) {
        handleExhibitionButtonClick("current");
    } else if (currentUrl.includes("/admin/exhibitionFutureList")) {
        handleExhibitionButtonClick("future");
    } else if (currentUrl.includes("/admin/exhibitionPastList")) {
        handleExhibitionButtonClick("past");
    }
});
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
                        <h1 class="h4 mb-0 text-gray-800">전시회</h1>
                    </div>

                    <!-- Content Row -->
                    <div class="row">

                        <div class="col">
                        	<div class="row" style="margin: 0;">
	                            <ul class="col-lg-6 nav nav-pills mb-4" style="padding: 0;">
	                                <li class="nav-item">
	                                    <a id="currentBtn" class="nav-link active tabColor" href="/admin/exhibitionCurrentList">현재전시</a>
	                                </li>
	                                <li class="nav-item">
	                                    <a id="futureBtn" class="nav-link tabColor" href="/admin/exhibitionFutureList">예정전시</a>
	                                </li>
	                                <li class="nav-item">
	                                    <a id="pastBtn" class="nav-link tabColor" href="/admin/exhibitionPastList">만료전시</a>
	                                </li>
	                            </ul>
		                       	<form method="get" class="col-lg-6" style="padding: 0;">
								<div class="search_wrap clearfix">
									<div class="searchField_wrap">
										<select class="form-control" name="searchField">
											<option value="ex_title">제목</option>
											<option value="ex_place">전시관</option>
										</select>
									</div>
									<div class="searchWord_wrap" style="position: relative;">
										<input type="text" class="form-control" name="searchKeyword" placeholder="제목 또는 전시관을 입력하세요.">
										<button type="submit" class="btn btn-dark searchBtn"><i class="fas fa-search"></i></button>
									</div>
								</div>
								</form>
                        	</div>

                            <div class="tab-content">
                                <div id="current">

                                    <ul class="list_wrap row">
                                    	<c:forEach items="${lists }" var="row" varStatus="loop">
                                        <li class="col-lg-3">
                                            <div class="listInfo">
                                                <div class="image_wrap">
                                                    <img src="${row.ex_imgURL }" alt="">
                                                </div>
                                                <div class="title_wrap">
                                                    <div>
                                                        <a class="txtSkip" href="javascript:;">${row.ex_title }</a>
                                                        <h6 class="txtSkip">${row.ex_place }</h6>
                                                        <h5>${row.ex_sDate } ~ ${row.ex_eDate }</h5>
                                                        <ul class="info_wrap">
                                                            <li>
                                                                <span>조회수 <i>${row.ex_visitCount }</i></span>
                                                            </li>
                                                            <li>
                                                                <span>북마크 <i>${row.ex_bmCount }</i></span>
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