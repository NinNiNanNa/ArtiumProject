<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
    
    <!-- 제이쿼리 로컬 -->
	<script src='../js/lib/jquery-1.12.4.min.js'></script>
	<script src='../js/lib/jquery.easing.1.3.js'></script>
	<script src='../js/lib/jquery.touchSwipe.js'></script>


<style type="text/css">
/* 검색필드, 검색창 */
.search_wrap { width: 100%; text-align: right; }
.search_wrap .searchField_wrap { display: inline-block; margin-right: 15px; }
.search_wrap .searchField_wrap select {width: 150px; }
.search_wrap .searchWord_wrap { display: inline-block; position: relative; }
.search_wrap .searchWord_wrap .searchBtn { position: absolute; top: 0; right: 0; border-radius: 0 5px 5px 0; }
</style>

<!-- 게시글 삭제하기 -->
<script>
function deletePost(formIndex){
	var confirmed = confirm("정말로 삭제하겠습니까?");
	var form = document.forms["adminMtFrm_" + formIndex];
	if (confirmed) {
	    form.method = "post";  
	    form.action = "/admin/mtDelete";
	    form.submit();  
	}
}

//모집중 / 모집완료 분류
$(document).ready(function() {
	    // 버튼 클릭 및 해당 리스트 표시/숨기기를 처리하는 함수
	    function handleMateButtonClick(status) {
	        // 모든 nav 링크에서 'active' 클래스 제거
	        $(".nav-link").removeClass("active");
	        // 클릭된 버튼에 'active' 클래스 추가
	        $("#" + status + "Btn").addClass("active");
	        // 클릭된 버튼에 따라 해당 리스트 표시/숨기기
	        if (status === "current") {
	            $("#current").addClass("active");
	            $("#future").removeClass("active");
	        } else if (status === "future") {
	            $("#future").addClass("active");
	            $("#current").removeClass("active");
	        }
	    }

	    // URL 기반의 초기 확인
	    var currentUrl = window.location.href;
	    if (currentUrl.includes("/admin/mtCurrentList")) {
	        handleMateButtonClick("current");
	    } else if (currentUrl.includes("/admin/mtFutureList")) {
	        handleMateButtonClick("future");
	    }

	    // 버튼 클릭 이벤트 핸들러
	    $(document).on('click', '#currentBtn', function() {
	        handleMateButtonClick("current");
	    });

	    $(document).on('click', '#futureBtn', function() {
	        handleMateButtonClick("future");
	    });
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
                        <h1 class="h4 mb-0 text-gray-800">전시회 메이트</h1>
                    </div>

                    <!-- Content Row -->
                    <div class="row">

                        <div class="col">
                            <ul class="nav nav-pills mb-4" role="tablist">
                                <li class="nav-item">
                                    <a id="currentBtn" class="nav-link active tabColor" href="/admin/mtCurrentList">모집 중</a>
                                </li>
                                <li class="nav-item">
                                    <a id="futureBtn" class="nav-link tabColor" href="/admin/mtFutureList">모집완료</a>
                                </li>
                            </ul>
                            <!-- 검색 -->
                            <div class="row" style="margin: 0;">
		                       	<form method="get" class="col-lg" style="padding: 0;">
								<div class="search_wrap clearfix">
									<div class="searchField_wrap">
										<select class="form-control" name="searchField">
											<option value="mt_title">제목</option>
											<option value="user_name">작성자</option>
										</select>
									</div>
									<div class="searchWord_wrap" style="position: relative;">
										<input type="text" class="form-control" name="searchKeyword" placeholder="제목 또는 작성자를 입력하세요.">
										<button type="submit" class="btn btn-dark searchBtn"><i class="fas fa-search"></i></button>
									</div>
								</div>
								</form>
                        	</div>
                            <br/>
                            
							<div class="col">
                            <div class="tab-content">
                                <!-- <div id="mate_ing" class="tab-pane active"> -->
								<div id="current" class="tab-pane active">
                                    <ul class="list_wrap row">
                                    <%-- <c:forEach items="${ not empty lists ? lists : '999' }" var="row" varStatus="loop"> --%>
                                    <c:forEach items="${lists}" var="row" varStatus="loop">
                                    <c:choose>
										<c:when test="${row.mt_status eq '모집중'}">  
                                        <li class="col-lg-4">
                                        <form name="adminMtFrm_${loop.index}">
											<input type="hidden" name="mt_id" value="${row.mt_id }" />
										</form>
                                            <div class="listInfo">
                                                <div class="image_wrap" style="position: relative;">
                                                    <img src="../img/imgex1.jpg" alt="">
                                                    <ul class="listBtn_wrap">
                                                        <li>
                                                            <a href="javascript:void(0);" onclick="deletePost(${loop.index})" class="deleteBtn btn">
                                                                <i class="fas fa-trash-alt"></i>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="title_wrap">
                                                    <div>
                                                        <div class="userInfo">
                                                            <a class="txtSkip" href="/mateView?mt_id=${row.mt_id}">${row.mt_title}</a>
                                                            <span>${row.user_name }</span>
                                                            <span>등록일 <i>${row.mt_postdate }</i></span>
                                                            <span>조회수 <i>${row.mt_visitcount }</i></span>
                                                            <span>북마크 <i>${row.mt_bmcount }</i></span>
                                                        </div>
                                                        <div class="mateDetail">
                                                            <div>
                                                                <a class="txtSkip" href="javascript:;">전시회 제목</a>
                                                                <span>관람예정일 <i>${row.mt_viewdate }</i></span>
                                                                <span>성별 <i>${row.mt_gender }</i></span>
                                                                <span>나이 <i>${row.mt_age1 }</i>~<i>${row.mt_age2 }</i></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                        </c:when>
										</c:choose>
                                        </c:forEach>
                                    </ul>

                                </div>

                                <div id="future" class="tab-pane show">

                                    <ul class="list_wrap row">
                                        <c:forEach items="${lists}" var="row" varStatus="loop"> 
                                        <c:choose>
										<c:when test="${row.mt_status eq '모집완료'}">  
                                        <li class="col-lg-4">
                                        <form name="adminMtFrm_${loop.index}">
											<input type="hidden" name="mt_id" value="${row.mt_id }" />
										</form>
                                            <div class="listInfo">
                                                <div class="image_wrap" style="position: relative;">
                                                    <img src="../img/imgex1.jpg" alt="">
                                                    <ul class="listBtn_wrap">
                                                        <li>
                                                            <a href="javascript:void(0);" onclick="deletePost(${loop.index})" class="deleteBtn btn">
                                                                <i class="fas fa-trash-alt"></i>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="title_wrap">
                                                    <div>
                                                        <div class="userInfo">
                                                            <a class="txtSkip" href="/mateView?mt_id=${row.mt_id}">${row.mt_title}</a>
                                                            <span>${row.user_name }</span>
                                                            <span>등록일 <i>${row.mt_postdate }</i></span>
                                                            <span>조회수 <i>${row.mt_visitcount }</i></span>
                                                            <span>북마크 <i>${row.mt_bmcount }</i></span>
                                                        </div>
                                                        <div class="mateDetail">
                                                            <div>
                                                                <a class="txtSkip" href="javascript:;">전시회 제목</a>
                                                                <span>관람예정일 <i>${row.mt_viewdate }</i></span>
                                                                <span>성별 <i>${row.mt_gender }</i></span>
                                                                <span>나이 <i>${row.mt_age1 }</i>~<i>${row.mt_age2 }</i></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                        </c:when>
										</c:choose>
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