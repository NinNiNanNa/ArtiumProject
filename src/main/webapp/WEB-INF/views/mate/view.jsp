_<%@ page language="java" contentType="text/html; charset=UTF-8"
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
window.onload = function(){
	// 페이지 로드 시 댓글 가져와서 출력
	loadMt_Comment(1);
	
}

//댓글 글자 길이 카운트 및 엔터 키 이벤트
document.addEventListener('DOMContentLoaded', function () {
    var mtcomContent = document.getElementById('mtcomContent');
    var textCnts = document.getElementById('textCnts');

    mtcomContent.addEventListener('keydown', function (e) {
        // 엔터 키가 눌렸을 때
        if (e.keyCode === 13) {
        	// 기본 동작인 줄바꿈 막음
        	e.preventDefault();
            // 댓글 작성 함수 호출
            postComment();
        }
    });
    mtcomContent.addEventListener('keyup', function () {
        // 입력된 텍스트의 길이를 #textCnts에 표시
        textCnts.innerHTML = "(" + mtcomContent.value.length + " / 150)";

        // 만약 입력된 텍스트의 길이가 150을 초과하면
        if (mtcomContent.value.length > 150) {
        	// 입력된 텍스트를 150자까지만 자르고 다시 #cmContent에 설정
          mtcomContent.value = mtcomContent.value.substring(0, 150);
         // #textCnts에 (15 / 150)으로 표시
         textCnts.innerHTML = "(150 / 150)";
        }
    });
});


//페이지 로드 시 댓글을 가져와서 화면에 출력하는 함수
function loadMt_Comment(pageNum) {
	var mt_id = ${param.mt_id};
	console.log(mt_id + "mt_id값이다.");
	
    $.ajax({  
		contentType: "text/html;charset:utf-8", 
		dataType: "json",
        url: '/mateCommentList.api',  // 댓글을 가져올 URL
        method: 'GET',
        data: { pageNum: pageNum, mt_id: mt_id },  // 페이지 번호를 서버에 전달
        success: function (data) {
        	// 가져온 댓글 데이터를 사용하여 동적으로 댓글을 생성
            $('#listMateComment').empty(); // 기존 댓글 목록 비우기
            // 가져온 댓글 데이터를 사용하여 동적으로 댓글을 생성
            for (var i = 0; i < data.lists.length; i++) {
                var mt_comment = data.lists[i];
                
                var buttons = '';
                var userId = "${sessionScope.userId}"; // 세션에서 현재 로그인한 사용자의 아이디를 가져옴
                if (userId && userId === mt_comment.user_id) {
                	buttons = '<div class="btn_wrap">' +
                        '<a href="" class="mtcomEditBtn" data-edit-id="'+mt_comment.mtcom_id+'">수정</a>' +
                        '<a href="" class="mtcomDeleteBtn" data-comment-id="'+mt_comment.mtcom_id+'">삭제</a>' +
                        '</div>';
                }
                
                var commentItem = '<li id="mtcomList'+mt_comment.mtcom_id+'">' +
                	'<input type="hidden" id="mtcomId" name="mtcom_id" value="'+mt_comment.mtcom_id+'" />' +
                	'<div class="row commentBox commentBox'+mt_comment.mtcom_id+'">' +
					'<div class="col-lg-2 comImg_wrap">' +
					'<img src="../img/'+mt_comment.user_image+'" alt="">' +
					'</div>' +
					'<div class="col-lg-10 comText_wrap">' +
					'<div class="user_wrap">' +
					'<span>'+mt_comment.user_name+'</span>' +
					'<span>'+mt_comment.mtcom_postdate+'</span>' +
					'</div>' +
					'<div class="content_wrap">' +
					'<p>'+mt_comment.mtcom_content+'</p>' +
					'</div>' +
					'</div>' +
					buttons +
					'</div>' +
					'</li>';
					
                $('#listMateComment').append(commentItem);
            }
            $('.mtcomtotalCount').html(data.totalCount);
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
  loadMt_Comment(pageNum);
});
</script>

<!-- 페이지 번호를 추출하는 함수 -->
<script>
function getPageNumFromUrl(url) {
    var match = url.match(/pageNum=(\d+)/);
    return match ? parseInt(match[1], 10) : 1;
}


//로그인 후 댓글 작성 가능
function postComment() {
	
	var userId = "${sessionScope.userId}";
	var mtcomContent = document.getElementById('mtcomContent').value;

	if (userId === undefined || userId === null || userId.trim() === "") {
		alert("로그인이 필요한 서비스입니다.");
	} else {
		if (!mtcomContent) {
            alert("댓글을 작성해주세요.");
            return;
        }
		
		var MtCommentDTO = {
            mt_id: "${mateDTO.mt_id}",
            user_id: userId,
            mtcom_content: mtcomContent
        };
		console.log(MtCommentDTO);
		
		// 댓글 작성
		$.ajax({
		    type: "POST",
		    contentType: "application/json;",
		    url: "/mateCommentWrite.api",
		    data: JSON.stringify(MtCommentDTO), // galleryCommentDTO를 JSON 문자열로 변환하여 전송
		    success: function(response) {
		        // 서버로부터의 응답을 처리
		        console.log(response);

		        if (response.result === 1) {	// 리뷰 작성 성공
		            alert("댓글 작성에 성공하였습니다.");
		         	// 성공적인 댓글 제출 후 댓글을 업데이트하기 위해 loadComments() 함수 호출
                    loadMt_Comment();
                 	// 폼 초기화
                    document.getElementById('mtcomContent').value = "";
		        } else {	// 리뷰 작성 실패
		            alert("댓글 작성에 실패하였습니다.");
		        }
		    },
		    error: function(error) {
		        // 에러 처리
		        console.log(error);
		    }
		});
	}
}


//댓글 수정하기
$(document).on('click', 'a.mtcomEditBtn', function(e) {
    e.preventDefault();
    
 	// data-edit-id 속성 값 가져오기
    var editId = $(this).data('edit-id');
 		console.log("수정폼에들어옴?: "+editId);
 	
    // 수정할 댓글의 내용 가져옴
    var mtcomEditContent = $(this).closest('.commentBox').find('.content_wrap p').text();

    // 동적으로 수정 폼 생성
    var editForm = $('<li id="editCommentForm" data-edit-id="'+editId+'">' +
        '<div class="row commentBox">' +
        '<div class="col-lg-2 comImg_wrap">' +
        '<img src="../img/${userImg }" alt="">' +
        '</div>' +
        '<div class="col-lg-9 comWrite_wrap">' +
        '<div class="user_wrap">' +
        '<span>${userName }</span>' +
        '</div>' +
        '<div class="content_wrap">' +
        '<div class="row starAndtextcnt">' +
        '<div class="col-lg-6 star_wrap">' +
        '</div>' +
        '<div id="textEditCnt" class="col-lg-6">(0/150)</div>' +
        '</div>' +
        '<textarea name="mtcom_content" id="mtcomEditContent" cols="30" rows="1" placeholder="댓글을 남겨주세요.">' + mtcomEditContent + '</textarea>' +
        '</div>' +
        '</div>' +
        '<div class="col-lg-1 commentBtn_wrap">' +
        '<button type="button" id="mtcomUpdateBtn" class="btn btn-dark" data-edit-id="'+editId+'">수정</button>' +
        '</div>' +
        '</div>' +
        '</li>');

 		// 수정 폼을 이전에 있던 댓글 밑에 추가
    $(this).closest('.commentBox').after(editForm);
    // 기존 댓글은 숨기기
    $(this).closest('.commentBox').hide();
 	
    // 수정 폼 내의 textarea에 입력된 텍스트의 길이를 초기 설정
    $('#textEditCnt').html('(' + mtcomEditContent.length + ' / 150)');
    
 		// 수정 폼 내에서 텍스트 입력 시 글자 수 카운트 및 제한
    $(document).on('keyup', '#mtcomEditContent', function() {
        // 입력된 텍스트의 길이를 가져와서 #textEditCnt에 표시
        var editedContentLength = $(this).val().length;
        $('#textEditCnt').html('(' + editedContentLength + ' / 150)');

        // 만약 입력된 텍스트의 길이가 150을 초과하면
        if (editedContentLength > 150) {
            // 입력된 텍스트를 150자까지만 자르고 다시 #cmEditContent에 설정
            $(this).val($(this).val().substring(0, 60));
            // #textEditCnt에 (150 / 150)으로 표시
            $('#textEditCnt').html('(150 / 150)');
        }
    });
});

//수정한 내용을 업데이트할 시 이벤트 처리
$(document).on('click', 'button#mtcomUpdateBtn', function (e) {
    e.preventDefault();

    // 수정할 댓글의 내용 가져옴
    var editedId = $(this).data('edit-id');
    var editedContent = $('#editCommentForm textarea').val();
    
    /* var galleryCommentDTO = {
            ga_id: "${galleryDTO.ga_id}",
        };
		console.log(galleryCommentDTO); */
    
		console.log("수정값들어오냐?!: "+editedId);
		console.log("수정값들어오냐?!: "+editedContent);    
    
    // 수정한 내용을 서버에 전송
    $.ajax({
        type: 'POST',
        contentType: "application/json",
        url: '/mateCommentEdit.api',
        data: JSON.stringify({
        		mt_id: "${mateDTO.mt_id}", // ga_id값 null로 입력해줌
            mtcom_id: editedId,
            mtcom_content: editedContent
        }),
        success: function (response) {
            if (response.result === 1) {
                // 서버에서 수정이 성공하면 화면에 수정된 내용을 갱신
                var commentBox = $('.commentBox'+editedId);
                
                commentBox.find('.content_wrap p').text(editedContent);

                // 수정 폼을 제거하고, 기존 댓글을 다시 보이게 함
                $('#editCommentForm').remove();
                commentBox.show();
                // 수정이 실패한 경우에 대한 처리
                alert('댓글 수정이 완료되었습니다.');
            } else {
                // 수정이 실패한 경우에 대한 처리
                alert('댓글 수정에 실패했습니다.');
            }
        },
        error: function () {
            // 통신 오류 등에 대한 처리
            alert('댓글 수정 중 오류가 발생했습니다.');
        }
    });
});

// 메이트 댓글 삭제
function deleteComment(mtcomId) {
    $.ajax({
        type: "POST",
        url: "/mateCommentDelete.api",
        data: { mtcom_id: mtcomId },
        success: function(response) {
            if (response.result === 1) {	// 댓글 삭제 성공
                alert("댓글이 삭제되었습니다.");
                // 삭제 후 댓글 목록을 업데이트하는 함수 호출
                loadMt_Comment();
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
$(document).on('click', 'a.mtcomDeleteBtn', function(e) {
    e.preventDefault();

    var mtcomId = $(this).data('comment-id');
    
 	// 확인 창 띄우기
    var isConfirmed = confirm('댓글을 삭제하시겠습니까?');
 	
 	// 확인이 눌렸을 경우에만 삭제 요청
    if (isConfirmed) {
        // 서버로 삭제 요청을 보냄
        deleteComment(mtcomId);
    }
    
});

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
							<form name="writeFrm" action="/mateList" method="post">
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
										<i class="mtcomtotalCount"></i>개의 댓글을 확인해보세요!
									</h1>
								</div>
								<div class="comment_content">
									<ul class="comList_wrap">
									<form method="post" action="mateCommentwWrite.api"  id="mateCommentviewForm">
										<li>
											<div class="row commentBox">
											<c:choose>
												<c:when test="${not empty userId }">
												<div class="col-lg-2 comImg_wrap">
													<!-- 수정필요 -->
													<img src="../img/${userImg }" alt="">
												</div>
												<div class="col-lg-9 comWrite_wrap">
													<div class="user_wrap">
														<span>${sessionScope.userName}</span>
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
																				<textarea name="mtcom_content" id="mtcomContent" cols="30" rows="2" placeholder="댓글을 남겨주세요."></textarea>
																			</div>
																		</div>
																		<div class="col-lg-1 commentBtn_wrap">
																			<button type="button" class="btn btn-dark" id="mtcomCntBtn" onclick="postComment()">등록</button>
																		</div>
											</div>
										</li>
										</form>
										<li>
										<div id="listMateComment">
										<!-- 메이트 댓글 목록 출력 부분 -->
										</div>
										</li>
											</ul>
                            </div>
                            <div class="paging_wrap">
                            	<!-- 메이트 댓글 페이지네이션 출력 부분 -->
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