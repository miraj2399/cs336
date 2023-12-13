<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<%
String bookingid = request.getParameter("bookingid");
String flightid = request.getParameter("flightid");
QueryManager query = new QueryManager();
if(query.changeClass(bookingid, flightid)){
	out.println("<h1>Change successful</h1>");
}
else{
	out.println("<h1>Cannot change due to tecnical error! try again later!</h1>");
}
%>