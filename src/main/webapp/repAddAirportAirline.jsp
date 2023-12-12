<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<% 
try{
	String table = request.getParameter("table");
	String id = request.getParameter("id");
	String name = request.getParameter("name");

		QueryManager query= new QueryManager();
		query.repAddAirportAirline(table, id, name);	
		response.sendRedirect("customerRep.jsp");
	
}
catch(Exception e){
	out.println("something went wrong");
	out.println(e);
}
%>