<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function inputChk(f) {
	/*원래는 현재비밀번호가 다르면 변경안되게 해야하는데 아직 submit 데이터 전송 제출을 안했는데 
	입력만 한 상태에서 비교할수는 없다 ---- 이거는 db에서 작업하기 
	*/
	
	if(f.pass.value=='') {
		alert("현재 비밀번호를 입력하세요")
		f.pass.focus()//자동으로 마우스셋팅
		return false;
	} 
	if(f.newpass.value==''){
		alert("새로운 비밀번호를 입력하세요")
		f.newpass.focus()
		return false;
	}
	
	if(f.newpass.value != f.newpass2.value) {
		alert("새로운 비밀번호가 확인되지 않았습니다")
		f.newpass2.value =""
		f.newpass2.focus()
		return false
	}
	
	if(f.newpass.value == f.pass.value) {
		alert("같은 비밀번호는 사용할수 없습니다")
		f.newpass.value =""
		f.newpass.focus()
		return false
	}
	
	return true;
}



</script>
</head>
<body>
<%

String login = (String)session.getAttribute("memberId");

//로그인 불가하면~
if(login == null || login.trim().equals("")) {

%>
<script>
alert("로그인이 필요합니다")
location.href="<%=request.getContextPath()%>/view/member/loginForm.jsp";
</script>

<% } else { %>
<hr>
	<!-- passwd start -->
	<div class="container">
		<h2   id="center">비밀번호 변경</h2>
		<!-- submit하면 데이터 deletePro로 보내기 -->
		<form action="<%=request.getContextPath() %>/view/member/passwordPro.jsp" method ="post"
		 name = "f" onsubmit="return inputChk(this)">
		<div class="form-group">
			<label>ID:</label> <input type="text"
				class="form-control" name= "id" readonly ="readonly" value ="<%=login %>"> 
				
				<label>현재 비밀번호:</label>
			<input type="password" class="form-control" name="pass">
				<label>변경 비밀번호:</label>
			<input type="password" class="form-control" name="newpass">
				<label>변경 비밀번호 확인:</label>
			<input type="password" class="form-control" name="newpass2">
			
		</div>
		<div id="center" style="padding: 3px;">
			<button type="submit" class="btn btn-dark">비밀번호 변경</button>
		</div>
		</form>
	</div>






<% } %>

</body>
</html>