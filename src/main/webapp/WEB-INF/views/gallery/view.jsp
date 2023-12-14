<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE HTML>
<html lang='ko' class=''>
<head>
	<title>ARTIUM</title>
	<meta charset='utf-8'>
	<meta name='Viewport'    content='width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0'>
	<meta name='Title'       content='ARTIUM'>
	<meta name='Subject'     content='전시회 플랫폼'>
	<meta name='format-detection' content='telephone=no'>	
	<meta name='Description' content='전시회 정보, 리뷰, 메이트, 일반 작가 갤러리 등을 경험할 수 있는 사이트'>
	<meta name='Author'      content='청일홍사'>
	<meta name='Author-Date' content='2023-11-24'>
	<meta name='Robots'      content='index,follow'>

	<!-- 파비콘 -->	
	<link rel='shortcut icon' href='./img/brando-114x114-1.png'>
	<link rel='apple-touch-icon' href='./img/brando-114x114-1.png'>
	
	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>	
	
	<!-- 커스텀 CSS 스타일 -->
	<link rel='stylesheet' type='text/css' href='../css/reset.css'>
	<link rel='stylesheet' type='text/css' href='../css/fonts.css'>
	<link rel='stylesheet' type='text/css' href='../css/fixed.css'>
	<link rel='stylesheet' type='text/css' href='../css/gaView.css'>
	
	<!-- 제이쿼리 로컬 -->
	<script src='../js/lib/jquery-1.12.4.min.js'></script>
	<script src='../js/lib/jquery.easing.1.3.js'></script>
	<script src='../js/lib/jquery.touchSwipe.js'></script>

	<!-- 브라우저별 접두사 쓸 필요 없음 -->
	<script src='../js/lib/prefixfree.min.js'></script>

	<!-- 아이콘 -->
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

<script>
<!-- 로그인 세션 -->
function checkLoginAndRedirect(destination) {
    // 세션에서 userId 가져오기
    var userId = "${sessionScope.userId}";
    console.log(userId);
    if (userId === undefined || userId === null || userId.trim() === "") {
        // 로그인이 되어 있지 않은 경우
        alert("작가회원 로그인 후  작성하실 수 있습니다.");
       	window.location.href = "/login";
    } 
    else {
        // 로그인이 된 경우 지정된 페이지로 이동
        window.location.href = destination;
    }
}
<!-- 게시글 삭제하기 -->
let deletePost = function(){
	let frm = document.forms['writeFrm'];
	if(confirm("정말 삭제할까요?")){
		frm.action = "galleryList";
		frm.method = "post";
		frm.submit();
	}
}

<!-- 댓글 작성 및 등록을 처리하는 스크립트 -->
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
    cmContent.addEventListener('keyup', function () {
        // 입력된 텍스트의 길이를 #textCnts에 표시
        textCnts.innerHTML = "(" + cmContent.value.length + " / 150)";

        // 만약 입력된 텍스트의 길이가 150을 초과하면
        if (cmContent.value.length > 150) {
        	// 입력된 텍스트를 150자까지만 자르고 다시 #cmContent에 설정
          cmContent.value = cmContent.value.substring(0, 150);
         // #textCnt에 (15 / 150)으로 표시
         textCnts.innerHTML = "(150 / 150)";
        }
    });
});

//페이지 로드 시 댓글 가져와서 화면에 출력하는 함수
function loadComments(pageNum) {
	var ga_id = ${ga_id};
	console.log(ga_id + "ga_id값이다.");
	
  $.ajax({  
		  contentType : "text/html;charset:utf-8", 
		  dataType : "json",
      url: '/galleryCommentList.api',  // 댓글 가져올 URL
      method: 'GET',
      data: { pageNum: pageNum, ga_id: ga_id },  // 페이지 번호 서버에 전달
      success: function (data) {
        // 가져온 댓글 데이터 사용하여 동적으로 댓글 생성
          $('#galleryCommentList').empty(); // 기존 댓글 목록 비우기
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
        '<p>'+comments.srv_content+'</p>' +
        '</div>' +
        '</div>' +
        buttons +
        '</div>' +
        '</li>';
        
              $('#galleryCommentList').append(commentItem);
          }
          $('.cmtotalCount').html(data.totalCount);
          $('.paging_wrap').html(data.pagingImg);
          
      },
      error: function () {
          console.error('댓글 불러오기 실패');
      }
  });
}

</script>

</head>
<body>
<div id='wrap'>
	
	<ul id='skip'>
		<li><a href='#header'>메뉴바로가기</a></li>
		<li><a href='#main'>메인바로가기</a></li>
		<li><a href='#footer'>하단바로가기</a></li>
	</ul>
	
	<%@ include file="/header.jsp"%>

    <main id="main">
        
        <section id="section1">
            <div class="wrap1440">
                <div class="gap1440">
                    <div class="container1440">

                        <div class='main-title'>
													<h2>GALLERY</h2>
													<p>온라인 전시회에 오신걸 환영합니다.</p>
												</div>

                    </div>
                </div>
            </div>
        </section>

        <section id="section2">
            <div class="wrap1440">
                <div class="gap1440">
                    <div class="container1440">
                    
                    <form name="writeFrm"  action="/galleryList" method="post">
                    	<input type="hidden" name="ga_id" value="${galleryDTO.ga_id }" />
                    </form>
                        <div class="view_content">
                            <div>
																<span class="status">#현대미술</span>
                                <h2>${ galleryDTO.ga_title }</h2>
                                <ul>
                                    <li>
                                        <div>
                                            <span>관람 기간</span>
                                            <i>${ galleryDTO.ga_sdate } ~ ${ galleryDTO.ga_edate }</i>
                                        </div>
                                    </li>
                                    <li>
                                        <div>
                                            <span>작가 이름</span>
                                            <i>${ galleryDTO.user_name }</i>
                                        </div>
                                    </li>
                                </ul>
                                <div class="longContent">
                                    <p>${ galleryDTO.ga_content }</p>
                                </div>
                                
																<div class="galleryBtn_wrap">
																	<a href="/galleryRoom?ga_id=${galleryDTO.ga_id }" class="galleryBtn">ONLINE GALLERY</a>
																</div>
                                <div class="memInfo_wrap">
                                    <div class="profileImg_wrap">
                                        <img src="../img/${galleryDTO.user_image }" alt="">
                                    </div>
                                    <div class="profileInfo_wrap">
                                     		 <h4>${ galleryDTO.user_name }</h4>
                                         <span>작성일<i>${ galleryDTO.ga_postdate }</i></span>
                                         <span>조회수<i>${ galleryDTO.ga_visitcount }</i></span>
                                    </div>
																		<div class="bmBtn_wrap">
																			<a href="javascript:;" class="bmBtn">저장하기</a>
																		</div>
                                </div>
                            </div>
                        </div>

											<div class="viewBtn_wrap">
												<a href="#" class="btn btn-light" onclick="deletePost(${ galleryDTO.ga_id });">삭제하기</a>
												<a href="/galleryEdit?ga_id=${ galleryDTO.ga_id }" class="btn btn-secondary" onclick="checkLoginAndRedirect('/galleryWrite')">수정하기</a><!-- /galleryEdit?ga_id=${ galleryDTO.ga_id } -->
												<a href="/galleryList" class="btn btn-dark" >목록보기</a>
											</div>

                    </div>
                </div>
            </div>
        </section>
        
        
        <section id="section3">
            <div class="wrap1440">
                <div class="gap1440">
                    <div class="container1440">

                        <div class="comment_wrap">
                            <div class="comment_title">
                                <h1><i class="cmtotalCount">5</i>개의 댓글을 확인해보세요!</h1>
                            </div>
                            <div class="comment_content">
															<ul class="comList_wrap">
															<form method="post" action="galleryCommentWrite.api"  id="galleryCommentviewForm">
																<li>
																	<div class="row commentBox" >
																<c:choose>
																	<c:when test="${not empty userId }">
																		<div class="col-lg-2 comImg_wrap">
																			<img src="../img/${userImg }" alt="">
																		</div>
																		<div class="col-lg-9 comWrite_wrap">
																			<div class="user_wrap">
																				<span>${ userName }</span>
																			</div>
																		</c:when>
																	<c:otherwise>
																			<div class="col-lg-2 comImg_wrap">
																				<img src="../img/profile.png" alt="">
																			</div>
																			<div class="col-lg-9 comWrite_wrap">
																				<div class="user_wrap">
																					<div class="user_wrap">
																						<span>비회원 <i style="color: red;"> ※ 로그인이 필요합니다</i></span>
																					</div>
																				</div>
																		</c:otherwise>
																	</c:choose>
																			<div class="content_wrap">
																				<div id="textCnts" class="col-lg-6" style="width:100%; text-align: right;">(0/150)</div>
																				<textarea name="cm_comment" id="cmContent" cols="30" rows="2" placeholder="댓글을 남겨주세요."></textarea>
																			</div>
																		</div>
																		<div class="col-lg-1 commentBtn_wrap">
																			<button type="button" class="btn btn-dark" id="cmCntBtn" onclick="postComment()">등록</button>
																		</div>
																	</div>
																</li>
																</form>
																<li>
																	<div id="onGalleryCommentList">
																		<!-- 갤러리 댓글 목록 출력 부분 -->
																	</div>
																</li> 
																<%-- <li>
																	<div class="row commentBox">
																		<div class="col-lg-2 comImg_wrap">
																			<img src="../img/${galleryCommentDTO.user_image }" alt="">
																		</div>
																		<div class="col-lg-10 comText_wrap">
																			<div class="user_wrap">
																				<span>${galleryCommentDTO.user_name }</span>
																			</div>
																			<div class="content_wrap">
																			<span>${ galleryCommentDTO.cm_comment }</span>
																			</div>
																		</div>
																		<div class="btn_wrap">
																			<a href="">수정</a>
																			<a href="">삭제</a>
																		</div>
																	</div>
																</li> --%>
															</ul>
                            </div>
                            <div class="paging_wrap">
                            	<!-- 갤러리 댓글 페이지네이션 출력 부분 -->
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </section>

    </main>
	
	<%@ include file="/footer.jsp"%>

	<!-- GoTop 버튼 -->
	<span class='goTop'>
		<a href='#wrap' class='smoothBtn goTopBtn'><i class='fas fa-angle-up'><span class='blind'>goTop</span></i></a>
	</span>
	
	<!-- 커스텀 JS -->
	<script src='../js/fixed.js'></script>
	<!-- <script src='../js/'></script> -->
	
</div>  
</body>
</html>
    