<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<% 
try{
	String month = request.getParameter("month");
	String year = request.getParameter("year");

	
		QueryManager query= new QueryManager();
		ResultSet rs = query.adminGetMonthSales(month, year);
		String htmlText = "";
		if (rs.next()) {
		    double totalRevenue = rs.getDouble("Total_Revenue");
		    htmlText = htmlText + "<li> The revenue for the month " + month + ", and the year " + year + " is: $" + totalRevenue;
		} else {
		    htmlText = htmlText + "<li> No data available for " + month + ", " + year;
		}
		out.println(htmlText);
		
	
}
catch(Exception e){
	out.println("something went wrong");
	out.println(e);
}
%>