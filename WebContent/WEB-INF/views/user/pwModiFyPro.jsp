<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title>비밀번호 찾기</title>

<c:if test="${result == 1}">
	<script>
		alert("수정이 되었습니다");
		window.location="/petBill/user/main.pet";
	</script>
</c:if>
<c:if test="${result == 0}">
	<script>
		alert("기존 비밀번호가 다릅니다");
		history.go(-1);
	</script>
</c:if>
<c:if test="${result == 2}">
	<script>
		alert("새비밀번호가 다릅니다");
		history.go(-1);
	</script>
</c:if>

</head>
<body>

</body>
</html>