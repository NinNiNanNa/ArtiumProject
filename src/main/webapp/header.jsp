<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<header id='header'>
		<div class='wrap1440'>
			<div class='gap1440'>
				<div class='container1440 clearfix'>
					
					<h1>
						<a href='/' title='Home'>ARTIUM</a>
					</h1>
					
					<div class='appbar-wrap'>
						<a href='javascript:' id="appbarBtn" class='appbarBtn'>
							<span>
								<i class='bar bar0'></i>
								<i class='bar bar1'></i>
								<i class='bar bar2'></i>
							</span>
						</a>
					</div>
					
					<div class='menu_wrap'>
						<!-- JSP에서 로그인 / 로그아웃 분리 - 시작 -->
						<ul class="account">
							<li><span>계정</span></li>
							<li><a href="/login">로그인</a></li>
							<li><a href="/join">회원가입</a></li>
							<li>
								<a href="/mypage" class="clearfix">
									<div class="profile_img">
										<img src="./img/profile.png" alt="">
									</div>
									<div class="profile_info">
										<span>닌니난나</span>
										<i>kimsojin3011@gmail.com</i>
									</div>
								</a>
							</li>
							<li><a href="">로그아웃</a></li>
						</ul>
						<!-- JSP에서 로그인 / 로그아웃 분리 - 끝 -->
						<ul class="menu">
							<li><span>메뉴</span></li>
							<!-- <li><a href='/exhibitionList' title='EXHIBITIONS'>EXHIBITIONS</a></li> -->
							<li><a href='/exhibitionCurrentList' title='EXHIBITIONS'>EXHIBITIONS</a></li>
							<li><a href='/reviewList' title='REVIEW'>REVIEW</a></li>
							<li><a href='/mateList' title='MATE'>MATE</a></li>
							<li><a href='/galleryList' title='GALLERY'>GALLERY</a></li>
							<li><a href='' title='ABOUT'>ABOUT</a></li>
						</ul>
					</div>
					
				</div>
			</div>
		</div>
	</header>