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

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

		<%@ include file="/adminHeader.jsp"%>
		
                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
                        <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
                                class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
                    </div>

                    <!-- Content Row -->
                    <div class="row">

                        <!-- 전체 회원 -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text font-weight-bold text-primary mb-1">전체 회원</div>
                                            <div class="h2 mb-0 font-weight-bold text-gray-800">20,000 <span class="text-lg">명</span></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-users fa-3x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 일반 회원 -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text font-weight-bold text-success mb-1">일반 회원</div>
                                            <div class="h2 mb-0 font-weight-bold text-gray-800">15,000 <span class="text-lg">명</span></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-user-alt fa-3x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 작가 회원 -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text font-weight-bold text-info mb-1">작가 회원</div>
                                            <div class="h2 mb-0 font-weight-bold text-gray-800">5,000 <span class="text-lg">명</span></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-user-alt fa-3x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 티켓 판매량 -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text font-weight-bold text-warning mb-1">티켓 판매</div>
                                            <div class="h2 mb-0 font-weight-bold text-gray-800">18 <span class="text-lg">개</span></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-ticket-alt fa-3x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">작가 갤러리 대기열</h1>
                    </div>

                    <!-- Content Row -->
                    <div class="row">

                        <div class="col">
                            
                            <ul class="list_wrap row">
                                <li class="col-lg-3">
                                    <div class="listInfo">
                                        <div class="image_wrap">
                                            <img src="../img/imgex3.jpg" alt="">
                                            <ul class="listBtn_wrap">
                                                <li>
                                                    <select class="form-control customSelect" name="">
                                                        <option value="">미승인</option>
                                                        <option value="">승인</option>
                                                    </select>
                                                </li>
                                                <li>
                                                    <a href="#" class="deleteBtn btn">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="title_wrap">
                                            <div>
                                                <a class="txtSkip" href="javascript:;">갤러리 작품 제목</a>
                                                <h6>사용자 닉네임</h6>
                                                <h5>2023-11-01</h5>
                                                <ul class="info_wrap">
                                                    <li>
                                                        <span>조회수 <i>22</i></span>
                                                    </li>
                                                    <li>
                                                        <span>북마크 <i>5</i></span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                                <li class="col-lg-3">
                                    <div class="listInfo">
                                        <div class="image_wrap">
                                            <img src="../img/imgex2.jpg" alt="">
                                            <ul class="listBtn_wrap">
                                                <li>
                                                    <select class="form-control customSelect" name="">
                                                        <option value="">미승인</option>
                                                        <option value="">승인</option>
                                                    </select>
                                                </li>
                                                <li>
                                                    <a href="#" class="deleteBtn btn">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="title_wrap">
                                            <div>
                                                <a class="txtSkip" href="javascript:;">갤러리 작품 제목</a>
                                                <h6>사용자 닉네임</h6>
                                                <h5>2023-11-01</h5>
                                                <ul class="info_wrap">
                                                    <li>
                                                        <span>조회수 <i>22</i></span>
                                                    </li>
                                                    <li>
                                                        <span>북마크 <i>5</i></span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                            
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