<%@page import="model.Member"%>
<%@page import="service.MemberDao"%>
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
String url="";
String msg ="";
String login = (String)session.getAttribute("memberId");

//로그인 불가하면 변경못하게 해야하니까 ~
if(login == null || login.trim().equals("")) {

%>
<script>
alert("로그인이 필요합니다")
location.href="<%=request.getContextPath()%>/view/member/loginForm.jsp";
</script>

<% } else { 
	MemberDao md = new MemberDao();
	Member mem = md.selectOne(login); //id로 갖고와야해서 
	String pass = request.getParameter("pass");
	String newpass = request.getParameter("newpass");
	
	
	
	if(pass.equals(mem.getPass())) {// 기존 비번과 비번변경창에서 입력한 비번이 같으면 비번 새로 변경해야지 ~
		//스트링은 객체니까 equals로 비교하는게 안전 
		if(md.changePass(login, newpass) > 0) { //changePass메서드에서 정상적으로 변경성공시
			msg ="비밀번호가 수정되었습니다";
			url="main.jsp";
		} else { // db에서 오류나서 변경실패시, 0이 뜰때 
			msg = "비밀번호 변경 오류가 발생되었습니다";
			url = "main.jsp";
		}
		
		
	} else { //비밀번호 확인이 안될때 
		msg = "비밀번호가 현재 비밀번호와 다릅니다";
		url="member/passwordForm.jsp";
	}
	
	


} %>
<script>
alert("<%=msg%>");
location.href ="<%=request.getContextPath()%>/view/<%=url%>";
</script>
</body>
</html>