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

<script>
<!-- 댓글 등록 및 삭제 스크립트 -->
window.onload = function(){
	// 페이지 로드 시 댓글 가져와서 출력
	loadComments(1);
}
//댓글 글자 길이 카운트 및 엔터 키 이벤트
document.addEventListener('DOMContentLoaded', function () {
    var cmContent = document.getElementById('cmContent');
    var textCnts = document.getElementById('textCnts');

    cmContent.addEventListener('keydown', function (e) {
        // 엔터 키가 눌렸을 때
        if (e.keyCode === 13) {
        	// 기본 동작인 줄바꿈 막음
        	e.preventDefault();
            // 댓글 작성 함수 호출
            postComment();
        }
    });
});

//페이지 로드 시 댓글 가져와서 화면에 출력하는 함수
function loadComments(pageNum) {
	// ga_id값 null로 입력
	var cm_id = ${param.cm_id};
	console.log(cm_id + "cm_id값이다.");
	
  $.ajax({  
		  contentType : "text/html;charset:utf-8", 
		  dataType : "json",
      url: '/admin/gaComments',  // 댓글 가져올 URL
      method: 'GET',
      data: { pageNum: pageNum, cm_id: cm_id },  // 페이지 번호 서버에 전달 / ga_id값 null로 입력
      success: function (data) {
        // 가져온 댓글 데이터 사용하여 동적으로 댓글 생성
          $('#listGalleryComment').empty(); // 기존 댓글 목록 비우기
          // 가져온 댓글 데이터 사용하여 동적으로 댓글 생성
          for (var i = 0; i < data.lists.length; i++) {
              var comments = data.lists[i];
              var buttons = '';
              var userId = "${sessionScope.userId}"; // 세션에서 현재 로그인한 사용자 아이디 가져옴
              if (userId && userId === comments.user_id) {
                buttons = '<div class="btn_wrap">' +
                      '<a href="" class="cmEditBtn" data-edit-id="'+comments.cm_id+'">수정</a>' +
                      '<a href="" class="cmDeleteBtn" data-comment-id="'+comments.cm_id+'">삭제</a>' +
                      '</div>';
              }
              
              var commentItem = '<li id="cmList'+comments.cm_id+'">' +
                '<input type="hidden" id="cmId" name="cm_id" value="'+comments.cm_id+'" />' +
                '<div class="row commentBox commentBox'+comments.cm_id+'">' +
        '<div class="col-lg-2 comImg_wrap">' +
        '<img src="../img/'+comments.user_image+'" alt="">' +
        '</div>' +
        '<div class="col-lg-10 comText_wrap">' +
        '<div class="user_wrap">' +
        '<span>'+comments.user_name+'</span>' +
        '<span>'+comments.cm_postdate+'</span>' +
        '</div>' +
        '<div class="content_wrap">' +
        '<p>'+comments.cm_content+'</p>' +
        '</div>' +
        '</div>' +
        buttons +
        '</div>' +
        '</li>';
        
              $('#listGalleryComment').append(commentItem);
          }
          $('.cmtotalCount').html(data.totalCount);
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
//갤러리 댓글 삭제
function deleteComment(cmId) {
    $.ajax({
        type: "POST",
        url: "/admin/gaCommentsDelete",
        data: { cm_id: cmId },
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
$(document).on('click', 'a.cmDeleteBtn', function(e) {
    e.preventDefault();

    var cmId = $(this).data('comment-id');
    
 	// 확인 창 띄우기
    var isConfirmed = confirm('댓글을 삭제하시겠습니까?');
 	
 	// 확인이 눌렸을 경우에만 삭제 요청
    if (isConfirmed) {
        // 서버로 삭제 요청을 보냄
        deleteComment(cmId);
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
                        <h1 class="h4 mb-0 text-gray-800">작가 갤러리 댓글</h1>
                    </div>

                    <!-- Content Row -->
                    <div class="row">
                    
                    	<form name="writeFrm"  action="/admin/gaComments" method="post">
	                    	<input type="hidden" name="cm_id" value="${galleryDTO.cm_id }" />
	                    </form>
	                    
                        <div class="col">
                             
                            <div class="table_wrap">
                                <div class="table_gap">

                                    <form name="gaCmAdmin" id="gaCmAdmin" method="post" action="/admin/gaComments">
                                        <div class="searchFeild_wrap">
                                            <select class="form-control" name="searchOption">
                                                <option value="user_name">닉네임</option>
                                                <option value="cm_content">내용</option>
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
                                            <col width="80px"/>
                                            <col width="150px"/>
                                            <col width="*"/>
                                            <col width="150px"/>
                                            <col width="150px"/>
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th>번호</th>
                                                <th>닉네임</th>
                                                <th>내용</th>
                                                <th>작성일</th>
                                                <th>기능</th>
                                            </tr>
                                        </thead>
                                        <%-- <tbody>
                                        	<c:forEach items="${galleryComment }" var="gaComment" varStatus="loop">
                                            <tr>
                                                <td>${gaComment.cm_id }</td>
                                                <td>${gaComment.user_name }</td>
                                                <td class="txtSkip">${gaComment.cm_content }</td>
                                                <td>${gaComment.cm_postdate }</td>
                                                <td><button type="button" class="btn btn-danger" onclick="gacRemoveCheck('${gaComment.user_id}')">삭제</button></td>
                                            </tr>
                                            <!-- <tr>
                                                <td>2</td>
                                                <td>닌니난나</td>
                                                <td class="txtSkip">어디까지 작성할 수 있을까?어디까지 작성할 수 있을까?어디까지 작성할 수 있을까?어디까지 작성할 수 있을까</td>
                                                <td>2023-11-23</td>
                                                <td><button type="button" class="btn btn-danger">삭제</button></td>
                                            </tr> -->
                                        	</c:forEach>
                                        </tbody> --%>
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