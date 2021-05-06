<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 ajax</title>
</head>
<body>
  	<div id="reportListAjax">
		<table class="table table-hover">
			 <thead>
				<tr>
					<th style="width: 10%;">no. </th>
					<th style="width: 90%;">접수된 신고</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="item" items="${list}">
				  	<tr onclick="location.href='${pageContext.request.contextPath}/board?boardIdx=${item.boardIdx}&userIdx=${item.userIdx}'" style="cursor:pointer;">
						<td>${item.reportIdx }</td>
						<td>
							${item.reportTitle }<br>
							${item.reportContents }<br>
							<a style="font-size: 13px;"><b>[${item.boardSubject}] ${item.boardTitle }</b></a>
					  	</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
  	</div>
</body>
</html>