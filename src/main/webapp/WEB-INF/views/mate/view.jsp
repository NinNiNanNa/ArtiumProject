<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html lang='ko' class=''>
<head>
<title>ARTIUM</title>
<meta charset='utf-8'>
<meta name='Viewport'
	content='width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0'>
<meta name='Title' content='ARTIUM'>
<meta name='Subject' content='전시회 플랫폼'>
<meta name='format-detection' content='telephone=no'>
<meta name='Description'
	content='전시회 정보, 리뷰, 메이트, 일반 작가 갤러리 등을 경험할 수 있는 사이트'>
<meta name='Author' content='청일홍사'>
<meta name='Author-Date' content='2023-11-24'>
<meta name='Robots' content='index,follow'>

<!-- 파비콘 -->
<link rel='shortcut icon' href='./img/brando-114x114-1.png'>
<link rel='apple-touch-icon' href='./img/brando-114x114-1.png'>

<!-- 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- 커스텀 CSS 스타일 -->
<link rel='stylesheet' type='text/css' href='../css/reset.css'>
<link rel='stylesheet' type='text/css' href='../css/fonts.css'>
<link rel='stylesheet' type='text/css' href='../css/fixed.css'>
<link rel='stylesheet' type='text/css' href='../css/mtView.css'>

<!-- 제이쿼리 로컬 -->
<script src='../js/lib/jquery-1.12.4.min.js'></script>
<script src='../js/lib/jquery.easing.1.3.js'></script>
<script src='../js/lib/jquery.touchSwipe.js'></script>

<!-- 브라우저별 접두사 쓸 필요 없음 -->
<script src='../js/lib/prefixfree.min.js'></script>

<!-- 아이콘 -->
<link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">

<!-- 로그인 세션 -->
<script>
var userId = "${sessionScope.userId}"; // 세션에서 현재 로그인한 사용자의 아이디를 가져옴
if (userId) {
    // 로그인한 사용자의 아이디를 사용할 수 있습니다.
    console.log("현재 로그인한 사용자 아이디: " + userId);
} else {
    // 로그인하지 않은 경우의 처리
    console.log("로그인되지 않은 상태");
}
</script>


<!-- 작성자만 수정, 삭제  -->
<script>
//삭제하기
function deletePost(mt_id) {
    var userId = "${sessionScope.userId}"; // 세션에서 현재 사용자 ID 가져오기

    if (!userId) {
        // 사용자가 로그인하지 않았을 경우
        alert("로그인 후 사용할 수 있습니다.");
        window.location.href = "/login";
        return;
    }

    // 현재 사용자가 작성자인지 확인
    if (userId !== "${mateDTO.user_id}") {
        alert("작성자 전용 기능입니다.");
        window.location.href = "/mateList";
        return;
    }

    var confirmed = confirm("정말로 삭제하겠습니까?");
    if (confirmed) {
        var form = document.forms['writeFrm'];
        if (form) {
            var hiddenInput = document.createElement("input");
            hiddenInput.type = "hidden";
            hiddenInput.name = "mt_id";
            hiddenInput.value = mt_id;
            form.appendChild(hiddenInput);

            form.method = "post";
            form.action = "delete";
            form.submit();
        } else {
            console.error("Form with name 'writeFrm' not found.");
        }
    } else {
        console.log("삭제를 취소했습니다.");
    }
}

function checkLoginAndRedirect(destination) {
	// 세션에서 userId 가져오기
	var userId = "${sessionScope.userId}";
	console.log(userId);
	if (userId === undefined || userId === null || userId.trim() === "") {
		// 로그인이 되어 있지 않은 경우
		alert("로그인 후 사용할 수 있습니다.");
		window.location.href = "/login";
	}
	else if(userId!="${mateDTO.user_id}"){
    	alert("작성자 전용 기능입니다.");
       	window.location.href = "/mateList";
    }
	else {
		// 로그인이 된 경우 지정된 페이지로 이동
		window.location.href = destination;
	}
}
</script>





<!-- 댓글 리스트 불러오기 -->
<script>
//페이지 로드 시 댓글을 가져와서 화면에 출력하는 함수
function loadComments(pageNum) {
    $.ajax({  
		contentType: "text/html;charset:utf-8", 
		dataType: "json",
        url: '/mtCommentList',  // 댓글을 가져올 URL
        method: 'GET',
        data: { pageNum: pageNum },  // 페이지 번호를 서버에 전달
        success: function (data) {
        	// 가져온 댓글 데이터를 사용하여 동적으로 댓글을 생성
            $('#commentList').empty(); // 기존 댓글 목록 비우기
            // 가져온 댓글 데이터를 사용하여 동적으로 댓글을 생성
            for (var i = 0; i < data.lists.length; i++) {
                var comment = data.lists[i];
                
                var buttons = '';
                var userId = "${sessionScope.userId}"; // 세션에서 현재 로그인한 사용자의 아이디를 가져옴
                if (userId && userId === comment.user_id) {
                	buttons = '<div class="btn_wrap">' +
                        '<a href="" class="mtcomEditBtn" data-edit-id="'+comment.mtcom_id+'">수정</a>' +
                        '<a href="" class="mtcomDeleteBtn" data-comment-id="'+comment.mtcom_id+'">삭제</a>' +
                        '</div>';
                }
                
                var commentItem = '<li id="mtcomList'+comment.mtcom_id+'">' +
                	'<input type="hidden" id="mtcomId" name="mtcom_id" value="'+comment.mtcom_id+'" />' +
                	'<div class="row commentBox commentBox'+comment.mtcom_id+'">' +
					'<div class="col-lg-2 comImg_wrap">' +
					'<img src="../img/'+comment.user_image+'" alt="">' +
					'</div>' +
					'<div class="col-lg-10 comText_wrap">' +
					'<div class="user_wrap">' +
					'<span>'+comment.user_name+'</span>' +
					'<span>'+comment.mtcom_postdate+'</span>' +
					'</div>' +
					'<div class="content_wrap">' +
					'<p>'+comment.mtcom_content+'</p>' +
					'</div>' +
					'</div>' +
					buttons +
					'</div>' +
					'</li>';
					
                $('#commentList').append(commentItem);
            }
            $('.srtotalCount').html(data.totalCount);
            $('.paging_wrap').html(data.pagingImg);
            
        },
        error: function () {
            console.error('댓글 불러오기 실패');
        }
    });
}
</script>

<!-- 페이지 번호를 추출하는 함수 -->
<script>
function getPageNumFromUrl(url) {
    var match = url.match(/pageNum=(\d+)/);
    return match ? parseInt(match[1], 10) : 1;
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
						<div class="container1440"></div>
					</div>
				</div>
			</section>
			<section id="section2">
				<div class="wrap1440">
					<div class="gap1440">
						<div class="container1440">
							<form name="writeFrm">
								<input type="hidden" name="mt_id" value="${mateDTO.mt_id }" />
							<div class="view_content">
								<div>
									<span class="status"><i>${mateDTO.mt_status }</i></span>
									<h2>${mateDTO.mt_title}</h2>
									<ul>
										<li>
											<div>
												<span>관람 예정일</span> <i>${mateDTO.mt_viewdate}</i>
											</div>
										</li>
										<li>
											<div>
												<span>메이트 성별</span> <i>${mateDTO.mt_gender}</i>
											</div>
										</li>
										<li>
											<div>
												<span>메이트 나이</span> <i>${mateDTO.mt_age1}~${mateDTO.mt_age2}</i>
											</div>
										</li>
									</ul>
									<div class="longContent">
										<p>${mateDTO.mt_content}</p>
									</div>
									<div class="memInfo_wrap">
										<div class="profileImg_wrap">
											<img src="../img/${mateDTO.user_image}" alt="">
										</div>
										<div class="profileInfo_wrap">
											<h4>${mateDTO.user_name}</h4>
											<span>작성일<i>${mateDTO.mt_postdate}</i></span> <span>조회수<i>${mateDTO.mt_visitcount}</i></span>
										</div>
										<div class="bmBtn_wrap">
											<a href="javascript:;" class="bmBtn">저장하기</a>
										</div>
									</div> 
								</div>
							</div>
							</form>
							<div class="viewBtn_wrap">
								<a href="#" class="btn btn-light" onclick="deletePost(${mateDTO.mt_id});">삭제하기</a>
								<%-- <a href="/mateEdit?mt_id=${mateDTO.mt_id}" class="btn btn-secondary">수정하기  --%>
								<a href="javascript:void(0);" onclick="checkLoginAndRedirect('/mateEdit?mt_id=${ param.mt_id }')" class="btn btn-secondary">수정하기</a>
								<a href="/mateList" class="btn btn-dark">모집등록</a>
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
									<h1>
										<i>5</i>개의 댓글을 확인해보세요!
									</h1>
								</div>
								<div class="comment_content">
									<ul class="comList_wrap">
										<li>
											<div class="row commentBox">
												<div class="col-lg-2 comImg_wrap">
													<img src="../img/${mateDTO.user_image}" alt="">
												</div>
												<div class="col-lg-9 comWrite_wrap">
													<div class="user_wrap">
														<span>${mateDTO.user_name}</span>
													</div>
													<div class="content_wrap">
														<textarea name="" id="" cols="30" rows="2"
															placeholder="댓글을 남겨주세요."></textarea>
													</div>
												</div>
												<div class="col-lg-1 commentBtn_wrap">
													<button type="button" class="btn btn-dark">등록</button>
												</div>
											</div>
										</li>
										<div id="mtCommentList">
										<!-- 한줄평 목록 출력 부분 -->
										</div>
										<li>
											<div class="row commentBox">
												<div class="col-lg-2 comImg_wrap">
													<img src="../img/profile.png" alt="">
												</div>
												<div class="col-lg-10 comText_wrap">
													<div class="user_wrap">
														<span>닉네임</span>
													</div>
													<div class="content_wrap">
														댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용<br> 댓글 내용댓글
														내용댓글 내용댓글 내용댓글 내용댓글 내용<br>
													</div>
													
												</div>
												<div class="btn_wrap">
													<a href="">수정</a> <a href="">삭제</a>
												</div>
											</div>
										</li>
									</ul>

								</div>
							</div>

						</div>
					</div>
				</div>
			</section>

		</main>

		<%@ include file="/footer.jsp"%>

		<!-- GoTop 버튼 -->
		<span class='goTop'> <a href='#wrap' class='smoothBtn goTopBtn'><i
				class='fas fa-angle-up'><span class='blind'>goTop</span></i></a>
		</span>

		<!-- 커스텀 JS -->
		<script src='../js/fixed.js'></script>
		<!-- <script src='../js/'></script> -->

	</div>
</body>
</html>
