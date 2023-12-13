QueryManager query= new QueryManager();
		ResultSet rs = query.findQuestions();
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%@ page import="java.text.*" %>
<!DOCTYPE html>

<% 
try{
	String question = request.getParameter("question");
	String username = request.getParameter("repUsername");
	

	
		QueryManager query= new QueryManager();
		query.askQuestion(question, username);	
		response.sendRedirect("success.jsp");
	
}
catch(Exception e){
	out.println("something went wrong");
	out.println(e);
}
%>