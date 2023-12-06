<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                                    <a class="nav-link active tabColor" data-bs-toggle="pill" href="#mate_ing">모집 중</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link tabColor" data-bs-toggle="pill" href="#mate_com">모집완료</a>
                                </li>
                            </ul>

                            <div class="tab-content">
                                <div id="mate_ing" class="tab-pane active">

                                    <ul class="list_wrap row">
                                        <li class="col-lg-4">
                                            <div class="listInfo">
                                                <div class="image_wrap" style="position: relative;">
                                                    <img src="../img/imgex1.jpg" alt="">
                                                    <ul class="listBtn_wrap">
                                                        <li>
                                                            <a href="#" class="deleteBtn btn">
                                                                <i class="fas fa-trash-alt"></i>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="title_wrap">
                                                    <div>
                                                        <div class="userInfo">
                                                            <a class="txtSkip" href="javascript:;">메이트 모집 제목</a>
                                                            <span>사용자 닉네임</span>
                                                            <span>등록일 <i>2023-11-22</i></span>
                                                            <span>조회수 <i>22</i></span>
                                                            <span>북마크 <i>5</i></span>
                                                        </div>
                                                        <div class="mateDetail">
                                                            <div>
                                                                <a class="txtSkip" href="javascript:;">전시회 제목</a>
                                                                <span>관람예정일 <i>2023-11-22</i></span>
                                                                <span>성별 <i>여</i></span>
                                                                <span>나이 <i>26</i></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>

                                </div>

                                <div id="mate_com" class="tab-pane fade">

                                    <ul class="list_wrap row">
                                        <li class="col-lg-4">
                                            <div class="listInfo">
                                                <div class="image_wrap">
                                                    <img src="../img/imgex2.jpg" alt="">
                                                    <ul class="listBtn_wrap mateListBtn_wrap">
                                                        <li>
                                                            <a href="#" class="deleteBtn btn">
                                                                <i class="fas fa-trash-alt"></i>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="title_wrap">
                                                    <div>
                                                        <div class="userInfo">
                                                            <a class="txtSkip" href="javascript:;">메이트 모집 제목</a>
                                                            <span>사용자 닉네임</span>
                                                            <span>등록일 <i>2023-11-22</i></span>
                                                            <span>조회수 <i>22</i></span>
                                                            <span>북마크 <i>5</i></span>
                                                        </div>
                                                        <div class="mateDetail">
                                                            <div>
                                                                <a class="txtSkip" href="javascript:;">전시회 제목</a>
                                                                <span>관람예정일 <i>2023-11-22</i></span>
                                                                <span>성별 <i>여</i></span>
                                                                <span>나이 <i>26</i></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>

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