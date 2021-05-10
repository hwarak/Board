<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>내 정보</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5	.2/js/bootstrap.min.js"></script>
<script type="text/javascript">

	//홈으로 돌아가기
	function goMainFunc(){
		location.href="main?userIdx="+<%=session.getAttribute("userIdx")%>;
	}

	$(document).ready(function(e){
		
		// 로그아웃
		$('#logout').click(function() {
		 alert("로그아웃되었습니다");
		});
		
		// 내 게시물
		$('#myBoard').click(function() {
		 location.href="myBoard";
		});
		
		// 내 댓글
		$('#myReply').click(function() {
		 location.href="myReply";
		});
		
	});

	// 회원 탈퇴
	function checkDeleteUser(){
		var str = $("#deleteUser").val();
		if(str=="탈퇴하기"){
			var data = {};
			data["userIdx"] = <%=session.getAttribute("userIdx")%>;
			$.ajax({
				type : "delete",
				url : "user",
			    contentType:"application/json;charset=UTF-8",
			    async : true,
				success : function(data) {
					if (data.result == "ok") {
						alert("탈퇴 완료.");
						location.href="${pageContext.request.contextPath}/";
					} 
				},
				error : function(){
	                alert("통신실패");
	            }
			});
		}else{
			alert("다시 작성해주세요");
		}
	}

	// 유저 닉네임 변경
	function checkUpdateUser(){
	
		var data = {};
		data["userNickname"] = $("#updateUser").val();
		$.ajax({
			type : "put",
			url : "user",
			data : JSON.stringify(data),
		    dataType: "json",
		    contentType:"application/json;charset=UTF-8",
		    async : true,
			success : function(data) {
				if (data.result == "ok") {
					alert("닉네임 변경 성공");
					location.href="userInfo";
				} else {
					alert("이미 존재하는 닉네임");
					$("#updateUser").empty();
				}
			},
			error : function(){
	            alert("통신실패");
	        }
		});
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
				<li class="list-group-item list-group-item-action">${userInfo.userNickname}님</li>
				<li class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" id="myBoard">
					내 글 <span class="badge badge-primary badge-pill">${userInfo.myBoard}</span>
				</li>
				<li class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" id="myReply">
					내 댓글 <span class="badge badge-primary badge-pill">${userInfo.myReview}</span>
				</li>
				<li class="list-group-item list-group-item-action" href="#" data-toggle="modal" data-target="#updateUserModal">정보 수정</li>
				<li class="list-group-item list-group-item-action" href="#" data-toggle="modal" data-target="#deleteUserModal">탈퇴</li>
			</ul>
		</div>

	</div>

  <!-- 유저 닉네임 변경 모달 -->
  <div class="modal fade" id="updateUserModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">닉네임 변경</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<div>
        		변경하실 닉네임을 입력하세요
        	</div>
        	<div style="height: 20px;"></div>
          	<div>
          		<input type="text" class="form-control" id="updateUser" required>
          	</div>
          	<div style="height: 20px;"></div>
          	<div>
          	<button type="button" class="btn btn-outline-dark btn-block"
				onclick="checkUpdateUser();">닉네임 변경</button>
          	</div>    	
        </div>
      </div>
    </div>
  </div>	

  <!-- 회원탈퇴 모달 -->
  <div class="modal fade" id="deleteUserModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">회원 탈퇴</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<div>
        		탈퇴하시면 작성한 게시물들과 댓글들이 모두 삭제됩니다<br>
        		확인을 위해 <b>탈퇴하기</b> 를 입력하세요.
        	</div>
        	<div style="height: 20px;"></div>
          	<div>
          		<input type="text" class="form-control" id="deleteUser" required>
          	</div>
          	<div style="height: 20px;"></div>
          	<div>
          	<button type="button" class="btn btn-outline-dark btn-block"
				onclick="checkDeleteUser();">이해했습니다. 탈퇴하겠습니다.</button>
          	</div>       	
        </div>
      </div>
    </div>
  </div>
  
</body>
</html>