<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<% 
try{
	String id = request.getParameter("id");
	String departing = request.getParameter("departing");
	String arriving = request.getParameter("arriving");

	QueryManager query= new QueryManager();
	query.repEditFlight(id, departing, arriving);	
	response.sendRedirect("customerRep.jsp");
	
}
catch(Exception e){
	out.println("something went wrong");
	out.println(e);
}
%>