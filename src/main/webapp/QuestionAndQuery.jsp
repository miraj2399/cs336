QueryManager query= new QueryManager();
		ResultSet rs = query.findQuestions();
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%@ page import="java.text.*" %>
<!DOCTYPE html>
<%
String repUsername = (String) session.getAttribute("user");
if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%}
%>
<% 
try{
	String question = request.getParameter("question");
	String user = repUsername;
				
		QueryManager query= new QueryManager();
		query.askQuestion(question, user);	
		response.sendRedirect("customerHome.jsp");	
}
catch(Exception e){
	out.println("something went wrong");
	out.println(e);
}
%>