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
	
	<script type="text/javascript">
	
	function submit(){
		alert("저장되었습니다.")
    	var form = document.getElementById('frm');
    	removeList();
    	form.action = "/admin/accountAdmin";
    	form.method = "post";
    	form.submit();
    	window.close();
    }
    
    function removeList(){
    	${adminList} = null;
    }
    
    function removeCheck(admin_id) {
   	 if (confirm("정말 삭제하시겠습니까?") == true){    //확인
   		 deleteAdmin(admin_id);
   	 }else{   //취소
   	     return false;
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
                        <h1 class="h4 mb-0 text-gray-800">관리자계정</h1>
                    </div>

                    <!-- Content Row -->
                    <div class="row">

                        <div class="col">
                            
                            <div class="table_wrap">
                                <div class="table_gap">

                                    <div class="row" style="margin: 0;">
                                        <div class="col-lg-6">
                                            <button class="btn btn-success" type="button" data-toggle="modal" data-target="#adminWriteModal">등록하기</button>
                                        </div>
    
                                        <form id="frm" class="col-lg-6" style="padding: 0;">
                                            <div class="searchFeild_wrap">
                                                <select class="form-control" name="">
                                                    <option value="">관리자명</option>
                                                    <option value="">이메일</option>
                                                    <option value="">전화번호</option>
                                                </select>
                                            </div>
                                            <div class="searchWord_wrap">
                                                <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                                                <div class="searchBtn">
                                                    <button class="btn btn-dark" type="button" onclick="submit()">
                                                        <i class="fas fa-search fa-sm"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>

                                    <hr class="hr_dotted">

                                    <ul class="adminList_wrap row">
                                        <li class="col-lg-3" data-toggle="modal" data-target="#adminEditModal" style="cursor: pointer;">
                                            <div>
                                                <h6>${row.admin_regidate}</h6>
                                                <h2>${row.admin_name}</h2>
                                                <span>E : <i>${row.admin_id}</i></span>
                                                <span>P : <i>${row.admin_phone}</i></span>
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
    
    <!-- 관리자 모달(작성 폼) -->
    <div class="modal inmodal fade" id="adminWriteModal" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content animated fadeInDown">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                    <h2 class="text-center modal-title font-weight-bold">관리자 정보</h4>
                </div>
                <div class="modal-body">
                    <div class="ibox-content">
                       <form role="form">
                       <div class="form-group row"><label class="col-xl-2 col-form-label">관리자명</label>
                         <div class="col-xl-10"><input type="text" class="form-control" placeholder="실명으로 입력해주세요."></div>
                       </div>
                       <div class="hr-line-dashed"></div>
                        <div class="form-group row"><label class="col-xl-2 col-form-label">이메일</label>
                            <div class="col-sm-10"><input type="text" class="form-control" placeholder="이메일을 입력해주세요."></div>
                        </div>
                        <div class="form-group row"><label class="col-xl-2 col-form-label">비밀번호</label>
                            <div class="col-xl-10"><input type="text" class="form-control" placeholder="비밀번호를 입력해주세요."></div>
                        </div>
                        <div class="form-group row"><label class="col-xl-2 col-form-label">비밀번호 확인<br>
                            <small class="text-danger" id="checkPwd">비밀번호 확인</small>
                        </label>
                            <div class="col-xl-10"><input type="text" class="form-control" placeholder="비밀번호를 다시 한번 입력해주세요."></div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group row">
                            <label class="col-xl-2 col-form-label">휴대폰번호</label>
                            <div class="col-xl-10 input-group">
                                <div class="col-xl-2"><input class="form-control" /></div>
                                <div class="col-xl-2"><input class="form-control" /></div>
                                <div class="col-xl-2"><input class="form-control" /></div>
                            </div>
                        </div>
                       </form>
                    </div>
                </div>
                <div class="modal-footer d-inline-block">
                    <button type="button" class="btn btn-danger" onclick="removeCheck('${row.admin_id}')">삭제</button>
                    <button type="button" class="btn btn-success float-right" onclick="submit()">저장</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 관리자 모달(수정 폼) -->
    <div class="modal inmodal fade" id="adminEditModal" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content animated fadeInDown">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                    <h2 class="text-center modal-title font-weight-bold">관리자 정보</h4>
                </div>
                <div class="modal-body">
                    <div class="ibox-content">
                       <form role="form">
                       <div class="form-group row"><label class="col-xl-2 col-form-label">관리자명</label>
                         <div class="col-xl-10"><input type="text" class="form-control" value="김소진"></div>
                       </div>
                       <div class="hr-line-dashed"></div>
                        <div class="form-group row"><label class="col-xl-2 col-form-label">이메일</label>
                            <div class="col-sm-10"><input type="text" class="form-control" value="wlsdms3011@naver.com"></div>
                        </div>
                        <div class="form-group row"><label class="col-xl-2 col-form-label">비밀번호</label>
                            <div class="col-xl-10"><input type="text" class="form-control" value="wlswls123"></div>
                        </div>
                        <div class="form-group row"><label class="col-xl-2 col-form-label">비밀번호 확인<br>
                            <small class="text-danger" id="checkPwd">비밀번호 확인</small>
                        </label>
                            <div class="col-xl-10"><input type="text" class="form-control" value="wlswls123"></div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group row">
                            <label class="col-xl-2 col-form-label">휴대폰번호</label>
                            <div class="col-xl-10 input-group">
                                <div class="col-xl-2"><input class="form-control" value=""/></div>
                                <div class="col-xl-2"><input class="form-control" value=""/></div>
                                <div class="col-xl-2"><input class="form-control" value=""/></div>
                            </div>
                        </div>
                       </form>
                    </div>
                </div>
                <div class="modal-footer d-inline-block">
                    <button type="button" class="btn btn-danger">삭제</button>
                    <button type="button" class="btn btn-success float-right">저장</button>
                </div>
            </div>
        </div>
    </div>

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