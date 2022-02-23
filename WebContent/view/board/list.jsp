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
String boardid = "";
int pageInt = 1;//현재 페이지를 의미
int limit = 10; //한 페이지당 몇 게시글?

//boardid  (게시판 여러개잖아)----------------
if(request.getParameter("boardid")!=null) {  
	session.setAttribute("boardid", request.getParameter("boardid")); 
	session.setAttribute("pageNum", "1");  //이걸 안하면 공지사항-3페이지에서 자유게시판 누르면 자유게시판 3페이지로 넘어감
}

boardid = (String)session.getAttribute("boardid");

if(boardid==null) { 
	boardid ="1";
}


		
		

//3페이지에서 작업끝내면 3페이지로 돌아오게 할려고 -pageNum이 파라미터로 넘어왔을때만 세션으로 저장한다 
if(request.getParameter("pageNum")!=null){  //pageNum이 있으면 
	session.setAttribute("pageNum", request.getParameter("pageNum")); //그거 받아서 세션으로 저장해라 
}

String pageNum = (String)session.getAttribute("pageNum");	//pageNum은 세션값을 받아라 	
if(pageNum==null) { //pageNum값(세션값)이 없으면 자동으로 1페이지로 가게해라 
	pageNum ="1";
}

pageInt =Integer.parseInt(pageNum); //pageInt는 pageNum값을 int로 변환한 값 - 현재 페이지를 의미









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


String boardName="공지사항";
switch(boardid) {
case "3" : boardName="QnA"; break;
case "2" : boardName = "자유게시판"; break;
}

%>
<hr>
	<!-- table list start -->
	<div class="container">
	
	<!-- pageInt가 바뀌는 건 pagination에서 pageNum을 받기 때문 // boardid가 바뀌는건 head에서 바뀌도록 해놓아서 -->
		<h2  id="center"><%=boardName %>[<%=pageInt %>]-[<%=boardid %>]</h2> 
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
					
					<td>
					<% if(b.getReflevel() > 0) { %>
					<img src = "<%=request.getContextPath()%>/image/level.gif" width = "<%=7*b.getReflevel()%>">
					<img src = "<%=request.getContextPath()%>/image/re.gif">
				 	<% } %>
					<a href ="boardInfo.jsp?num=<%=b.getNum()%>"><%=b.getSubject() %></a></td>
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