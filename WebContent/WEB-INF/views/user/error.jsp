<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<!--1. 부트스트랩 css 사용 -->
    <link href="/petBill/resources/css/styles.css" rel="stylesheet" type="text/css">	

</head>
<body>
	<br /><br /><br /><br /><br /><br />
	<div id="title" align="center">
        <h3>error</h3>
          <p class="lead">
          	잘못된 접근입니다.
          </p>
        <img src="/petBill/resources/imgs/error.gif">
        <br /><br />
		<button onclick="window.location='/petBill/user/main.pet'" class="btn btn-dark">메인으로</button>
	</div>
</body>
</html>