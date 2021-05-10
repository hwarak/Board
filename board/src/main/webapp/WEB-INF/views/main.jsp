<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>main</title>
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

	// 로그인 하지 않으면 게시물 볼 수 없음 -> 로그인으로 연결
	function goLogin(){
		alert("로그인 하셔야 볼 수 있어요.");
		location.href="signIn";
	}


	//인기순, 최신순 정렬
	$(document).ready(function () {
	  var formData = new FormData();
	
		// 최신순 눌렀을때
		$('#radio1').click(function () {
			$.ajax({
				type : "get",
				url : "sort?sortNum=1",//정렬 번호 1 : 최신순
				dataType : "text",
				data : formData, 
				contentType: false, 
				processData: false, 
				cache : false,
				success : function(data) {
					sortFunc(data); 
				},
				error : function(){
			    	alert("통신실패");
			    }
			});
		
		});
	
		// 인기순 눌렀을때
		$('#radio2').click(function () {
			$.ajax({
			type : "get",
			url : "sort?sortNum=2", // 정렬 번호 2 : 인기순
			dataType : "text",
			data : formData, 
			contentType: false, 
			processData: false, 
			cache : false,
			success : function(data) {
				sortFunc(data); 
			},
			error : function(){
		              alert("통신실패");
		          }
			});
		
		});
	   
	});

	// 정렬된 데이터로 새로 뿌려주기
	function sortFunc(data) {
	  	var html = jQuery('<div>').html(data);
		var contents1 = html.find("div#indexListAjax").html();
		var contents2 = html.find("div#sortNumIdx").html();
		$("#resultList").html(contents1);
		$("#navbarIdx").html(contents2);
	 }

	// 정렬된 상태로 페이징 처리
	// 최신순 + 페이징
	function goPageNum1(data){
		var formData = new FormData();
		$.ajax({
			type : "get",
			url : "sort?sortNum=1&pageNum="+data,
			dataType : "text",
			data : formData, 
			contentType: false, 
			processData: false, 
			cache : false,
			success : function(data) {
				sortFunc(data) 
			},
			error : function(){
	            alert("통신실패");
	        }
		});
	}

	// 인기순 + 페이징
	function goPageNum2(data){
		var formData = new FormData();
		$.ajax({
			type : "get",
			url : "sort?sortNum=2&pageNum="+data,
			dataType : "text",
			data : formData, 
			contentType: false, 
			processData: false, 
			cache : false,
			success : function(data) {
				sortFunc(data) 
			},
			error : function(){
	            alert("통신실패");
	        }
		});
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
			<%} else if (Integer.parseInt(session.getAttribute("userIdx").toString()) == 8) { %>
			<!-- 홈 / 신고관리 / 로그아웃 버튼 -->
				<ul class="nav justify-content-end">
					<li class="nav-item"><a class="nav-link" href="javascript:goMainFunc();"
						style="color: black;">홈</a></li>
					<li class="nav-item"><a class="nav-link" href="report"
						style="color: black;">신고 관리</a></li>
					<li id="logout" class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/"
						style="color: black;">로그아웃</a></li>
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

	<!-- 검색 /인기순 /최신순 -->
	<div class="container" style="height: 50px;">
		<div class="row">
			<!-- 검색바 -->
			<div class="col-sm-5">
				 <form action="search" method="get">
					<div style="float: left; margin-right: 10px;width: 75%">
						<input name="word" class="form-control mr-sm-2" type="text"
							placeholder="Search">
					</div>
					<div style="float: left;">
						<button class="btn btn-dark" type="submit">Search</button>
					</div>
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
	<div class="container" id="resultList">
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
				<c:forEach var="item" items="${list}">
					<%if(session.getAttribute("userIdx")==null){ %>
					<tr onclick="goLogin();" style="cursor:pointer;">
				  	<%}else{ %>
				  	<tr onclick="location.href='${pageContext.request.contextPath}/board?boardIdx=${item.boardIdx}&userIdx=${item.userIdx}'" style="cursor:pointer;">
					<%} %>
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

	<!-- 글작성 버튼 -->
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

	<!-- 페이징 -->
	<div class="container">
		<div id="navbarIdx">
			<nav class="navbar navbar-expand-sm justify-content-center">
				<ul class="navbar-nav">
					<c:forEach var="i" begin="1" end="${allPage}">
					<%if(session.getAttribute("userIdx") == null && ((session.getAttribute("sort") == null) || (Integer.parseInt(session.getAttribute("sort").toString())==1))){%>
						<li class="nav-item"><a class="nav-link" href="javascript:goPageNum1(${i});">${i}</a></li>
					<%} else if(session.getAttribute("userIdx") == null && (Integer.parseInt(session.getAttribute("sort").toString())==2)){%>
						<li class="nav-item"><a class="nav-link" href="javascript:goPageNum2(${i});">${i}</a></li>
					<%} else if(session.getAttribute("userIdx") != null && ((session.getAttribute("sort") == null) || (Integer.parseInt(session.getAttribute("sort").toString())==1))){%>
						<li class="nav-item"><a class="nav-link" href="javascript:goPageNum1(${i});">${i}</a></li>
					<%}	else{%>
						<li class="nav-item"><a class="nav-link" href="javascript:goPageNum2(${i});">${i}</a></li>
					<%}%>
					</c:forEach>
				</ul>
			</nav>
		</div>
	</div>

</body>
</html>
