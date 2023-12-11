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
	<link rel='stylesheet' type='text/css' href='../css/exView.css'>
	
	<!-- 제이쿼리 로컬 -->
	<script src='../js/lib/jquery-1.12.4.min.js'></script>
	<script src='../js/lib/jquery.easing.1.3.js'></script>
	<script src='../js/lib/jquery.touchSwipe.js'></script>

	<!-- 브라우저별 접두사 쓸 필요 없음 -->
	<script src='../js/lib/prefixfree.min.js'></script>

	<!-- 아이콘 -->
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    
<script>
//구글맵 초기화 및 마커설정 
function initMap() {
	var latitude = parseFloat(document.getElementById('latitude').value);
	var longitude = parseFloat(document.getElementById('longitude').value);
	//console.log(latitude, longitude);
	//맵의 중심 위치 설정 
	var uluru = {lat:latitude, lng:longitude};
	//구글맵 초기화(맵 출력을 위한 DOM과 줌레벨 설정) 
	var map = new google.maps.Map(document.getElementById('map'), {
		zoom: 17,
		center: uluru
	});
	//마커설정 
	var marker = new google.maps.Marker({
		position: uluru,
		map: map
	});
}
window.onload = function(){
	initMap();
	// 페이지 로드 시 댓글을 가져와서 출력
	loadComments();
}

//댓글 글자길이 카운트 이벤트
document.addEventListener('DOMContentLoaded', function () {
	var srvContent = document.getElementById('srvContent');
	var textCnt = document.getElementById('textCnt');
	
	srvContent.addEventListener('keyup', function () {
	    // 입력된 텍스트의 길이를 가져와서 #textCnt에 표시
	    textCnt.innerHTML = "(" + srvContent.value.length + " / 60)";
	
	    // 만약 입력된 텍스트의 길이가 60을 초과하면
	    if (srvContent.value.length > 60) {
	        // 입력된 텍스트를 60자까지만 자르고 다시 #srvContent에 설정
	        srvContent.value = srvContent.value.substring(0, 60);
	        // #textCnt에 "(60 / 60)"으로 표시
	        textCnt.innerHTML = "(60 / 60)";
	    }
	});
});

//페이지 로드 시 댓글을 가져와서 화면에 출력하는 함수
function loadComments() {
    $.ajax({  
		contentType : "text/html;charset:utf-8", 
		dataType : "json",
        url: '/exhibitionReviewList.api',  // 댓글을 가져올 URL
        method: 'GET',
        success: function (data) {
            // 가져온 댓글 데이터를 사용하여 동적으로 댓글을 생성
            for (var i = 0; i < data.lists.length; i++) {
                var review = data.lists[i];
                var starRating = '';
                for (var j = 0; j < review.srv_star; j++) {
                    starRating += '<span class="star">⭐</span>';
                }
                
                var buttons = '';
                var userId = "${sessionScope.userId}"; // 세션에서 현재 로그인한 사용자의 아이디를 가져옴
                if (userId && userId === review.user_id) {
                	buttons = '<div class="btn_wrap">' +
                        '<a href="">수정</a>' +
                        '<a href="">삭제</a>' +
                        '</div>';
                }
                
                var commentItem = '<li>' +
                		'<div class="row commentBox">' +
							'<div class="col-lg-2 comImg_wrap">' +
								'<img src="../img/'+review.user_image+'" alt="">' +
							'</div>' +
							'<div class="col-lg-10 comText_wrap">' +
								'<div class="user_wrap">' +
									'<span>'+review.user_name+'</span>' +
									'<span>'+review.srv_postdate+'</span>' +
								'</div>' +
								'<div class="content_wrap">' +
									starRating +
									'<p>'+review.srv_content+'</p>' +
								'</div>' +
							'</div>' +
							buttons +
						'</div>' +
					'</li>';
                $('#simpleReviewList').append(commentItem);
            }
            $('.srtotalCount').html(data.totalCount);
            $('.paging_wrap').html(data.pagingImg);
            
            registerPagingLinkClickHandler();
        },
        error: function () {
            console.error('Failed to load comments.');
        }
    });
}

// 페이지 버튼에 대한 클릭 이벤트 핸들러 등록하는 함수
function registerPagingLinkClickHandler() {
	$(document).on('click', '.paging_wrap a', function(e) {
	 e.preventDefault();  // 기본 동작(새로고침) 방지
	
	 // 선택한 페이지 번호 가져오기
	 var pageNum = $(this).data('page-num');
	
	 // 페이지 번호에 따라 댓글을 새로 불러옴
	 loadComments(pageNum);
	});
}

function checkUserId() {
	var userId = "${sessionScope.userId}";
	var selectedStar = document.querySelector('input[name="srv_star"]:checked');
	var srvContent = document.getElementById('srvContent').value;
	
	if (userId === undefined || userId === null || userId.trim() === "") {
		alert("로그인이 필요한 서비스입니다.");
	} else {
		//alert(userId+" 접속 확인");
		if ( !selectedStar ) {
			alert("별점을 선택해주세요.");
            return;
		} 

		if (!srvContent) {
            alert("댓글을 작성해주세요.");
            return;
        }
		alert("리뷰가 등록되었습니다.");
		$("#exhibitionReviewForm").submit();
	}
}

</script>
</head>
<body>
<div id='wrap'>

	<input type="hidden" id="longitude" name="ex_gpsX" value="${exhibitionDTO.ex_gpsX }" />
	<input type="hidden" id="latitude" name="ex_gpsY" value="${exhibitionDTO.ex_gpsY }" />
	
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
						
						<div class="content row">
							<div class="col-lg-5 img_wrap">
								<img src="${exhibitionDTO.ex_imgURL }" alt="">
							</div>
							<div class="col-lg-7 exinfo_wrap">
								<ul>
									<li class="row">
										<h4 class="col-12">${exhibitionDTO.ex_title }</h4>
									</li>
									<li class="row">
										<h6 class="col-2">기간</h6>
										<h5 class="col-10">${exhibitionDTO.ex_sDate } - ${exhibitionDTO.ex_eDate }</h5>
									</li>
									<li class="row">
										<h6 class="col-2">장소</h6>
										<h5 class="col-10">${exhibitionDTO.ex_place }</h5>
									</li>
									<li class="row">
										<h6 class="col-2">관람료</h6>
										<h5 class="col-10">${exhibitionDTO.ex_price }</h5>
									</li>
									<li class="row">
										<h6 class="col-2">내용</h6>
										<p class="col-10">
											${exhibitionDTO.ex_content }
										</p>
									</li>
								</ul>
								<div class="btn_wrap">
									<a href="#"><i class="far fa-heart"></i></a>
									<a href="#"><i class="fas fa-share-alt"></i></a>
									<button class="" data-bs-toggle="modal" data-bs-target="#modal1">예매하기</button>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</section>

		<section id="section2">
			<div class="wrap1440">
				<div class="gap1440">
					<div class="container1440">

						<!-- Content Row -->
						<div class="row">
							<div class="col">
								<ul class="nav nav-pills mb-4" role="tablist">
									<li class="nav-item">
										<a class="nav-link active tabColor" data-bs-toggle="pill"
											href="#location">위치정보</a>
									</li>
									<li class="nav-item">
										<a class="nav-link tabColor" data-bs-toggle="pill"
											href="#simple">한줄평가</a>
									</li>
								</ul>

								<div class="tab-content">
									<div id="location" class="tab-pane active">

										<div class="row content">
											<div class="col-lg-6 locInfo_wrap locInfo_wrap1">
												<div class="row">
													<h4 class="col-3">전시장명</h4>
													<p class="col-9">${exhibitionDTO.ex_place }</p>
												</div>
												<div class="row">
													<h4 class="col-3">지역</h4>
													<p class="col-9">${exhibitionDTO.ex_area }</p>
												</div>
												<div class="row">
													<h4 class="col-3">주소</h4>
													<p class="col-9">${exhibitionDTO.ex_place }</p>
												</div>
											</div>
											<div class="col-lg-6 locInfo_wrap locInfo_wrap2">
												<div class="row">
													<h4 class="col-3">전화번호</h4>
													<p class="col-9">${exhibitionDTO.ex_phone }</p>
												</div>
												<div class="row">
													<h4 class="col-3">홈페이지</h4>
													<p class="col-9"><a href="${exhibitionDTO.ex_webURL }">${exhibitionDTO.ex_webURL }</a></p>
												</div>
											</div>
											<div class="col-lg-12 map_wrap">
												<div id="map"></div>
												<script async defer src="https://maps.googleapis.com/maps/api/js?key=${apiKey }"></script>
											</div>
										</div>

									</div>
									
									<div id="simple" class="tab-pane fade">
										<div class="comment_wrap">
				                            <div class="comment_title">
				                                <h1><i class="srtotalCount"></i>개의 댓글을 확인해보세요!</h1>
				                            </div>
				                            <div class="comment_content">
												<ul class="comList_wrap">
													<form method="post" action="exhibitionReviewWrite.api" id="exhibitionReviewForm">
													<input type="hidden" name="ex_seq" value="${exhibitionDTO.ex_seq }" />
													<li>
														<div class="row commentBox">
													<c:choose>
														<c:when test="${not empty userId }">
															<div class="col-lg-2 comImg_wrap">
																<img src="../img/${userImg }" alt="">
															</div>
															<div class="col-lg-9 comWrite_wrap">
																<div class="user_wrap">
																	<div class="user_wrap">
																		<span>${userName }</span>
																	</div>
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
																	<div class="row starAndtextcnt">
																		<div class="col-lg-6 star_wrap">
																			<fieldset>
																				<input type="radio" name="srv_star" value="5" id="rate1"><label for="rate1">⭐</label>
																				<input type="radio" name="srv_star" value="4" id="rate2"><label for="rate2">⭐</label>
																				<input type="radio" name="srv_star" value="3" id="rate3"><label for="rate3">⭐</label>
																				<input type="radio" name="srv_star" value="2" id="rate4"><label for="rate4">⭐</label>
																				<input type="radio" name="srv_star" value="1" id="rate5"><label for="rate5">⭐</label>
																			</fieldset>
																		</div>
																		<div id="textCnt" class="col-lg-6">(0/60)</div>
																	</div>
																	<textarea name="srv_content" id="srvContent" cols="30" rows="1" placeholder="댓글을 남겨주세요."></textarea>
																</div>
															</div>
															<div class="col-lg-1 commentBtn_wrap">
																<button type="button" id="srvSendBtn" class="btn btn-dark" onclick="checkUserId()">등록</button>
															</div>
														</div>
													</li>
													</form>
													<form method="post" action="exhibitionReviewWrite.api" id="exhibitionReviewForm">
													<input type="hidden" name="ex_seq" value="${exhibitionDTO.ex_seq }" />
													<li>
														<div class="row commentBox">
															<div class="col-lg-2 comImg_wrap">
																<img src="../img/${userImg }" alt="">
															</div>
															<div class="col-lg-9 comWrite_wrap">
																<div class="user_wrap">
																	<div class="user_wrap">
																		<span>${userName }</span>
																	</div>
																</div>
																<div class="content_wrap">
																	<div class="row starAndtextcnt">
																		<div class="col-lg-6 star_wrap">
																			<fieldset>
																				<input type="radio" name="srv_star" value="5" id="rate1"><label for="rate1">⭐</label>
																				<input type="radio" name="srv_star" value="4" id="rate2"><label for="rate2">⭐</label>
																				<input type="radio" name="srv_star" value="3" id="rate3"><label for="rate3">⭐</label>
																				<input type="radio" name="srv_star" value="2" id="rate4"><label for="rate4">⭐</label>
																				<input type="radio" name="srv_star" value="1" id="rate5"><label for="rate5">⭐</label>
																			</fieldset>
																		</div>
																		<div id="textCnt" class="col-lg-6">(0/60)</div>
																	</div>
																	<textarea name="srv_content" id="srvContent" cols="30" rows="1" placeholder="댓글을 남겨주세요."></textarea>
																</div>
															</div>
															<div class="col-lg-1 commentBtn_wrap">
																<button type="button" id="srvSendBtn" class="btn btn-dark" onclick="checkUserId()">수정</button>
															</div>
														</div>
													</li>
													</form>
													<div id="simpleReviewList">
														<!-- 한줄평 목록 출력 -->
													</div>
												</ul>
				
				                            </div>
				                            <div class="paging_wrap">
				                            
											</div>
				                        </div>
									</div>
								</div>

								<div class="listBtnBox">
									<a href="/exhibitionCurrentList" class="listBtn">목록보기</a>
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

	<!-- Modal 버튼 -->
	<div class="modal fade" id="modal1" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="model-title fs-5">전시회 예매</h1>
					<button class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<h1 style="font-size:18px; font-weight:bold;">날짜/시간</h1>
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-6">달력</div>
							<div class="col-md-6 ms-auto">
								<ul class="nav nav-pills mb-4"
									style="justify-content:center; font-size:12px; width:50%;" role="tablist">
									<li class="nav-item">
										<a class="nav-link active tabColor" data-bs-toggle="pill">11.27(월) 10:00 ~ 18:00</a>
									</li>
									<li class="nav-item">
										<a class="nav-link tabColor" data-bs-toggle="pill">11.27(월) 18:00 ~ 21:00</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="row">
							<div class="col-lg-6">
								<h2>날짜 / 시간</h2>
							</div>
							<div class="col-lg-6">

							</div>
						</div>
					</div>
					<hr>
					<h1 style="font-size:18px; font-weight:bold;">가격/수량</h1>
					<div style="width:100%; float:left;">
						<table border="0" cellspacing="0" cellpadding="0" style="width:100%; height:auto;"
							id="view_table">
							<tbody style="font-size:15px;">
								<tr>
									<th>일반</th>
									<td>5,000원
										<select name="ticket"
											style="-webkit-appearance: auto; appearance: auto; border-radius: 0.3em;  align-items:center; width:100px; height:25px; ">
											<option value="0">0매</option>
											<option value="1">1매</option>
											<option value="2">2매</option>
											<option value="3">3매</option>
											<option value="4">4매</option>
											<option value="5">5매</option>
											<option value="6">6매</option>
											<option value="7">7매</option>
											<option value="8">8매</option>
											<option value="9">9매</option>
											<option value="10">10매</option>
										</select>
									</td>
								</tr>
								<tr>
									<th>대학생</th>
									<td>0원 <select name="ticket"
											style="-webkit-appearance: auto; appearance: auto; border-radius: 0.3em;  align-items:center; width:100px; height:25px; ">
											<option value="0">0매</option>
											<option value="1">1매</option>
											<option value="2">2매</option>
											<option value="3">3매</option>
											<option value="4">4매</option>
											<option value="5">5매</option>
											<option value="6">6매</option>
											<option value="7">7매</option>
											<option value="8">8매</option>
											<option value="9">9매</option>
											<option value="10">10매</option>
										</select></td>
								</tr>
								<tr>
									<th>초중고</th>
									<td>0원 <select name="ticket"
											style="-webkit-appearance: auto; appearance: auto; border-radius: 0.3em;  align-items:center; width:100px; height:25px; ">
											<option value="0">0매</option>
											<option value="1">1매</option>
											<option value="2">2매</option>
											<option value="3">3매</option>
											<option value="4">4매</option>
											<option value="5">5매</option>
											<option value="6">6매</option>
											<option value="7">7매</option>
											<option value="8">8매</option>
											<option value="9">9매</option>
											<option value="10">10매</option>
										</select></td>
								</tr>
								<tr>
									<th>미취학</th>
									<td>0원 <select name="ticket"
											style="-webkit-appearance: auto; appearance: auto; border-radius: 0.3em;  align-items:center; width:100px; height:25px; ">
											<option value="0">0매</option>
											<option value="1">1매</option>
											<option value="2">2매</option>
											<option value="3">3매</option>
											<option value="4">4매</option>
											<option value="5">5매</option>
											<option value="6">6매</option>
											<option value="7">7매</option>
											<option value="8">8매</option>
											<option value="9">9매</option>
											<option value="10">10매</option>
										</select></td>
								</tr>
								<tr style="border-bottom: 0px solid #E9E9E9;">
									<th>65세 이상</th>
									<td style="border-bottom: 0px solid #E9E9E9;">0원 <select name="ticket"
											style="-webkit-appearance: auto; appearance: auto; border-radius: 0.3em;  align-items:center; width:100px; height:25px; ">
											<option value="0">0매</option>
											<option value="1">1매</option>
											<option value="2">2매</option>
											<option value="3">3매</option>
											<option value="4">4매</option>
											<option value="5">5매</option>
											<option value="6">6매</option>
											<option value="7">7매</option>
											<option value="8">8매</option>
											<option value="9">9매</option>
											<option value="10">10매</option>
										</select></td>
								</tr>
							</tbody>
						</table>
						<hr>
					</div>
				</div>
				<div class="modal-footer">
					<h1 style="font-size:18px; font-weight:bold; margin-bottom: 20px;">결제 예정 금액</h1>
					<div class="container-fluid">
						<div class="row">
							<div style="width:100%; float:left;">
								<table border="0" cellspacing="0" cellpadding="0" style="width:100%; height:100px;"
									id="modal_table">
									<tbody style="font-size:15px;">
										<tr>
											<th>티켓매수</th>
											<th>티켓금액</th>
											<th style="color: red;">총 결제금액</th>
										</tr>
										<tr>
											<th>1</th>
											<th>5,000원</th>
											<th style="color: red;">5,000원</th>
										</tr>
									</tbody>
								</table>
								<div class="modal-footer" style="justify-content:center;">
									<a href="javascript:void(0);" class="buttons kakaoBtn"><img src="../img/icon_kakao_02.svg" alt="icon_kakao" onclick="alert('결제하시겠습니까?')"> 카카오 결제</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 커스텀 JS -->
	<script src='../js/fixed.js'></script>
	<!-- <script src='../js/'></script> -->
	
</div>  
</body>
</html>
    