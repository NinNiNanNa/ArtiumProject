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
    
    <script type="text/javascript">
    
	    function removeCheck(user_id) {
	    	 if (confirm("정말 삭제하시겠습니까?") == true){    //확인
	    		 deleteMember(user_id);
	    	 }else{   //취소
	    	     return false;
	    	 }
	    	}
    	
	    function deleteMember(user_id){
	        $.ajax({
	            url:"/admin/accountUser/delete",
	            type:"post",
	            data:{"user_id" : user_id},
	            success: function(data){
	            	location.reload();
	                alert("삭제 완료되었습니다.");
	            }
	        });
	    }
	    
	    function submit(){
	    	var form = document.getElementById('frm');
	    	form.action = "/admin/accountUser";
	    	form.method = "post";
	    	form.submit();
	    	
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
                        <h1 class="h4 mb-0 text-gray-800">일반회원</h1>
                    </div>

                    <!-- Content Row -->
                    <div class="row">

                        <div class="col">
                            
                            <div class="table_wrap">
                                <div class="table_gap">

                                    <form name="form1" id="frm" method="post" action="/admin/accountUser">
                                        <div class="searchFeild_wrap">
                                            <select class="form-control" name="searchOption">
                                                <option value="user_id" >아이디</option>
                                                <option value="user_name">닉네임</option>
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

                                    <table class="table" style="table-layout: fixed;">
                                        <colgroup>
                                            <col width="5%"/>
                                            <col width="15%"/>
                                            <col width="15%"/>
                                            <col width="*"/>
                                            <col width="5%"/>
                                            <col width="20%"/>
                                            <col width="15%"/>
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th>번호</th>
                                                <th>아이디</th>
                                                <th>닉네임</th>
                                                <th>이메일</th>
                                                <th>성별</th>
                                                <th>가입일</th>
                                                <th>관리</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${memberList}" var="row" varStatus="loop">
                                            <tr>
                                                <td>${loop.count}</td>
                                                <td>${row.user_id}</td>
                                                <td>${row.user_name}</td>
                                                <td>${row.user_email}</td>
                                                <td>${row.user_gender}</td>
                                                <td>${row.user_regidate}</td>
                                                <td>
                                                    <button type="button" class="btn btn-danger" onclick="removeCheck('${row.user_id}')">삭제</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
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