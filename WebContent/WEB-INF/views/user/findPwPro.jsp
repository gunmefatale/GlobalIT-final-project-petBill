<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
	<c:if test="${pw != null}">
		<script>
			alert("비밀번호는 ${pw} 입니다");
			window.location = "loginForm.pet";
		</script>
	</c:if>
	<c:if test="${pw == null}">
		<script>
			alert("일치하지 않습니다 다시 확인해주세요");
			history.go(-1);
		</script>
	</c:if>



<body>
</body>
</html>