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

	function goMainFunc(){
		location.href="main?userIdx="+<%=session.getAttribute("userIdx")%>;
	}

	$(document).ready(function(e){
		   $('#logout').click(function() {
			   alert("로그아웃되었습니다");
		   });
		});

	function deleteBoardFunc(){

		var data = {};
		data["boardIdx"] = ${boardInfo.boardIdx};

		$.ajax({
			type : "delete",
			url : "board",
			data : JSON.stringify(data),
		    dataType: "json",
		    contentType:"application/json;charset=UTF-8",
			async : false,
			success : function(data) {
				
				if (data.result == "ok") {
					alert("삭제 완료.");
					location.href="main?userIdx="+<%=session.getAttribute("userIdx")%>;
				}

			},
			error : function(){
                alert("통신실패");
            }
		});
	}

	// 댓글 등록
	function insertReplyFunc(){
		var data = {};
		
		var replySecretCheck = document.getElementById('replySecret');

		if($(replySecretCheck).prop("checked")){
			data["replySecret"] = 1;
		}else{
			data["replySecret"] = 0;
		}
		
		data["replyContents"] = $("#reply").val();
		data["userIdx"] = <%=session.getAttribute("userIdx")%>;
		data["boardIdx"] = ${boardInfo.boardIdx};
		data["replyRecipient"] = 0;

		$.ajax({
			type : "post",
			url : "reply",
			data : JSON.stringify(data),
		    dataType: "json",
		    contentType:"application/json;charset=UTF-8",
			async : false,
			success : function(data) {
				
				if (data.result == "ok") {
					document.getElementById("reply").value='';
					getList();
				}

			},
			error : function(){
                alert("통신실패");
            }
		});

	}

	function getList(){
		var formData = new FormData();
		$.ajax({
			type : "get",
			url : "reply?boardIdx=${boardInfo.boardIdx}&writer=${boardInfo.userIdx}",
			dataType : "text",
			data : formData, 
			contentType: false, 
			processData: false, 
			cache : false,
			success : function(data) {
				var html = jQuery('<div>').html(data);
				var contents = html.find("div#replyList").html();
				$("#replyList").html(contents);
			},
			error : function(){
                alert("통신실패");
            }
		});
	}
	
		
	
</script>
</head>
<body class="container" style="width: 50%;" >

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
					<li id="logout" class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/"
						style="color: black;">로그아웃</a></li>
				</ul>
			<% } %>
	</div>
	
	<div class="container" style="height: 40px;"></div>
	
	<!-- 게시물 [말머리]제목 -->
	<div class="container" style="height: 60px;">
		<h2>[${boardInfo.boardSubject}] ${boardInfo.boardTitle}</h2>
	</div>

	<div class="container" style="height: 50px;">
		<div class="row">
			<!-- 닉네임/날짜 -->
			<div class="col-sm-6">
				<p>${boardInfo.userNickname} &nbsp|&nbsp ${boardInfo.boardDate} &nbsp|&nbsp조회수 : ${boardInfo.boardViews} 회</p>
			</div>
			
			<!-- 글 수정/삭제/신고 -->
			<div class="col-sm-6">
				<%	if (session.getAttribute("userIdx") == session.getAttribute("writerIdx")) { %>
				<!-- 수정/ 삭제 -->
					<div style="float: right;">
						<button type="button" class="btn btn-dark" onclick="location.href='writeBoard?boardIdx=${boardInfo.boardIdx}'">수정</button>
						<button type="button" class="btn btn-dark" onclick="deleteBoardFunc();">삭제</button>
					</div>
				<% } else { %>
				<!-- 신고하기-->
					<div style="float: right;">
						<button type="button" class="btn btn-dark">신고하기</button>
					</div>
				<% } %>
			
				
			</div>
		</div>
	</div>
	
	<div class="container" style="height: 10px;">
		<hr color="grey" size="10px">
	</div>
	
	<div class="container" style="height: 10px;"></div>
	
	<!-- 게시물 내용 -->
	<div class="container" style="height: 400px;">
		<p>${boardInfo.boardContents}</p>
	</div>
	
	<div class="container" style="height: 10px;">
		<hr color="grey" size="10px">
	</div>
	
	<div class="container" style="height: 10px;"></div>
	
	<!-- 댓글 개수 -->
	<div class="container" style="height: 20px;">
	  <div style="float: left;">
	  	<p style="font-size: 18px;"><b>댓글  ${boardInfo.boardReply}개 </b></p>
	  </div>
	  <!-- 비밀글 체크 -->
	  <div style="float: right;">
	  	<input type="checkbox" class="form-check-input" value="" id="replySecret">비밀글
	  </div>
	</div>
	
	<div class="container" style="height: 20px;"></div>
	
	<div class="container" style="height: 150px;">
		<div class="form-group">
			<textarea class="form-control" rows="2" id="reply" name="reply"></textarea>
		</div>
		<button type="button" class="btn btn-dark btn-block" onclick="insertReplyFunc();">리뷰 등록</button>
	</div>
	
	<!-- 댓글 -->
	<div class="container" id="replyList" >
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
	
	<div class="container" style="height: 100px;"></div>


</body>
</html>