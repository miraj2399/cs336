<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<%
try{

String ticketid = request.getParameter("ticketid");
QueryManager query = new QueryManager();
if (query.cancelReservation(Integer.parseInt(ticketid))){
	out.println("<h1>All flights related to ticket "+ ticketid + " has been removed successfully</h1>");
}
else{
	out.println("<h1>An error occured and we cannot delete reservation for the ticket "+ticketid+ " right now. Please Try again later!");
}
} catch(Exception e){
	out.println("<h1>An error occured and we cannot delete reservation for the ticket you selected right now. Please Try again later!");
	out.println(e);
}

%>