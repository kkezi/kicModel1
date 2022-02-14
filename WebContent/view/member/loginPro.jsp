
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
	//login form에서 보낸 데이터 name으로 받기
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
String pass = request.getParameter("pass");

//MemberDao에 있는 selectOne메서드 사용하기 ----MemberDao에서 selectOne메서드 만들러가자
//MemberDao 객체 하나 만들고 ↓
MemberDao md = new MemberDao();

//selectOne메서드 사용 ↓ 해서 로그인 정보가 같은지 확인할거야 
Member mem = md.selectOne(id);
String msg = " 아이디를 확인하세요";
String url = request.getContextPath()+"/view/member/loginForm.jsp";

//id가 없으면 null print되고, 있으면 mem이 프린트 될것
//id가 존재할때----1)비번도 동일 2)비번이 다르다
if (mem != null) {
	if(pass.equals(mem.getPass())) {
		//id도 있고 pass도 동일-로그인 성공
		session.setAttribute("memberId", id);
		
		msg = mem.getName()+"님이 로그인 하셨습니다.";
		//로그인 성공 후 메인페이지로 보내기
		url = request.getContextPath() +"/view/main.jsp";
		
	} else {
		//id는 있는데 pass가 다르다
		msg = "비밀번호를 확인하세요";
		
	}
	
	
}



%>
<!-- 받은 데이터 화면에 찍기 -->
<script>
alert("<%=msg%>");
location.href ="<%=url%>";

</script>


</body>
</html>