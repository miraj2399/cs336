<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<%
QueryManager query = new QueryManager();
String today = request.getParameter("today");
String username = session.getAttribute("user").toString();
ResultSet rs = query.getUpcomingReservations(username, today,false);
String s;
out.println("<ul>");
while(rs.next()){
	out.println("<li>");
	s = "flight id: ";
	out.println(s+rs.getString("flight_id") + "<br>");
	s = "departs at: ";
	out.println("<strong>"+s+rs.getString("departs_date") + "</strong><br>");
	s = "from: ";
	out.println(s+rs.getString("from_airport") + "<br>");
	s = "to: ";
	out.println(s+rs.getString("to_airport") + "<br>");
	s = "booking id: ";
	out.println(s+rs.getString("booking_id") + "<br>");
	s = "ticket id: ";
	out.println(s+rs.getString("ticket_id") + "<br>");
	s = "class: ";
	String classValue = rs.getString("class").equals("1")?"business":"economy";
	out.println(s+ classValue + "<br>");
	
	
	out.println("</li><br><br><br>");
}
out.println("</ul>");
%>