<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Monthly Sales Report</title>
</head>
<body>
<%
out.print("<form action='sales2.jsp'>");
out.print("<input type='String' name='month'>");
out.print("<input type = 'String' name = 'year'>");
out.print("<input type='submit' value ='submit'>");
out.print("</form>");

%>
</body>
</html>
