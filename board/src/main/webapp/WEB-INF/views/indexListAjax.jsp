<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페이징처리 ajax</title>
</head>
<body>
	<!-- 게시물 리스트 -->
	<div id="indexListAjax">
		<table class="table table-hover">
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

	<!-- 페이지 -->
	<div id="sortNumIdx">
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
</body>
</html>