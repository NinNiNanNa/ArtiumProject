<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<link rel='stylesheet' type='text/css' href='./css/reset.css'>
	<link rel='stylesheet' type='text/css' href='./css/fonts.css'>
	<link rel='stylesheet' type='text/css' href='./css/fixed.css'>
	<link rel='stylesheet' type='text/css' href='./css/mypage.css'>
	
	<!-- 제이쿼리 로컬 -->
	<script src='./js/lib/jquery-1.12.4.min.js'></script>
	<script src='./js/lib/jquery.easing.1.3.js'></script>
	<script src='./js/lib/jquery.touchSwipe.js'></script>

	<!-- 브라우저별 접두사 쓸 필요 없음 -->
	<script src='./js/lib/prefixfree.min.js'></script>

	<!-- 아이콘 -->
    <link href="./vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

	<!-- calendar를 위한 라이브러리들 지우면 안됨 -->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src='https://fullcalendar.io/releases/fullcalendar/3.9.0/lib/moment.min.js'></script>
	<link href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.css'rel='stylesheet'/>
	<link href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.print.css' rel='stylesheet' media='print'/>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.js'></script>
	<script type="text/javascript">
	    function sendNumber(){
	        $("#mail_number").css("display","block");
	        $.ajax({
	            url:"/mail",
	            type:"post",
	            data:{"email" : $("#email").val()},
	            success: function(data){
	                alert("인증번호가 발송되었습니다.");
	                $("#Confirm").attr("value",data);
	            }
	        });
	    }
	
	    function confirmNumber(){
	        var number1 = $("#number").val();
	        var number2 = $("#Confirm").val();
	
	        if(number1 == number2){
	            alert("인증되었습니다.");
	        }else{
	            alert("번호가 다릅니다.");
	        }
	    }
	    
	    function submit(){
	    	alert("수정되었습니다.");
	    	var form = document.getElementById('frm');
	    	form.action = "mypage";
	    	form.method = "post";
	    	form.submit();
	    }
	    
	    function removeCheck(user_id) {
	    	 if (confirm("정말 탈퇴하시겠습니까?") == true){    //확인
	    		 deleteMember(user_id);
	    	 }else{   //취소
	    	     return false;
	    	 }
	    	}
   	
	    function deleteMember(user_id){
	        $.ajax({
	            url:"/mypage/delete",
	            type:"post",
	            data:{"user_id" : user_id},
	            success: function(data){
	                alert("회원 탈퇴가 정상적으로 이뤄졌습니다.");
	                location.href="/";
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
	
	<main id='main'>
		<c:set var="userId" value="${sessionScope.userId}"></c:set>
		<c:set var="userPass" value="${sessionScope.userPass}"></c:set>
		<c:set var="userName" value="${sessionScope.userName}"></c:set>
		<c:set var="userEmail" value="${sessionScope.userEmail}"></c:set>
		<c:set var="userGender" value="${sessionScope.userGender}"></c:set>
		<c:set var="userImg" value="${sessionScope.userImg}"></c:set>
		<c:set var="userType" value="${sessionScope.userType}"></c:set>
		<section id="section1">
			<div class="wrap1440">
				<div class="gap1440">
					<div class="container1440">
						
						<div class="profile_wrap">
							<c:choose>
								<c:when test="${not empty userImg}">
									<img style="width:120px; height:120px; border-radius: 100%;" src="../img/${userImg}" alt="" >
								</c:when>
								<c:when test="${empty userImg}">
									<img src="./img/profile.png" alt="">
								</c:when>
							</c:choose>
							<div class="profile_info">
							<c:choose>
								<c:when test="${userType == 'G'}">
									<span>일반회원</span>
								</c:when>
								<c:when test="${userType == 'A'}">
									<span>작가회원</span>
								</c:when>
							</c:choose>
								<h2>${userName}</h2>
								<ul>
								<c:choose>
									<c:when test="${userGender == 'M'}">
										<li>남성</li>
									</c:when>
									<c:when test="${userGender == 'W'}">
										<li>여성</li>
									</c:when>
								</c:choose>
									<li>${userEmail}</li>
								</ul>
							</div>
						</div>

						<ul class="nav nav-pills" role="tablist">
							<li class="nav-item">
								<a class="nav-link active tabColor" data-bs-toggle="pill" href="#mypage1">회원 정보 수정</a>
							</li>
							<li class="nav-item">
								<a class="nav-link tabColor" data-bs-toggle="pill" href="#mypage2">작성글 조회</a>
							</li>
							<li class="nav-item">
								<a class="nav-link tabColor" data-bs-toggle="pill" href="#mypage3">북마크</a>
							</li>
							<li class="nav-item">
								<a class="nav-link tabColor" data-bs-toggle="pill" href="#mypage4">출석체크</a>
							</li>
							<li class="nav-item">
								<a class="nav-link tabColor" data-bs-toggle="pill" href="#mypage5">포인트 내역</a>
							</li>
							<li class="nav-item">
								<a class="nav-link tabColor" data-bs-toggle="pill" href="#mypage6">결제 내역</a>
							</li>
						</ul>

					</div>
				</div>
			</div>
		</section>

    <section id="section2">
        <div class="wrap1440">
            <div class="gap1440">
                <div class="container1440">

			<div class="tab-content">
				<div id="mypage1" class="tab-pane active">
					
					<form action="mypage" method="post" id="frm">
					<div class="wrap470">
						<div class="content_wrap">
							<ul class="inputText_wrap">
								<li>
									<div class="profileUpload">
										<c:choose>
											<c:when test="${not empty userImg}">
												<img style="width:128px; height:128px; border-radius: 100%;" src="../img/${userImg}" alt="" >
											</c:when>
											<c:when test="${empty userImg}">
												<img id="preview" src="./img/profile.png" alt="">
											</c:when>
										</c:choose>
										<label for="imageFile">
											<div class="uploadBtn"><i class="fas fa-camera"></i></div>
										</label>
										<input type="file" name="user_image" id="imageFile" accept="image/gif, image/jpeg, image/png">
									</div>
								</li>
								<li>
									<h2>아이디</h2>
									<div class="inputBox inputBoxId">
										<input type="text" name="user_id" id="id" value="${userId}" readonly>
									</div>
								</li>
								<li>
									<h2>비밀번호 입력</h2>
									<div class="inputBox inputBoxPw1">
										<input type="password" name="user_pass" id="pw1" value="${userPass}">
										<a href="javascript:void(0);" class="delBtn"><img src="./img/icon_close_circle.svg" alt=""></a>
										<a href="javascript:void(0);" class="pwBtn"><img src="./img/icon_pw_hide.svg" alt=""></a>
										<p></p>
									</div>
								</li>
								<li>
									<h2>비밀번호 확인</h2>
									<div class="inputBox inputBoxPw2">
										<input type="password" name="pw2" id="pw2" value="${userPass}">
										<a href="javascript:void(0);" class="delBtn"><img src="./img/icon_close_circle.svg" alt=""></a>
										<a href="javascript:void(0);" class="pwBtn"><img src="./img/icon_pw_hide.svg" alt=""></a>
										<p></p>
									</div>
								</li>
								<li>
									<h2>닉네임</h2>
									<div class="inputBox inputBoxName">
										<input type="text" name="user_name" id="name" value="${userName}">
										<a href="javascript:void(0);" class="delBtn"><img src="./img/icon_close_circle.svg" alt=""></a>
										<p></p>
									</div>
								</li>
								<li>
									<h2>성별</h2>
									<div class="inputBox">
										<c:choose>
											<c:when test="${userGender == 'M'}">
											<label for='genderM' class="clearfix">
												<input type='radio' name='user_gender' id='genderM' value='M' checked>
												<span>남성</span>
												</label>
											<label for='genderW' class="clearfix">
												<input type='radio' name='user_gender' id='genderW' value='W'>
												<span>여성</span>
											</label>
											</c:when>
											<c:when test="${userGender == 'W'}">
												<label for='genderM' class="clearfix">
													<input type='radio' name='user_gender' id='genderM' value='M'>
													<span>남성</span>
												</label>
												<label for='genderW' class="clearfix">
													<input type='radio' name='user_gender' id='genderW' value='W' checked>
													<span>여성</span>
												</label>
											</c:when>
										</c:choose>
	
									</div>
								</li>
								<li>
									<h2>이메일</h2>
									<div class="inputBox inputBoxEmail">
										<input type="text" name="user_email" id="email" value="${userEmail}">
										<a href="javascript:void(0);" class="delBtn"><img src="./img/icon_close_circle.svg" alt=""></a>
										<a href="javascript:void(0);" class="addChkBtn" id="checkEmail" onclick="sendNumber()">본인인증</a>
										<p></p>
									</div>
								</li>
								<li>
									<h2>이메일 인증번호</h2>
									<div class="inputBox inputBoxEmail2">
										<input type="text" name="email2" id="number" placeholder="인증번호를 입력해 주세요.">
										<input type="text" id="Confirm" name="Confirm" style="display: none" value="">
										<a href="javascript:void(0);" class="delBtn"><img src="./img/icon_close_circle.svg" alt=""></a>
										<a href="javascript:void(0);" class="addChkBtn" onclick="confirmNumber()">인증확인</a>
										<p></p>
									</div>
								</li>
							</ul>

							<ul class="button_wrap clearfix">
								<li>
									<div>
										<a href="javascript:void(0);" class="joinCanBtn" onclick="removeCheck('${userId}')">탈퇴</a>
									</div>
								</li>
								<li>
									<div>
										<a href="javascript:void(0);" class="joinConBtn" onclick="submit()">확인</a>
									</div>
								</li>
							</ul>
						</div>
					</div>
					</form>
				</div>
			</div>

                </div>
            </div>
        </div>
    </section>

		<section id="section3">
			<div class="wrap1440">
				<div class="gap1440">
					<div class="container1440">

						<div class="tab-content">
							<div id="mypage2" class="tab-pane fade">

								<ul class="nav nav-pills pb-3" role="tablist">
									<li class="nav-item">
										<a class="nav-link active tabColor" data-bs-toggle="pill" href="#mypage2_1">한줄평가</a>
									</li>
									<li class="nav-item">
										<a class="nav-link tabColor" data-bs-toggle="pill" href="#mypage2_2">댓글</a>
									</li>
									<li class="nav-item">
										<a class="nav-link tabColor" data-bs-toggle="pill" href="#mypage2_3">전시 리뷰</a>
									</li>
									<li class="nav-item">
										<a class="nav-link tabColor" data-bs-toggle="pill" href="#mypage2_4">전시 메이트</a>
									</li>
									<li class="nav-item">
										<a class="nav-link tabColor" data-bs-toggle="pill" href="#mypage2_5">작가 갤러리</a>
									</li>
								</ul>

								<div class="tab-content">
									<div id="mypage2_1" class="tab-pane active">
										
										<ul class="comList_wrap">
											<li>
												<div class="row">
													<div class="col-lg-2 comImg_wrap">
														<img src="./img/profile.png" alt="">
													</div>
													<div class="col-lg-10 comText_wrap">
														<div class="star_wrap">
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>
															<i class="far fa-star"></i>
														</div>
														<div class="user_wrap">
															<span>닉네임</span>
															<span>작성일</span>
														</div>
														<div class="content_wrap">
															한줄평가 작성 내용
														</div>
													</div>
													<div class="btn_wrap">
														<a href="">수정</a>
														<a href="">삭제</a>
													</div>
												</div>
											</li>
										</ul>

									</div>
								</div>

								<div class="tab-content">
									<div id="mypage2_2" class="tab-pane fade">
										
										<ul class="comList_wrap">
											<li>
												<div class="row">
													<div class="col-lg-2 comImg_wrap">
														<img src="./img/profile.png" alt="">
													</div>
													<div class="col-lg-10 comText_wrap">
														<div class="user_wrap">
															<span>닉네임</span>
															<span>작성일</span>
														</div>
														<div class="content_wrap">
															댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용<br>
															댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용<br>
														</div>
													</div>
													<div class="btn_wrap">
														<a href="">수정</a>
														<a href="">삭제</a>
													</div>
												</div>
											</li>
										</ul>

									</div>
								</div>

								<div class="tab-content">
									<div id="mypage2_3" class="tab-pane fade">
										
										<ul class="list_wrap row">
											<li class="col-lg-3">
												<div class="listInfo">
													<div class="image_wrap">
														<img src="./img/imgex3.jpg" alt="">
													</div>
													<div class="title_wrap">
														<div>
															<a class="txtSkip" href="javascript:;">메이트 모집 제목</a>
															<h6>사용자 닉네임</h6>
															<h5>2023-11-01</h5>
															<ul class="info_wrap">
																<li>
																	<span>조회수 <i>22</i></span>
																</li>
																<li>
																	<span>북마크 <i>5</i></span>
																</li>
															</ul>
														</div>
													</div>
												</div>
											</li>
										</ul>

									</div>
								</div>

								<div class="tab-content">
									<div id="mypage2_4" class="tab-pane fade">

										<ul class="list_wrap row">
											<li class="col-lg-6">
												<div class="listInfo">
													<div class="image_wrap" style="position: relative;">
														<img src="./img/imgex1.jpg" alt="">
													</div>
													<div class="title_wrap">
														<div>
															<div class="userInfo">
																<a class="txtSkip" href="javascript:;">메이트 모집 제목</a>
																<span>사용자 닉네임</span>
																<span>등록일 <i>2023-11-22</i></span>
																<span>조회수 <i>22</i></span>
																<span>북마크 <i>5</i></span>
															</div>
															<div class="mateDetail">
																<div>
																	<a class="txtSkip" href="javascript:;">전시회 제목</a>
																	<span>관람예정일 <i>2023-11-22</i></span>
																	<span>성별 <i>여</i></span>
																	<span>나이 <i>26</i></span>
																</div>
															</div>
														</div>
													</div>
												</div>
											</li>
										</ul>

									</div>
								</div>

								<div class="tab-content">
									<div id="mypage2_5" class="tab-pane fade">

										<ul class="list_wrap row">
											<li class="col-lg-3">
												<div class="listInfo">
													<div class="image_wrap">
														<img src="./img/imgex3.jpg" alt="">
													</div>
													<div class="title_wrap">
														<div>
															<a class="txtSkip" href="javascript:;">갤러리 작품 제목</a>
															<h6>사용자 닉네임</h6>
															<h5>2023-11-01</h5>
															<ul class="info_wrap">
																<li>
																	<span>조회수 <i>22</i></span>
																</li>
																<li>
																	<span>북마크 <i>5</i></span>
																</li>
															</ul>
														</div>
													</div>
												</div>
											</li>
										</ul>

									</div>
								</div>

							</div>
						</div>

					</div>
				</div>
			</div>
		</section>

		<section id="section4">
			<div class="wrap1440">
				<div class="gap1440">
					<div class="container1440">

						<div class="tab-content">
							<div id="mypage3" class="tab-pane fade">

								<ul class="nav nav-pills pb-3" role="tablist">
									<li class="nav-item">
										<a class="nav-link active tabColor" data-bs-toggle="pill" href="#mypage3_1">전시회</a>
									</li>
									<li class="nav-item">
										<a class="nav-link tabColor" data-bs-toggle="pill" href="#mypage3_2">전시 리뷰</a>
									</li>
									<li class="nav-item">
										<a class="nav-link tabColor" data-bs-toggle="pill" href="#mypage3_3">전시 메이트</a>
									</li>
									<li class="nav-item">
										<a class="nav-link tabColor" data-bs-toggle="pill" href="#mypage3_4">작가 갤러리</a>
									</li>
								</ul>

								<div class="tab-content">
									<div id="mypage3_1" class="tab-pane active">

										<ul class="list_wrap row">
											<li class="col-lg-3">
												<div class="listInfo">
													<div class="image_wrap">
														<img src="./img/imgex2.jpg" alt="">
														<div class="listBtn_wrap">
															<a href="#" class="bookMarkBtn">
																<i class="fas fa-bookmark"></i>
															</a>
														</div>
													</div>
													<div class="title_wrap">
														<div>
															<a class="txtSkip" href="javascript:;">전시회 제목</a>
															<h6 class="txtSkip">전시회 장소</h6>
															<h5>2023-11-01 ~ 2023-12-30</h5>
															<ul class="info_wrap">
																<li>
																	<span>조회수 <i>22</i></span>
																</li>
																<li>
																	<span>북마크 <i>5</i></span>
																</li>
															</ul>
														</div>
													</div>
												</div>
											</li>
										</ul>

									</div>
								</div>

								<div class="tab-content">
									<div id="mypage3_2" class="tab-pane fade">
										
										<ul class="list_wrap row">
											<li class="col-lg-3">
												<div class="listInfo">
													<div class="image_wrap">
														<img src="./img/imgex3.jpg" alt="">
														<div class="listBtn_wrap">
															<a href="#" class="bookMarkBtn">
																<i class="fas fa-bookmark"></i>
															</a>
														</div>
													</div>
													<div class="title_wrap">
														<div>
															<a class="txtSkip" href="javascript:;">메이트 모집 제목</a>
															<h6>사용자 닉네임</h6>
															<h5>2023-11-01</h5>
															<ul class="info_wrap">
																<li>
																	<span>조회수 <i>22</i></span>
																</li>
																<li>
																	<span>북마크 <i>5</i></span>
																</li>
															</ul>
														</div>
													</div>
												</div>
											</li>
										</ul>

									</div>
								</div>

								<div class="tab-content">
									<div id="mypage3_3" class="tab-pane fade">

										<ul class="list_wrap row">
											<li class="col-lg-6">
												<div class="listInfo">
													<div class="image_wrap" style="position: relative;">
														<img src="./img/imgex1.jpg" alt="">
														<div class="listBtn_wrap">
															<a href="#" class="bookMarkBtn">
																<i class="fas fa-bookmark"></i>
															</a>
														</div>
													</div>
													<div class="title_wrap">
														<div>
															<div class="userInfo">
																<a class="txtSkip" href="javascript:;">메이트 모집 제목</a>
																<span>사용자 닉네임</span>
																<span>등록일 <i>2023-11-22</i></span>
																<span>조회수 <i>22</i></span>
																<span>북마크 <i>5</i></span>
															</div>
															<div class="mateDetail">
																<div>
																	<a class="txtSkip" href="javascript:;">전시회 제목</a>
																	<span>관람예정일 <i>2023-11-22</i></span>
																	<span>성별 <i>여</i></span>
																	<span>나이 <i>26</i></span>
																</div>
															</div>
														</div>
													</div>
												</div>
											</li>
										</ul>

									</div>
								</div>

								<div class="tab-content">
									<div id="mypage3_4" class="tab-pane fade">

										<ul class="list_wrap row">
											<li class="col-lg-3">
												<div class="listInfo">
													<div class="image_wrap">
														<img src="./img/imgex3.jpg" alt="">
														<div class="listBtn_wrap">
															<a href="#" class="bookMarkBtn">
																<i class="fas fa-bookmark"></i>
															</a>
														</div>
													</div>
													<div class="title_wrap">
														<div>
															<a class="txtSkip" href="javascript:;">갤러리 작품 제목</a>
															<h6>사용자 닉네임</h6>
															<h5>2023-11-01</h5>
															<ul class="info_wrap">
																<li>
																	<span>조회수 <i>22</i></span>
																</li>
																<li>
																	<span>북마크 <i>5</i></span>
																</li>
															</ul>
														</div>
													</div>
												</div>
											</li>
										</ul>

									</div>
								</div>

							</div>
						</div>

					</div>
				</div>
			</div>
		</section>

		<section id="section5">
			<div class="wrap1440">
				<div class="gap1440">
					<div class="container1440">

						<div class="tab-content">
							<div id="mypage4" class="tab-pane fade">

								<div class="container calendar-container">
									<div id="calendar" style="max-width:900px; margin:40px auto;"></div>
								</div>

							</div>
						</div>

					</div>
				</div>
			</div>
		</section>

		<section id="section6">
			<div class="wrap1440">
				<div class="gap1440">
					<div class="container1440">

						<div class="tab-content">
							<div id="mypage5" class="tab-pane fade">

								<div class="table_wrap">
									<div class="table_gap">
	
										<table class="table" style="table-layout: fixed;">
											<colgroup>
												<col width="80px"/>
												<col width="*"/>
												<col width="*"/>
												<col width="150px"/>
											</colgroup>
											<thead>
												<tr>
													<th>번호</th>
													<th>내용</th>
													<th>적립일</th>
													<th>포인트</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>1</td>
													<td>전시 리뷰 작성</td>
													<td>2023-11-23</td>
													<td>200</td>
												</tr>
												<tr>
													<td>2</td>
													<td>출석 체크</td>
													<td>2023-11-23</td>
													<td>50</td>
												</tr>
											</tbody>
										</table>
	
									</div>
								</div>

							</div>
						</div>

					</div>
				</div>
			</div>
		</section>

		<section id="section7">
			<div class="wrap1440">
				<div class="gap1440">
					<div class="container1440">

						<div class="tab-content">
							<div id="mypage6" class="tab-pane fade">

								<div class="table_wrap">
									<div class="table_gap">
	
										<table class="table" style="table-layout: fixed;">
											<colgroup>
												<col width="80px"/>
												<col width="*"/>
												<col width="150px"/>
												<col width="150px"/>
												<col width="150px"/>
												<col width="150px"/>
											</colgroup>
											<thead>
												<tr>
													<th>번호</th>
													<th>티켓명</th>
													<th>가격</th>
													<th>할인</th>
													<th>결제일</th>
													<th>결제</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>1</td>
													<td>전시 제목</td>
													<td>10000원</td>
													<td>0</td>
													<td>2023-11-23</td>
													<td><button type="button" class="btn btn-danger">취소</button></td>
												</tr>
												<tr>
													<td>2</td>
													<td>전시 제목</td>
													<td>10000원</td>
													<td>0</td>
													<td>2023-11-23</td>
													<td><button type="button" class="btn btn-danger">취소</button></td>
												</tr>
											</tbody>
										</table>
	
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
	<script src='./js/fixed.js'></script>
	<script src='./js/mypage.js'></script>
	
</div>  
</body>
</html>