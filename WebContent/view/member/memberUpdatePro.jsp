
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
	int num = 0;//-----memberUpdate(mem)때문에 생긴 변수 -왜?update 타입 int여서 
//세션이 없으면 작업 못하게 해야 하니까 세션있는지 확인 한번 해주기
String login = (String)session.getAttribute("memberId");
	
//수정 못할때 떠야할 메세지와 url
String msg = "비밀번호가 다릅니다. 확인 후 다시 입력하세요";
String url = request.getContextPath() +"/view/member/memberUpdate.jsp";


//로그인 불가하면~
if(login == null || login.trim().equals("")) {
%>
<script>
alert("로그인이 필요합니다")
location.href="<%=request.getContextPath()%>+"/view/member/loginForm.jsp";
</script>

<%
	} else { 
//로그인 가능하면~
		//여기는 memberUpdate의 name명 가져오기
String tel =request.getParameter("tel");
String email = request.getParameter("email");
String pass= request.getParameter("pass");

//로그인 되어있을때 수정해야하니까 로그인 된 정보를 가져와야지
MemberDao md = new MemberDao();
//id가 없으면 null, 있으면 mem return 
Member mem = md.selectOne(login);

//member에 tel,email을 저장
mem.setTel(tel);
mem.setEmail(email);



if(mem.getPass().equals(pass)) {
	
	num = md.memberUpdate(mem);
	msg ="회원정보 수정되었습니다";
	url = request.getContextPath()+"/view/main.jsp";
} 
}


%>
<script>
alert("<%=msg%>");
location.href ="<%=url%>";
</script>
</body>
</html>