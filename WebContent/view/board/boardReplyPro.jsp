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
request.setCharacterEncoding("UTF-8"); //전에는 multipart에서 했었지 지금은 multi 안 쓰잖아
BoardDao bd = new BoardDao();
Board board = new Board();

board.setWriter(request.getParameter("writer"));
board.setPass(request.getParameter("pass"));
board.setSubject(request.getParameter("subject"));
board.setContent(request.getParameter("content"));
board.setFile1(""); //답글은 파일첨부 안할거야
board.setIp(request.getLocalAddr());


//boardid setting 
String boardid = (String)session.getAttribute("boardid"); //저장된 boardid를 가져온다
if(boardid==null) boardid = "1";
board.setBoardid(boardid);

int num = Integer.parseInt(request.getParameter("num"));
int ref = Integer.parseInt(request.getParameter("ref"));
int reflevel = Integer.parseInt(request.getParameter("reflevel")); //들여쓰기
int refstep = Integer.parseInt(request.getParameter("refstep"));


String msg = "답변 등록시 오류발생";
String url ="boardReplyForm.jsp?num="+num;



bd.refStepAdd(ref,refstep);

board.setNum(bd.nextNum());
board.setRef(ref);//원래의 새 글 ref--기준글
board.setReflevel(reflevel+1);//기준글의 레벨보다는 +1 ---답글의 답글의 답글 ... 
board.setRefstep(refstep+1); // 답글의 순서

if(bd.insertBoard(board)>0) {
	msg = "답변 등록 완료";
	url = "list.jsp";
}






%>
</body>
<script>
alert('<%=msg%>')
location.href ="<%=url%>"
</script>
</html>