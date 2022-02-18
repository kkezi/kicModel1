<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<hr>
	<!-- table list start -->
	<div class="container">
		<h2  id="center">게시판 리스트</h2>
		<p align="right"><a href ="<%=request.getContextPath() %>/view/board/writeForm.jsp">게시판입력</a></p>

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
				<tr>
					<td>John</td>
					<td>Doe</td>
					<td>john@example.com</td>
					<td>john@example.com</td>
					<td>john@example.com</td>
					<td>john@example.com</td>
				</tr>
				<tr>
					<td>John</td>
					<td>Doe</td>
					<td>john@example.com</td>
					<td>john@example.com</td>
					<td>john@example.com</td>
					<td>john@example.com</td>
				<tr>
					<td>John</td>
					<td>Doe</td>
					<td>john@example.com</td>
					<td>john@example.com</td>
					<td>john@example.com</td>
					<td>john@example.com</td>
				</tr>
			</tbody>
		</table>
		<div class="container"  >
		<ul class="pagination justify-content-center"  >
   <li class="page-item disabled "><a class="page-link" href="#">Previous</a></li>
  <li class="page-item"><a class="page-link" href="#">1</a></li>
  <li class="page-item active"><a class="page-link" href="#">2</a></li>
  <li class="page-item"><a class="page-link" href="#">3</a></li>
  <li class="page-item"><a class="page-link" href="#">Next</a></li>
 
</ul> </div>
	</div>
</body>
</html>