<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<script type="text/javascript">
  function handleSubmit()
  {
	 const keyword = document.getElementById('query').value;
  }
</script>

<html>
<head>
<meta charset="UTF-8">
<title>Search Questions and Answers</title>
</head>
<body>

<h1>Search Questions and Answers</h1>

<!-- Search form -->
<form action="searchresults.jsp" method="get">
    <label for="query">Enter your search query:</label><br>
    <input type="text" id="query" name="query" required><br><br>
    <input type="submit" value="Search">
</form>

</body>
</html>
