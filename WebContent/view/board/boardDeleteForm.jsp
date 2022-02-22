<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
int num = Integer.parseInt(request.getParameter("num"));



%>




<hr>
	<!-- delete start -->
	<div class="container">
		<h2   id="center">게시물 삭제</h2>
		<!-- submit하면 데이터 Pro로 보내기 -->
		<form action="<%=request.getContextPath() %>/view/board/boardDeletePro.jsp" method ="post">
		<div class="form-group">
			<input type="hidden" name="num" value="<%=num%>"><label>Password:</label>
			<input type="password" class="form-control" name="pass">
		</div>
		<div id="center" style="padding: 3px;">
			<button type="submit" class="btn btn-dark">삭 제</button>
		</div>
		</form>
	</div>
</body>
</html>