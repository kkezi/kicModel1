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

board.setNum(Integer.parseInt(multi.getParameter("num"))); //hidden으로 보낸 num 받기  모든 파라미터는  스트링 인데 setnum은 int니까  Integer로 바꿔준다
//board.setWriter(multi.getParameter("writer")); readonly해서
board.setPass(multi.getParameter("pass"));
board.setSubject(multi.getParameter("subject"));
board.setContent(multi.getParameter("content"));
board.setFile1(multi.getFilesystemName("file1"));

BoardDao bd = new BoardDao();

//파일 수정시 수정이 발생하지 않을 경우 ---원래파일을 file2에 넣는다
if(board.getFile1()==null || board.getFile1().equals("")) {
	board.setFile1(multi.getParameter("file2"));
}

Board dbboard = bd.boardOne(board.getNum()); // dboard를 board로 쓰지 마 둘은 달라야해 비번을 확인해야해서 ~

String msg = "비밀번호가 다릅니다.";
String url = "boardUpdateForm.jsp?num="+board.getNum();

//비번이 똑같으면 수정할 수 있게 하자
if(board.getPass().equals(dbboard.getPass())) { //수정할 때 비번이 기존의 비번과 같은지 확인 
	if(bd.boardUpdate(board)>0) { //수정이 잘 되면 
		msg ="수정완료";
		url = "boardInfo.jsp?num="+board.getNum();
	} else { //수정이 dao에서 안 넘어오면
		msg ="수정 실패";
	}
	
	
}

%>
<script>
alert('<%=msg%>');
location.href="<%=url%>";
</script>
</body>
</html>