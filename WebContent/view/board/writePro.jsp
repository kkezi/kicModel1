<%@page import="service.BoardDao"%>
<%@page import="model.Board"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
String path = application.getRealPath("/")+"/boardupload/";
int size = 10*1024*1024;
MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8");
Board board = new Board();

board.setWriter(multi.getParameter("writer"));
board.setPass(multi.getParameter("pass"));
board.setSubject(multi.getParameter("subject"));
board.setContent(multi.getParameter("content"));
board.setFile1(multi.getParameter("file1"));

board.setIp(request.getLocalAddr());
board.setBoardid("1");

BoardDao bd = new BoardDao();
int num = bd.insertBoard(board);

String msg = "게시물 등록 실패 ㅠㅠ";
String url = "writeForm.jsp";
if(num ==1) {
	msg="게시물 등록 성공";
	url="list.jsp";
} 
%>
<script>
alert('<%=msg%>')
location.href ="<%=url%>"
</script>
</body>
</html>