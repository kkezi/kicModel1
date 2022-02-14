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
<!-- 
1) upload 폴더를 만든다 ("백슬래쉬 자체는 web-content를 의미한다"/upload)
- 왜 폴더를 따로 만드냐면? 
view 밑에 파일들은 web.xml에 의해서 head가 자동으로 include되어서 나오니까 head를 안나오게 할려고 view 밖에 파일을 하나 만드는 것) 

2) 업로드한 사진의 경로는 
C:\webworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\kicModel1\upload
-->
<%
String path = application.getRealPath("/")+"upload/";
String filename = null;

//cos.jar에 의해서 MultipartRequest 연결가능    //ojdc6.jar파일은 db와 자바를 연결해주는 파일 connection위해서 필요
MultipartRequest multi = new MultipartRequest(request, path, 10*1024*1024,"utf-8");
//form의 파일이름 name = ? 가져오기 
filename = multi.getFilesystemName("picture");
%>
<script>
//memberInput에서 사진의 id
const img = opener.document.querySelector("#pic");
//=opener.document.getElementById("pic") 사용도 가능

img.src = "<%=request.getContextPath()%>/upload/<%=filename%>";
opener.document.f.picture.value = "<%=filename%>";
self.close();
</script>

</body>
</html>