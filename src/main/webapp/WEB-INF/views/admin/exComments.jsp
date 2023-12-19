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

</head>
<script>
//댓글 삭제 함수
function deleteComment(srvId) {
  $.ajax({
      type: "POST",
      url: "/adminExhibitionReviewDelete.api",
      data: { srv_id: srvId },
      success: function(response) {
          if (response.result === 1) {	// 댓글 삭제 성공
			alert("댓글이 삭제되었습니다.");
          	// 페이지를 새로고침
            location.reload();
          } else {	// 댓글 삭제 실패
              alert("댓글 삭제에 실패하였습니다.");
          }
      },
      error: function(error) {
          // 에러 처리
          console.log(error);
      }
  });
}

//삭제 버튼 클릭 시 이벤트 처리
$(document).on('click', '.srvDeleteBtn', function(e) {
	e.preventDefault();

	var srvId = $(this).data('comment-id');
  
	// 확인 창 띄우기
  	var isConfirmed = confirm('댓글을 삭제하시겠습니까?');

	// 확인이 눌렸을 경우에만 삭제 요청
  	if (isConfirmed) {
	   // 서버로 삭제 요청을 보냄
	   deleteComment(srvId);
  	}
    
});
</script>
<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

		<%@ include file="/adminHeader.jsp"%>
		
                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h4 mb-0 text-gray-800">전시회 한줄평</h1>
                    </div>

                    <!-- Content Row -->
                    <div class="row">

                        <div class="col">
                            
                            <div class="table_wrap">
                                <div class="table_gap">

                                    <form method="get">
                                        <div class="searchFeild_wrap">
                                            <select class="form-control" name="searchField">
                                                <option value="user_name">닉네임</option>
                                                <option value="srv_content">내용</option>
                                            </select>
                                        </div>
                                        <div class="searchWord_wrap">
                                            <input type="text" class="form-control bg-light border-0 small" name="searchKeyword"  placeholder="닉네임 또는 내용을 입력해주세요." aria-label="Search" aria-describedby="basic-addon2">
                                            <div class="searchBtn">
                                                <button class="btn btn-dark" type="button">
                                                    <i class="fas fa-search fa-sm"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </form>

                                    <table class="table" style="table-layout: fixed;">
                                        <colgroup>
                                            <col width="80px"/>
                                            <col width="150px"/>
                                            <col width="*"/>
                                            <col width="200px"/>
                                            <col width="150px"/>
                                            <col width="150px"/>
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th>번호</th>
                                                <th>닉네임</th>
                                                <th>내용</th>
                                                <th>게시글 일련번호</th>
                                                <th>작성일</th>
                                                <th>기능</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${srvLists }" var="row" varStatus="loop">
                                            <tr>
                                                <td>${ maps.totalCount - (((maps.pageNum-1) * maps.pageSize) + loop.index)}</td>
                                                <td>${row.user_name }</td>
                                                <td class="txtSkip">${row.srv_content }</td>
                                                <td>${row.ex_seq }</td>
                                                <td>${row.srv_postdate }</td>
                                                <td><button type="button" class="btn btn-danger srvDeleteBtn" data-comment-id="${row.srv_id }">삭제</button></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
									<div class="paging_wrap" style="margin-top: 20px">
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