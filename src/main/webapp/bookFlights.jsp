<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<%
try{
QueryManager query = new QueryManager();
String origin = request.getParameter("origin");
String destination = request.getParameter("destination");
String date  = request.getParameter("date");
String flights = request.getParameter("flights");
String[] arrOfFlights = flights.split(",", 2);
String username = session.getAttribute("user").toString();
Boolean available = true;

if (arrOfFlights.length==2){
	available = available && query.checkAvailability(origin, destination, arrOfFlights[0] ,date);
	available = available && query.checkAvailability(origin, destination, arrOfFlights[1] ,date);
}
else{
		available = available && query.checkAvailability(origin, destination, arrOfFlights[0] ,date);
}



int x;

if (available){
if(arrOfFlights.length==2){
	x=  query.updateItinerary(origin, destination,username , arrOfFlights[0],arrOfFlights[1] , date);
	
}
else{
	x=query.updateItinerary(origin, destination,username , arrOfFlights[0],null , date);
}
out.print("<h1> Booking successful!!!!!!!!!</h1>");
}
else{
	out.print("<h1> Cannot book due to availablity</h1>");
	out.print("<form action='insertToWaitlist.jsp'>");
	out.print("<button type='submit'>Add to Waitlist</button>");
	out.print("</form>");
	
	
}


} catch(Exception e){
	out.println(e);
	
}


%>