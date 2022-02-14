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
String login = (String) session.getAttribute("memberId");
session.invalidate();//현재 클라이언트와 연결된 것을 다 종료시키는 메서드

%>
<script>
alert("<%=login%>님이 로그아웃되었습니다");
location.href = "<%=request.getContextPath()%>/view/member/loginForm.jsp";
</script>
</body>
</html>