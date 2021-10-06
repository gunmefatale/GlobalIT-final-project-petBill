<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
 
</head>
<body>

	<c:if test="${result == 1}">
		<script>
			alert("수정 되었습니다");
			window.location="userMypage.pet";
		</script>
	</c:if>
	<c:if test="${result != 1}">
		<script>
			alert("다시 시도해 주세요");
			history.go(-1);
		</script>
	</c:if>
	
</body>
</html>