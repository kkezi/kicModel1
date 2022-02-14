<%@page import="service.MemberDao"%>
<%@page import="model.Member"%>
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
String msg = "";
String url = "";
String login = (String)session.getAttribute("memberId");


if(login == null || login.trim().equals("")) {//로그인 불가하면~

%>
<script>
alert("로그인이 필요합니다")
location.href="<%=request.getContextPath()%>/view/member/loginForm.jsp";
</script>

<% } else {  //로그인 가능하면
	String pass = request.getParameter("pass");
	
	
	MemberDao md = new MemberDao();
	Member mb = md.selectOne(login);
	
	if(mb.getPass().equals(pass)) { //비밀번호가 확인되면
		int num = md.deleteMember(login);
		
		if(num==0) { //delete가 안된 상태
			msg = login+"님의 탈퇴 오류발생";
			url = request.getContextPath()+"/view/main.jsp";
			
		} else { //delete가 된 상태 
			session.invalidate();
			msg = login+"님 탈퇴되었습니다";
			url = request.getContextPath()+"/view/main.jsp";
		}
		
		
		
		
	} else { //비밀번호가 확인이 안되면
		msg = "비밀번호가 맞지 않습니다 ";
		url = request.getContextPath()+"/view/member/deleteForm.jsp";
	}
	
} %>
<script>
alert("<%=msg%>");
location.href ="<%=url%>";

</script>
</body>
</html>