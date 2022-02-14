<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 파일 업로드하기위해서는 enctype = multipart/form-data 가 꼭 있어야함 -->
<form action ="pictureImg.jsp" method="post" enctype="multipart/form-data"> 
<input type = "file" name = "picture">
<input type = "submit" value = "사진등록">
</form>

</body>
</html>