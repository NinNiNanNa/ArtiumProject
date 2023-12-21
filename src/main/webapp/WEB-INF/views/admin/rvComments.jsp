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
<script>
function loadFallbackImage(imgElement) {
    if (imgElement) {
        // 업로드 폴더에 이미지파일이 없어서 이미지 로딩이 실패하면 경로를 변경하여 다시 시도
        imgElement.src = "./img/" + imgElement.src.split('/').pop();
    }
}

window.onload = function(){
    showSlides(0);
	// 페이지 로드 시 댓글을 가져와서 출력
	loadComments(1);
}

//페이지 로드 시 댓글 가져와서 화면에 출력하는 함수
function loadComments(pageNum) {
	// rv_id값 null로 입력
	var rv_id = ${param.rv_id};
	console.log(rv_id + "rv_id값이다.");
	
  $.ajax({  
		  contentType : "text/html;charset:utf-8", 
		  dataType : "json",
      url: '/reviewCommentList.api',  // 댓글 가져올 URL
      method: 'GET',
      data: { pageNum: pageNum, rv_id: rv_id },  // 페이지 번호 서버에 전달 / rv_id값 null로 입력
      success: function (data) {
        // 가져온 댓글 데이터 사용하여 동적으로 댓글 생성
          $('#listReviewComment').empty(); // 기존 댓글 목록 비우기
          // 가져온 댓글 데이터 사용하여 동적으로 댓글 생성
          for (var i = 0; i < data.lists.length; i++) {
              var comments = data.lists[i];
              var buttons = '';
              var userId = "${sessionScope.userId}"; // 세션에서 현재 로그인한 사용자 아이디 가져옴
              if (userId && userId === comments.user_id) {
                buttons = '<div class="btn_wrap">' +
                      '<a href="" class="rvcEditBtn" data-edit-id="'+comments.rvc_id+'">수정</a>' +
                      '<a href="" class="rvcDeleteBtn" data-comment-id="'+comments.rvc_id+'">삭제</a>' +
                      '</div>';
              }
              
              var commentItem = '<li id="rvcList'+comments.rvc_id+'">' +
                '<input type="hidden" id="rvcId" name="rvc_id" value="'+comments.rvc_id+'" />' +
                '<div class="row commentBox commentBox'+comments.rvc_id+'">' +
        '<div class="col-lg-2 comImg_wrap">' +
        '<img src="../img/'+comments.user_image+'" alt="">' +
        /* '<img src="../uploads/'+comments.user_image+'==null ? '+profile.png+' : '+comments.user_image+'" onerror="loadFallbackImage(this)">' + */
        '</div>' +
        '<div class="col-lg-10 comText_wrap">' +
        '<div class="user_wrap">' +
        '<span>'+comments.user_name+'</span>' +
        '<span>'+comments.rvc_postdate+'</span>' +
        '</div>' +
        '<div class="content_wrap">' +
        '<p>'+comments.rvc_content+'</p>' +
        '</div>' +
        '</div>' +
        buttons +
        '</div>' +
        '</li>';
        
              $('#listReviewComment').append(commentItem);
          }
          $('.rvctotalCount').html(data.totalCount);
          $('.paging_wrap').html(data.pagingImg);
          
      },
      error: function () {
          console.error('댓글 불러오기 실패');
      }
  });
}

//페이지 링크에 대한 클릭 이벤트 추가
$(document).on('click', '.paging_wrap a', function (e) {
    e.preventDefault(); // 기본 동작 방지 (링크 클릭 시 페이지 이동 방지)

    // 클릭한 페이지 번호를 가져오기
    var pageNum = getPageNumFromUrl($(this).attr('href'));

    // 가져온 페이지 번호를 이용하여 댓글 목록 업데이트
    loadComments(pageNum);
});

// 페이지 번호를 추출하는 함수
function getPageNumFromUrl(url) {
    var match = url.match(/pageNum=(\d+)/);
    return match ? parseInt(match[1], 10) : 1;
}

// 리뷰 댓글 삭제
function deleteComment(rvcId) {
    $.ajax({
        type: "POST",
        url: "/reviewCommentDelete.api",
        data: { rvc_id: rvcId },
        success: function(response) {
            if (response.result === 1) {	// 댓글 삭제 성공
                alert("댓글이 삭제되었습니다.");
                // 삭제 후 댓글 목록을 업데이트하는 함수 호출
                loadComments();
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
$(document).on('click', 'a.rvcDeleteBtn', function(e) {
    e.preventDefault();

    var rvcId = $(this).data('comment-id');
    
 	// 확인 창 띄우기
    var isConfirmed = confirm('댓글을 삭제하시겠습니까?');
 	
 	// 확인이 눌렸을 경우에만 삭제 요청
    if (isConfirmed) {
        // 서버로 삭제 요청을 보냄
        deleteComment(rvcId);
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
                        <h1 class="h4 mb-0 text-gray-800">전시회 리뷰 댓글</h1>
                    </div>

                    <!-- Content Row -->
                    <div class="row">

                        <div class="col">
                            
                            <div class="table_wrap">
                                <div class="table_gap">

                                    <form>
                                        <div class="searchFeild_wrap">
                                            <select class="form-control" name="">
                                                <option value="">닉네임</option>
                                                <option value="">내용</option>
                                            </select>
                                        </div>
                                        <div class="searchWord_wrap">
                                            <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                                            <div class="searchBtn">
                                                <button class="btn btn-dark" type="button">
                                                    <i class="fas fa-search fa-sm"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </form>

                                    <div class="comment_wrap">
										<div class="comment_title">
											<h1><i class="rvctotalCount">5</i>개의 댓글을 확인해보세요!</h1>
			                            </div>
			                            <div class="comment_content">
											<ul class="comList_wrap">
												<li>
													<div id="listReviewComment">
														<!-- 리뷰 댓글 목록 출력 부분 -->
													</div>
												</li>
											</ul>
			                            </div>
			                            <div class="paging_wrap">
			                            	<!-- 리뷰 댓글 페이지네이션 출력 부분 -->
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