<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>내 게시물</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	
<script type="text/javascript">

	//홈으로 돌아가기
	function goMainFunc(){
		location.href="main?userIdx="+<%=session.getAttribute("userIdx")%>;
	}

	// 로그아웃
	$(document).ready(function(e){
	   $('#logout').click(function() {
		   alert("로그아웃되었습니다");
	   });
	});

</script>
</head>
<body>

<div class="container" >

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
					<li class="nav-item"><a class="nav-link" href="userInfo"
						style="color: black;">내 정보</a></li>
					<li id="logout" class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/"
						style="color: black;">로그아웃</a></li>
				</ul>
			<% } %>
	</div>
	
	<div class="container" style="height: 40px;"></div>
  
  	<!-- 표 -->
  	<div class="container">
		<table class="table table-hover">
			<thead>
				<tr>
					<th style="width: 10%;">no.</th>
					<th style="width: 55%;">제목</th>
					<th style="width: 15%;">닉네임</th>
					<th style="width: 10%;">조회수</th>
					<th style="width: 10%;">댓글수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="item" items="${myBoard}">
				  	<tr onclick="location.href='${pageContext.request.contextPath}/board?boardIdx=${item.boardIdx}&userIdx=${item.userIdx}'" style="cursor:pointer;">
						<td>${item.boardIdx}</td>
						<td>[${item.boardSubject}] ${item.boardTitle}</td>
						<td>${item.userNickname}</td>
						<td>${item.boardViews}</td>
						<td>${item.boardReply}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
  	</div>
</div>


</body>
</html>