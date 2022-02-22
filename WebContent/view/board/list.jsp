<%@page import="java.util.List"%>
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
String boardid = "1";
int pageInt = 1;//현재페이지를 의미
int limit = 3; //한 페이지당 몇 게시글?
		
try {	
pageInt = Integer.parseInt(request.getParameter("pageNum"));
} catch(Exception e) { //페이지가 안 넘어오면 1페이지로 가라
	pageInt = 1;
} 
		


BoardDao bd = new BoardDao();
int boardcount = bd.boardCount(boardid);

 
List<Board> list = bd.boardList(pageInt, limit, boardcount,boardid);



int boardnum = boardcount - limit*(pageInt-1);
/* 
-- 1 p --> 15 ~ --- count     
-- 2 p --> 12 ~ --- count - limit*1
-- 3 p --> 9 ~ ---count - limit*2
*/
int bottomLine = 3;
int startPage = (pageInt-1)/bottomLine * bottomLine + 1; //1
int endPage = startPage + bottomLine-1; //3
int maxPage = (boardcount / limit) + (boardcount % limit == 0? 0:1); 
if(endPage > maxPage) endPage = maxPage;

/* 밑에 페이지 버튼 
-- 1 p --> startpage = 1 --- 1 2 3 
-- 2 p --> startpage = 1
-- 3 p --> startpage = 1
-- 4 p --> startpage = 4 --- 4 5 6 
-- 5 p --> startpage = 4
-- 6 p --> startpage = 4
startpage = (p-1)/3*3+1
*/





%>
<hr>
	<!-- table list start -->
	<div class="container">
		<h2  id="center">게시판 리스트[<%=pageInt %>]</h2>
		<p align ="right">
		<% if(boardcount > 0) { %>
			글 개수: <%=boardcount %>
		 <%} else { %>
		 등록된 게시물이 없습니다 
		<% } %>
		</p>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
					<th>파일</th>
					<th>조회수</th>

				</tr>
			</thead>
			<tbody>
			<%
				for (Board b : list) {
			%>
				<tr>
					<td><%=(boardnum--) %></td>
					<td><a href ="boardInfo.jsp?num=<%=b.getNum()%>"><%=b.getSubject() %></a></td>
					<td><%=b.getWriter() %></td>
					<td><%=b.getRegdate() %></td>
					<td><%=b.getFile1() %></td>
					<td><%=b.getReadcnt() %></td>
				</tr>
			<% } %>
			</tbody>
		</table>
			<p align="right"><a href ="<%=request.getContextPath() %>/view/board/writeForm.jsp">게시판입력</a></p>
		<div class="container"  >
		<ul class="pagination justify-content-center"  >
		
		
   <li class="page-item <% if(startPage <= bottomLine) { %>disabled<%} %>"><a class="page-link" href="list.jsp?pageNum=<%=startPage-bottomLine%>">Previous</a></li>
 	<%for (int i = startPage ; i <= endPage; i++) { %>
  <li class="page-item <% if(i==pageInt) { %> active <%}%>"><a class="page-link" href="list.jsp?pageNum=<%=i%>"><%=i %></a></li>
 <%} %>
  <li class="page-item <% if(endPage >= maxPage) { %> disabled <%}%>"><a class="page-link" href="list.jsp?pageNum=<%=startPage+bottomLine%>">Next</a></li>
 
</ul> </div>
	</div>
</body>
</html>