<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<%
String bookingid = request.getParameter("bookingid");
String flightid = request.getParameter("flightid");

%>

<div>
<button>make it one way</button><br><br>
<button>change seat number</button><br><br>
<button>change flight date</button><br><br>
<% 
out.print("<form action='ChangeClass.jsp'>");
	out.print("<button type='submit'>Change class(business/economy)</button>");
	out.print("<input type='hidden' name='"+ "bookingid"+"' value='"+ bookingid +"'>");
	out.print("<input type='hidden' name='"+ "flightid"+"' value='"+flightid+"'>");
	out.print("</form>");
	%>
</div>