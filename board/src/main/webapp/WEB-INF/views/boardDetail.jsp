<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>게시물</title>
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

	// 게시물 삭제
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

	// 댓글 삭제
	function deleteReply(replyIdx){

		var data = {};

		data["boardIdx"] = ${boardInfo.boardIdx};
		data["replyIdx"] = replyIdx;

		$.ajax({
			type : "delete",
			url : "reply",
			data : JSON.stringify(data),
		    dataType: "json",
		    contentType:"application/json;charset=UTF-8",
			async : false,
			success : function(data) {
				
				if (data.result == "ok") {
					getList();
				}

			},
			error : function(){
                alert("통신실패");
            }
		});
		
		
	}
	
	//댓글 등록 & 댓글 삭제 했을때 리스트 새로 뿌려주기
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
				var contents1 = html.find("div#replyList").html();
				var contents2 = html.find("div#replyCount").html();
				$("#replyList").html(contents1);
				$("#replyCount").html(contents2);
			},
			error : function(){
                alert("통신실패");
            }
		});
	}

	// 신고 등록하기
	function reportBoard(){

		var data = {};
		
		data["boardIdx"] = ${boardInfo.boardIdx};
		data["userIdx"] = <%=session.getAttribute("userIdx")%>;
		data["reportSubject"] = $("#reportSubject option:selected").val();
		data["reportTitle"] = $("#reportTitle").val();
		data["reportContents"] = $("#reportContents").val();

		$.ajax({
			type : "post",
			url : "report",
			data : JSON.stringify(data),
		    dataType: "json",
		    contentType:"application/json;charset=UTF-8",
			async : false,
			success : function(data) {
				if (data.result == "ok") {
					alert("신고가 접수되었습니다.")
				}
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
	
	<!-- 게시물 [말머리]제목 -->
	<div class="container" style="height: auto;">
		<h2>[${boardInfo.boardSubject}] ${boardInfo.boardTitle}</h2>
	</div>
	
	<div class="container" style="height: 10px;">

	<!-- 게시물 정보 -->
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
				<% } else if(Integer.parseInt(session.getAttribute("userIdx").toString())==8) { %>
				<!-- 신고하기-->
					<div style="float: right;">
						<button type="button" class="btn btn-dark" onclick="deleteBoardFunc();">삭제</button>
					</div>
				<% } else { %>
				<!-- 신고하기-->
					<div style="float: right;">
						<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#report">신고하기</button>
					</div>
				<% } %>
			</div>
		</div>
	</div>
	
	<!-- 구분선 -->
	<div class="container" style="height: 10px;">
		<hr color="grey" size="10px">
	</div>
	
	<div class="container" style="height: 10px;"></div>
	
	<!-- 게시물 내용 -->
	<div class="container" style="height: auto;">
		<p>${boardInfo.boardContents}</p>
	</div>
	
	<!-- 구분선 -->
	<div class="container" style="height: 10px;">
		<hr color="grey" size="10px">
	</div>
	
	<div class="container" style="height: 10px;"></div>
	
	<!-- 댓글 -->
	<div class="container" style="height: 20px;">
	  <!-- 댓글 개수 -->
	  <div style="float: left;" id="replyCount">
	  	<p style="font-size: 18px;"><b>댓글  ${boardInfo.boardReply}개 </b></p>
	  </div>
	  <!-- 비밀글 체크 -->
	  <div style="float: right;">
	  	<input type="checkbox" class="form-check-input" value="" id="replySecret">비밀글
	  </div>
	</div>
	
	<div class="container" style="height: 20px;"></div>
	
	<!-- 리뷰 작성 -->
	<div class="container" style="height: 150px;">
		<div class="form-group">
			<textarea class="form-control" rows="2" id="reply" name="reply"></textarea>
		</div>
		<button type="button" class="btn btn-dark btn-block" onclick="insertReplyFunc();">리뷰 등록</button>
	</div>
	
	<!-- 댓글 리스트 -->
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
									    <a class="nav-link" href="javascript:deleteReply(${item.replyIdx});">삭제</a>
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
									    <a class="nav-link" href="javascript:deleteReply(${item.replyIdx});">삭제</a>
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
									    <a class="nav-link" href="javascript:deleteReply(${item.replyIdx});">삭제</a>
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
	
	<!-- 신고하기 modal -->
	<div class="modal fade" id="report">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	    
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">게시물 신고하기</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      
	      <!-- Modal body -->
	      <div class="modal-body">
	        
	        <!-- 말머리 선택 -->
			<div class="form-group">
				<div class="row">
					<div class="col-sm-2">
						<label for="title">종류</label>
					</div>
					<div class="col-sm-10">
						<select class="form-control" id="reportSubject" name="reportSubject">
					        <option>폭력적 또는 혐오스러운 콘텐츠</option>
					        <option>성적인 콘텐츠</option>
					        <option>증오 또는 악의적인 콘텐츠</option>
					        <option>유해하거나 위험한 콘텐츠</option>
					        <option>테러 조장</option>
					        <option>스팸 또는 오해의 소지가 있는 콘텐츠</option>
					        <option>권리 침해</option>
					      </select>
					</div>
				</div>
			</div>
		
			<!-- 신고 제목 -->
			<div class="form-group">
				<div class="row">
					<div class="col-sm-2">
						<label for="title">제목</label>
					</div>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="reportTitle"
							placeholder="Enter title" name="reportTitle" required>
					</div>
				</div>
			</div>
			
			<!-- 신고 내용 -->
			<div class="form-group">
				<textarea class="form-control" rows="10" id="reportContents" name="reportContents"></textarea>
			</div>
			
			<!-- 버튼 -->
			<button type="button" class="btn btn-outline-dark btn-block"
				onclick="reportBoard();">신고하겠습니다.</button>
          	</div>

	      </div>
	      
	    </div>
	  </div>
	</div>

</body>
</html>