<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<% 
try{
	String table = request.getParameter("table");
	String username = request.getParameter("username");
				
		QueryManager query= new QueryManager();
		query.adminAddRep(table, username);	
		out.println("sucessfully added " + username + " in the " + table + " table!");
		response.sendRedirect("adminLanding.jsp");
	
}
catch(Exception e){
	out.println("something went wrong");
	out.println(e);
}
%>