<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="replyList">
	<ul class="list-group">
	  	<c:forEach var="item" items="${list}">
	  		<li class="list-group-item">
	  		<c:choose>
	  			<c:when test="${compare eq 1}">
	  				<c:if test="${item.compare eq 1}">
	  					<div>
							<div style="height:30px;">
								<div style="float: left;">
				  					<c:if test="${item.replySecret eq 1}">
				  						${item.userNickname} (비밀)
				  					</c:if>
				  					<c:if test="${item.replySecret eq 0}">
				  						${item.userNickname}
				  					</c:if>	
								</div>
								<div style="float: right;">
									<ul class="nav">
									  <li class="nav-item">
									    <a class="nav-link" href="#">수정</a>
									  </li>
									  <li class="nav-item">
									    <a class="nav-link" href="#">삭제</a>
									  </li>
									</ul>
								</div>
							</div>
							<div style="height: 20px;"></div>
					    	<div style="height:60px;">
					    		${item.replyContents}
					    	</div>
				    	</div>
	  				</c:if>
	  				
	  				<c:if test="${item.compare eq 0}">
	  					<div>
							<div style="height:30px;">
								<div style="float: left;">
				  					<c:if test="${item.replySecret eq 1}">
				  						${item.userNickname} (비밀)
				  					</c:if>
				  					<c:if test="${item.replySecret eq 0}">
				  						${item.userNickname}
				  					</c:if>	
								</div>
								<div style="float: right;">
									<ul class="nav">
									  <li class="nav-item">
									    <a class="nav-link" href="#">삭제</a>
									  </li>
									</ul>
								</div>
							</div>
							<div style="height: 20px;"></div>
					    	<div style="height:60px;">
					    		${item.replyContents}
					    	</div>
				    	</div>
	  				</c:if>
	  				
	  			</c:when>
	  			
	  			<c:when test="${compare eq 0}">
	  				
	  				<c:if test="${item.compare eq 1}">
	  					<div>
							<div style="height:30px;">
								<div style="float: left;">
				  					<c:if test="${item.replySecret eq 1}">
				  						${item.userNickname} (비밀)
				  					</c:if>
				  					<c:if test="${item.replySecret eq 0}">
				  						${item.userNickname}
				  					</c:if>	
								</div>
								<div style="float: right;">
									<ul class="nav">
									  <li class="nav-item">
									    <a class="nav-link" href="#">수정</a>
									  </li>
									  <li class="nav-item">
									    <a class="nav-link" href="#">삭제</a>
									  </li>
									</ul>
								</div>
							</div>
							<div style="height: 20px;"></div>
					    	<div style="height:60px;">
					    		${item.replyContents}
					    	</div>
				    	</div>
	  				</c:if>
	  				
	  				<c:if test="${item.compare eq 0}">
	  					<c:if test="${item.replySecret eq 1}">
	  						<div style="height: 30px;"> 비밀글입니다.</div>
	  					</c:if>
	  					<c:if test="${item.replySecret eq 0}">
	  						<div>
								<div style="height:30px;">
									<div style="float: left;">
										${item.userNickname}	
									</div>
								</div>
								<div style="height: 20px;"></div>
						    	<div style="height:60px;">
						    		${item.replyContents}
						    	</div>
					    	</div>
	  					</c:if>
	  				</c:if>
	  				
	  			</c:when>
	  		</c:choose>
	    	</li>
		</c:forEach>
	  </ul>
</div>
</body>
</html>