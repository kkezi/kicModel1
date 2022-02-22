<%@page import="model.Board"%>
<%@page import="service.BoardDao"%>
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
int num =Integer.parseInt(request.getParameter("num"));
String pass = request.getParameter("pass");

BoardDao bd = new BoardDao();
Board b = bd.boardOne(num);//게시글번호에 해당하는 비번이 맞는지 아닌지 맞춰볼려고

//기본으로 비번이 다르다고 가정 
String msg = "비밀번호가 틀렸습니다";
String url = "boardDeleteForm.jsp?num="+num;

//비밀번호 같으면 ~
if(pass.equals(b.getPass())) {
	if(bd.boardDelete(num)>0) { //삭제가 제대로 되면
		msg = "게시글이 삭제되었습니다.";
		
	} else { //삭제가 dao에서 안 될때 
		msg ="게시글 삭제를 할 수 없습니다"; //dao문제 
		
	}
	
	url = "list.jsp";
}



%>
<script>
alert('<%=msg%>');
location.href ='<%=url%>';
</script>

</body>
</html>