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
	
	<script type="text/javascript">
	
    $(document).on('click', '#modal', function(e) {
    	var admin_id = $(this).data('admin-id');
        $.ajax({
            url:"/adminInfoEdit.api",
            type:"post",
            data:{"admin_id" : admin_id},
            success: function(data){  
            	document.getElementById('update_admin_name').value = data.admin_name;
            	document.getElementById('update_admin_pass').value = data.admin_pass;
            	document.getElementById('update_admin_pass_check').value = data.admin_pass;
            	document.getElementById('update_admin_phone').value = data.admin_phone;
            	document.getElementById('update_admin_id').value = data.admin_id;
            },
            error:function(request,status,error){        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 
        	},
       	});
    	}
	);
	
	function submit(){
		alert("저장되었습니다.")
    	var form = document.getElementById('frm');
    	form.action = "/admin/accountAdmin";
    	form.method = "post";
    	form.submit();
    }
	
	function registFormSubmit(){
		alert("저장되었습니다.")
    	var form = document.getElementById('registForm');
    	form.action = "/admin/accountAdmin/join";
    	form.method = "post";
    	form.submit();
    }
	
	function updateFormSubmit(){
		alert("수정되었습니다.")
    	var form = document.getElementById('updateForm');
    	form.action = "/admin/accountAdmin/update";
    	form.method = "post";
    	form.submit();
    }
    
    function removeCheck(admin_id) {
   	 if (confirm("정말 삭제하시겠습니까?") == true){    //확인
   		 deleteAdmin(admin_id);
   	 }else{   //취소
   	     return false;
   	 }
   	}
    
    function deleteAdmin(admin_id){
        $.ajax({
            url:"/admin/accountAdmin/admindelete",
            type:"post",
            data:{"admin_id" : admin_id},
            success: function(data){
            	location.reload();
                alert("삭제되었습니다.");
            }
        });
    }
    
    
	</script>
</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

		<%@ include file="/adminHeader.jsp"%>

                <!-- Begin Page Content -->
                <div class="container-fluid">
	                <%-- <c:set var="adminName" value="${sessionScope.}"></c:set>
	                <c:set var="adminId" value="${sessionScope.adminId}"></c:set>
					<c:set var="adminPass" value="${sessionScope.adminPass}"></c:set>
					<c:set var="adminPhone" value="${sessionScope.adminPhone}"></c:set> --%>

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
    
                                        <form name="form1" id="frm" method="post" action="/admin/accountAdmin" class="col-lg-6" style="padding: 0;">
                                            <div class="searchFeild_wrap">
                                                <select class="form-control" name="searchOption">
                                                    <option value="admin_name">관리자명</option>
                                                    <option value="admin_id">이메일</option>
                                                    <option value="admin_phone">전화번호</option>
                                                </select>
                                            </div>
                                            <div class="searchWord_wrap">
                                                <input type="text" name="keyword" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
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
                                        <c:forEach items="${adminList}" var="row" varStatus="loop">
	                                        <li class="col-lg-3" id="modal" data-toggle="modal" data-target="#adminEditModal" data-admin-id="${row.admin_id}"  style="cursor: pointer;">
	                                            <div>
	                                                <h6>${row.admin_regidate}</h6>
	                                                <h2>${row.admin_name}</h2>
	                                                <span>E : <i>${row.admin_id}</i></span>
	                                                <span>P : <i>${row.admin_phone}</i></span>
	                                            </div>
	                                        </li>
                                        </c:forEach>
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
                       <form id="registForm" role="form">
                       <div class="form-group row"><label class="col-xl-2 col-form-label">관리자명</label>
                         <div class="col-xl-10"><input name ="admin_name" id="name" type="text" class="form-control" placeholder="실명으로 입력해주세요."></div>
                       </div>
                       <div class="hr-line-dashed"></div>
                        <div class="form-group row"><label class="col-xl-2 col-form-label">이메일</label>
                            <div class="col-sm-10"><input name ="admin_id" id="id" type="text" class="form-control" placeholder="이메일을 입력해주세요."></div>
                        </div>
                        <div class="form-group row"><label class="col-xl-2 col-form-label">비밀번호</label>
                            <div class="col-xl-10"><input name ="admin_pass" id="pw" type="text" class="form-control" placeholder="비밀번호를 입력해주세요."></div>
                        </div>
                        <div class="form-group row"><label class="col-xl-2 col-form-label">비밀번호 확인<br>
                            <small class="text-danger" id="checkPwd">비밀번호 확인</small>
                        </label>
                            <div class="col-xl-10"><input type="text" name ="admin_pass2" class="form-control" placeholder="비밀번호를 다시 한번 입력해주세요."></div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group row"><label class="col-xl-2 col-form-label">휴대폰번호</label>
                            <div class="col-xl-10 input-group">
                                <div class="col-sm-10"><input name ="admin_phone" id="phone" type="text" class="form-control" placeholder="휴대폰번호를 입력해주세요."></div>
                            </div>
                        </div>
                       </form>
                    </div>
                </div>
                <div class="modal-footer d-inline-block">
                    <button type="button" class="btn btn-success float-right" onclick="registFormSubmit()">저장</button>
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
                       <form id="updateForm" role="form">
                       <div class="form-group row"><label class="col-xl-2 col-form-label">관리자명</label>
                         <div class="col-xl-10"><input name ="admin_name" id="update_admin_name" type="text" class="form-control"></div>
                       </div>
                       <div class="hr-line-dashed"></div>
                        <div class="form-group row"><label class="col-xl-2 col-form-label">이메일</label>
                            <div class="col-sm-10"><input name ="admin_id" id="update_admin_id" type="text" class="form-control"></div>
                        </div>
                        <div class="form-group row"><label class="col-xl-2 col-form-label">비밀번호</label>
                            <div class="col-xl-10"><input name ="admin_pass" id="update_admin_pass" type="text" class="form-control"></div>
                        </div>
                        <div class="form-group row"><label class="col-xl-2 col-form-label">비밀번호 확인<br>
                            <small class="text-danger" id="checkPwd">비밀번호 확인</small>
                        </label>
                            <div class="col-xl-10"><input type="text" id="update_admin_pass_check" class="form-control"></div>
                        </div>
                        <div class="hr-line-dashed"></div>
                        <div class="form-group row"><label class="col-xl-2 col-form-label">휴대폰번호</label>
                            <div class="col-xl-10 input-group">
                                <div class="col-sm-10"><input name="admin_phone" id="update_admin_phone" type="text" class="form-control"/></div>
                            </div>
                        </div>
                       </form>
                    </div>
                </div>
                <div class="modal-footer d-inline-block">
                    <button type="button" class="btn btn-danger" onclick="removeCheck('${row.admin_id}')">삭제</button>
                    <button type="button" class="btn btn-success float-right" onclick="updateFormSubmit()">저장</button>
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