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
	<link rel='stylesheet' type='text/css' href='../css/exList.css'>
	
	<!-- 제이쿼리 로컬 -->
	<script src='../js/lib/jquery-1.12.4.min.js'></script>
	<script src='../js/lib/jquery.easing.1.3.js'></script>
	<script src='../js/lib/jquery.touchSwipe.js'></script>

	<!-- 브라우저별 접두사 쓸 필요 없음 -->
	<script src='../js/lib/prefixfree.min.js'></script>

	<!-- 아이콘 -->
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

<script>
$(document).ready(function() {
    var currentUrl = window.location.href;

    function handleExhibitionButtonClick(status) {
        $(".nav-link").removeClass("active");
        $("#" + status + "Btn").addClass("active");
    }

    if (currentUrl.includes("/exhibitionCurrentList")) {
        handleExhibitionButtonClick("current");
    } else if (currentUrl.includes("/exhibitionFutureList")) {
        handleExhibitionButtonClick("future");
    } else if (currentUrl.includes("/exhibitionPastList")) {
        handleExhibitionButtonClick("past");
    }
    
});

window.onload = function () {
    // 페이지 로드 시 북마크 표시하기
    loadBookmark();
}

function loadBookmark() {
    var userId = "${sessionScope.userId}";
    // 북마크 표시하기
    $.ajax({
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        url: '/bookmarkList.api',
        method: 'GET',
        data: {
            user_id: userId,
            post_type: "ex"
        },
        success: function (data) {
            $.each(data.bmlists, function (index, item) {
                var bookmarkedButton = $(".bookMarkBtn[data-exseq-id='" + item.post_id + "']");
                if (bookmarkedButton.length > 0) {
                    // 북마크가 되어 있는 경우
                    bookmarkedButton.attr('data-bm-id', item.bm_id);
                    bookmarkedButton.find("i.far").css({ 'opacity': 0 });
                    bookmarkedButton.find("i.fas").css({ 'opacity': 1 });
                }
            });
        },
        error: function () {
            console.error('북마크 작동 실패');
        }
    });
}

$(document).on('click', '.bookMarkBtn', function (e) {
    // 북마크가 이미 되어 있는지 여부 확인
    var isBookmarked = $(this).find("i.fas").css('opacity') === '0';
    var clickedButton = this;

    if (isBookmarked) {
        // 북마크가 되어 있지 않은 경우 -> 추가 요청
        var userId = "${sessionScope.userId}";
        var exSeq = $(clickedButton).data('exseq-id');
        $.ajax({
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            url: '/bookmarkAdd.api',
            method: 'POST',
            data: JSON.stringify({
                user_id: userId,
                post_id: exSeq,
                post_type: "ex"
            }),
            success: function (data) {
                console.log(data);
                console.log("(성공)아이디가져옴: " + userId);
                console.log("(성공)일련번호가져옴: " + exSeq);
                if (data.result === 1) {
                    loadBookmark();

                    // 추가 요청이 성공한 경우에만 삭제 요청을 보냄
                    var bmId = data.bm_id;
                    sendRemoveRequest(clickedButton, bmId);
                } else {
                    // 추가 실패 시
                    console.error('북마크 추가 실패');
                }
            },
            error: function () {
                console.error('북마크 작동 실패');
                console.log("(실패)아이디가져옴: " + userId);
                console.log("(실패)일련번호가져옴: " + exSeq);
            }
        });

    } else {
        // 북마크가 되어 있는 경우 -> 삭제 요청
        var bmId = $(clickedButton).data('bm-id');
        sendRemoveRequest(clickedButton, bmId);
    }
});

function sendRemoveRequest(clickedButton, bmId) {
    $.ajax({
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        url: '/bookmarkRemove.api',
        method: 'POST',
        data: JSON.stringify({
            bm_id: bmId // 클릭한 버튼의 bm_id 전송
        }),
        success: function (data) {
            if (data.result === 1) {
                // 삭제 성공 시
                $(clickedButton).find("i.far").css({ 'opacity': 1 });
                $(clickedButton).find("i.fas").css({ 'opacity': 0 });
            } else {
                // 삭제 실패 시
                console.error('북마크 삭제 실패');
            }
        },
        error: function () {
            console.error('북마크 작동 실패');
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
							<h2>EXHIBITION</h2>
							<p>다양한 전시회를 찾아보세요.</p>
						</div>

					</div>
				</div>
			</div>
		</section>

		<section id="section2">
			<div class="wrap1440">
				<div class="gap1440">
					<div class="container1440">

						<div class='content'>

							<!-- Content Row -->
							<div class="row">
								<ul class="nav nav-pills mb-4" style="justify-content: center; font-size: 17px; ">
									<li class="nav-item">
										<a id="currentBtn" class="nav-link tabColor" href="/exhibitionCurrentList">현재전시</a>
									</li>
									<li class="nav-item">
										<a id="futureBtn" class="nav-link tabColor" href="/exhibitionFutureList">예정전시</a>
									</li>
									<li class="nav-item">
										<a id="pastBtn" class="nav-link tabColor" href="/exhibitionPastList">만료전시</a>
									</li>
								</ul>
								
								<form method="get">
								<div class="search_wrap clearfix">
									<div class="searchField_wrap">
										<select class="form-select" name="searchField">
											<option value="ex_title">제목</option>
											<option value="ex_place">전시관</option>
										</select>
									</div>
									<div class="searchWord_wrap">
										<input type="text" class="form-control" name="searchKeyword" placeholder="제목 또는 전시관을 입력하세요.">
										<button type="submit" class="btn btn-dark searchBtn"><i class="fas fa-search"></i></button>
									</div>
								</div>
								</form>

								<div class="col">

									<div class="tab-content" style="padding-top:30px;">
										<div id="current">

											<ul class="list_wrap row">
												<c:forEach items="${lists }" var="row" varStatus="loop">
												<li class="col-lg-3">
													<div class="listInfo">
														<div class="image_wrap">
															<img src="${row.ex_imgURL }" alt="">
													<c:choose>
														<c:when test="${not empty userId }">
															<div class="listBtn_wrap">
																<a href="javascript:;" class="bookMarkBtn" data-exseq-id="${row.ex_seq }">
																	<i class="fas fa-bookmark" style="opacity: 0;"></i>
																	<i class="far fa-bookmark" style="opacity: 1;"></i>
																</a>
															</div>
														</c:when>
														<c:otherwise>
														
														</c:otherwise>
													</c:choose>
														</div>
														<div class="title_wrap">
															<div>
																<a href="/exhibitionView?ex_seq=${row.ex_seq }" class="txtSkip">${row.ex_title }</a>
																<h6 class="txtSkip">${row.ex_place }</h6>
																<h5>${row.ex_sDate } ~ ${row.ex_eDate }</h5>
																<ul class="info_wrap">
																	<li>
																		<span>조회수 <i>${row.ex_visitCount }</i></span>
																	</li>
																	<li>
																		<span>북마크 <i>${row.ex_bmCount }</i></span>
																	</li>
																</ul>
															</div>
														</div>
													</div>
												</li>
												</c:forEach>
											</ul>
											<div class="paging_wrap">
												${ pagingImg }
											</div>

										</div>

									</div>
								</div>

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