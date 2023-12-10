
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
try{
	
String username= request.getParameter("username");
String pwd = request.getParameter("password");

QueryManager query= new QueryManager();
ResultSet rs = query.authenticate(username,pwd);
if (rs.next()) {
session.setAttribute("user", username); // the username will be stored in the session
out.println("welcome " + username);
out.println("<a href='logout.jsp'>Log out</a>");
response.sendRedirect("success.jsp");
} else {
out.println("Invalid password <a href='login.jsp'>try again</a>");
}
}
catch (Exception e){
	out.print(e);
}
%>