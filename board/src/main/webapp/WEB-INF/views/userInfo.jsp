<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5	.2/js/bootstrap.min.js"></script>
<script type="text/javascript">

$(document).ready(function(e){
	   $('#logout').click(function() {
		   alert("로그아웃되었습니다");
	   });
	});

function goMainFunc(){
	location.href="main?userIdx="+<%=session.getAttribute("userIdx")%>;
}

</script>
</head>
<body class="container" style="width: 30%;">
	<div class="container" style="height: 80px;"></div>

	<!-- 로그인/회원가입/내정보/로그아웃 -->
	<div class="container" style="height: 50px;">
		<%	if (session.getAttribute("userIdx") == null) { %>
		<!-- 로그인/회원가입 버튼 -->
		<ul class="nav justify-content-end">
			<li class="nav-item"><a class="nav-link"
				href="${pageContext.request.contextPath}/" style="color: black;">홈</a></li>
			<li class="nav-item"><a class="nav-link" href="signIn"
				style="color: black;">로그인</a></li>
			<li class="nav-item"><a class="nav-link" href="signUp"
				style="color: black;">회원가입</a></li>
		</ul>
		<% } else { %>
		<!-- 내 정보 /로그아웃 버튼-->
		<ul class="nav justify-content-end">
			<li class="nav-item"><a class="nav-link"
				href="javascript:goMainFunc();" style="color: black;">홈</a></li>
			<li class="nav-item"><a class="nav-link" href="userInfo"
				style="color: black;">내 정보</a></li>
			<li id="logout" class="nav-item"><a class="nav-link"
				href="${pageContext.request.contextPath}/" style="color: black;">로그아웃</a></li>
		</ul>
		<% } %>
	</div>

	<div class="container" style="height: 40px;"></div>

	<!-- 유저 정보 -->
	<div class="container">
		<div>
			<ul class="list-group">
				<li class="list-group-item">${userInfo.userNickname}님</li>
				<li
					class="list-group-item d-flex justify-content-between align-items-center">
					내 글 <span class="badge badge-primary badge-pill">${userInfo.myBoard}</span>
				</li>
				<li
					class="list-group-item d-flex justify-content-between align-items-center">
					내 댓글 <span class="badge badge-primary badge-pill">${userInfo.myReview}</span>
				</li>
				<li class="list-group-item">정보 수정</li>
				<li class="list-group-item">탈퇴</li>
			</ul>
		</div>

	</div>
</body>
</html>