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
board.setFile1(multi.getFilesystemName("file1"));
board.setIp(request.getLocalAddr());

//board setting
String boardid = (String)session.getAttribute("boardid");//저장된 boardid를 가져온다
if(boardid==null) boardid = "1";
board.setBoardid(boardid);

BoardDao bd = new BoardDao();

//새 게시글인 경우
board.setNum(bd.nextNum());//db에서 다음 번호 읽음
board.setRef(board.getNum());


int num = bd.insertBoard(board);



String msg = "게시물 등록 실패 ㅠㅠ";
String url = "writeForm.jsp";
if(num ==1) {
	msg="게시물 등록 성공";
	url="list.jsp?pageNum=1"; 
	//?pageNum을 안 쓰면 1페이지로 안 넘어가고 보던 페이지가 나옴  - session에 저장된 값 때문에
	// 근데 게시글을 입력했으면 게시글이 잘 들어갔는지 최근 페이지를 보여줘야지
} 
%>
<script>
alert('<%=msg%>')
location.href ="<%=url%>"
</script>
</body>
</html>