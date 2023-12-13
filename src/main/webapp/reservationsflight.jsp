<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Flight Number</title>
</head>
<body>
<%

out.print("<form action='reservationsflight2.jsp'>");
out.print("<input type='String' name='flightNumber'>");
out.print("<input type='submit' value ='submit'>");
out.print("</form>");

%>
</body>
</html>
