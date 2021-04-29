<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	
<script type="text/javascript">

$(document).ready(function(e){
	   $('#logout').click(function() {
		   alert("로그아웃되었습니다");
	   });
	});

</script>

<script type="text/javascript">

function goMainFunc(){
	location.href="main?userIdx="+<%=session.getAttribute("userIdx")%>;
}
</script>

</head>
<body>

	<div class="container" style="height: 80px;"></div>

	<!-- 로그인/회원가입/내정보/로그아웃 -->
	<div class="container" style="height: 50px;">
			<%	if (session.getAttribute("userIdx") == null) { %>
			<!-- 로그인/회원가입 버튼 -->
				<ul class="nav justify-content-end">
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/"
						style="color: black;">홈</a></li>
					<li class="nav-item"><a class="nav-link" href="signIn"
						style="color: black;">로그인</a></li>
					<li class="nav-item"><a class="nav-link" href="signUp"
						style="color: black;">회원가입</a></li>
				</ul>
			<% } else { %>
			<!-- 내 정보 /로그아웃 버튼-->
				<ul class="nav justify-content-end">
					<li class="nav-item"><a class="nav-link" href="javascript:goMainFunc();" 
						style="color: black;">홈</a></li>
					<li class="nav-item"><a class="nav-link" href="signIn"
						style="color: black;">내 정보</a></li>
					<li id="logout" class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/"
						style="color: black;">로그아웃</a></li>
				</ul>
			<% } %>
	</div>
	
	<div class="container" style="height: 40px;"></div>

	<!-- 검색 /인기순 /최신순 -->
	<div class="container" style="height: 50px;">
		<div class="row">
			<!-- 검색바 -->
			<div class="col-sm-5">
				<form class="form-inline" action="/action_page.php">
					<input class="form-control mr-sm-2" type="text"
						placeholder="Search" style="width: 76%;">
					<button class="btn btn-dark" type="submit">Search</button>
				</form>
			</div>
			<!-- 게시물 정렬 -->
			<div class="col-sm-7">
				<div style="float: right;">
					<div class="form-check-inline">
				      <label class="form-check-label" for="radio1">
				        <input type="radio" class="form-check-input" id="radio1" name="optradio" value="option1" checked>최신순
				      </label>
				    </div>
				    <div class="form-check-inline">
				      <label class="form-check-label" for="radio2">
				        <input type="radio" class="form-check-input" id="radio2" name="optradio" value="option2">인기순
				      </label>
				    </div>
			    </div>
			</div>
		</div>
	</div>

	<!-- 표 -->
	<div class="container">
		<table class="table">
			<thead>
				<tr>
					<th style="width: 10%;">no.</th>
					<th style="width: 60%;">제목</th>
					<th style="width: 10%;">닉네임</th>
					<th style="width: 10%;">조회수</th>
					<th style="width: 10%;">댓글수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="item" items="${list}">
				  	<tr onclick="location.href='board?boardIdx=${item.boardIdx}'" style="cursor:pointer;">
						<td>${item.boardIdx}</td>
						<td>[${item.boardSubject}] ${item.boardTitle}</td>
						<td>${item.userNickname}</td>
						<td>${item.boardViews}</td>
						<td>${item.boardComments}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<div class="container" style="height: 30px;">
		<div style="float: right;">
		  	<%	if (session.getAttribute("userIdx") == null) { %>
			<!-- 글 작성 버튼 비활성화 -->
				<button type="button" class="btn btn-outline-dark" disabled>글 쓰기</button>
			<% } else { %>
			<!-- 글 작성 버트튼 활성화 -->
				<button type="button" class="btn btn-outline-dark" onclick="location.href='writeBoard'">글 쓰기</button>
			<% } %>
	  	</div>
	</div>
	
	<div class="container" style="height: 20px;"></div>

	<div class="container">
		<nav class="navbar navbar-expand-sm justify-content-center">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" href="#">1</a></li>
				<li class="nav-item"><a class="nav-link" href="#">2</a></li>
				<li class="nav-item"><a class="nav-link" href="#">3</a></li>
				<li class="nav-item"><a class="nav-link" href="#">4</a></li>
				<li class="nav-item"><a class="nav-link" href="#">5</a></li>
				<li class="nav-item"><a class="nav-link" href="#">6</a></li>
				<li class="nav-item"><a class="nav-link" href="#">7</a></li>
				<li class="nav-item"><a class="nav-link" href="#">8</a></li>
			</ul>
		</nav>
	</div>

</body>
</html>
