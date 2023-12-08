<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<script type="text/javascript">
function logoutPrint(){
	alert('로그아웃되었습니다.');
}    
</script>
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
						<c:set var="userId" value="${sessionScope.userId }"></c:set>
						<ul class="account">
							<li><span>계정</span></li>
						<c:choose>
							<c:when test="${not empty userId }">
							<li>
								<a href="./mypage.html" class="clearfix">
									<div class="profile_img">
										<img src="${memberDTO.user_image }" alt="">
									</div>
									<div class="profile_info">
										<span>${memberDTO.user_name }</span>
										<i>${memberDTO.user_email }</i>
									</div>
								</a>
							</li>
							<li><a href="">로그아웃</a></li>
							</c:when>
							<c:otherwise>
							<li><a href="./login.html">로그인</a></li>
							<li><a href="./join.html">회원가입</a></li>
							</c:otherwise>
						</c:choose>
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