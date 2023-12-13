<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<%
String date = request.getParameter("date");
String flight1 = request.getParameter("flight1");
String flight2 = request.getParameter("flight2");
String username = session.getAttribute("user").toString();
try{
QueryManager query = new QueryManager();
boolean success = true;
if (!query.insertToWaitlist(username,flight1,date)){
	success = false;
}
if (!flight2.equals("x")){
	success = success & query.insertToWaitlist(username,flight2,date);
}
if (success){
	out.println("Added to waitlist");
}
else{
	out.println("Cannot add to waitlist due to tecnical problem! Try again");
}
}catch(Exception e){
	out.println("Cannot add to waitlist due to tecnical problem! Try again");
}


%>