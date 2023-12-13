<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<style>
    .flight-container {
        font-family: Arial, sans-serif;
        margin: 10px;
    }
    .flight-header {
        background-color: #f2f2f2;
        padding: 10px;
        text-align: center;
    }
    .flight-list {
        list-style: none;
        padding: 0;
    }
    .flight-item {
        background-color: #f2f2f2;
        margin-bottom: 10px;
        padding: 10px;
        border-radius: 5px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .book-button {
        background-color: green;
        color: white;
        padding: 5px 10px;
        border: none;
        border-radius: 3px;
        cursor: pointer;
    }
    .flight-details {
        margin-right: 10px;
    }
    
    .filter-buttons {
        text-align: center;
        margin-bottom: 20px;
    }
    .filter-button {
        background-color: #4CAF50;
        color: white;
        padding: 10px 20px;
        margin: 5px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    </style>

<% 
try{
	String airport = request.getParameter("airport");

	
		QueryManager query= new QueryManager();
		ResultSet rs = query.adminAllFlights(airport);
		String htmlText = "";
	    QueryManager query2 = new QueryManager();
	    htmlText += "<div class='direct'>";
	    htmlText += "<h3>Direct flights:</h3>";
	    htmlText += "<ul style='list-style-type:none; padding: 0;'>";
		while(rs.next()) {
		    htmlText += "<li class='flight-item'>";
	        htmlText += "Flight ID: " + rs.getString("id") + "<br>";
	        htmlText += "Departs: " + rs.getString("departing_time") + "<br>";
	        htmlText += "Arrives: " + rs.getString("arriving_time") + "<br>";
	        htmlText += "Price: " + rs.getString("price");
	        String address = query2.getAddressOfAirport(airport);
	        htmlText += "To <a href='//maps.google.com/?q="+ address + "'>"+ rs.getString("departing_airport") +"</a>";
	        address = query2.getAddressOfAirport(airport);
	        htmlText += "To <a href='//maps.google.com/?q="+ address + "'>"+ rs.getString("arriving_airport") +"</a>";
	        
	        htmlText += "<button class='book-button' id='"+rs.getString("id")+"' onclick='selectFlight(\"" + rs.getString("id") + "\")'>select</button>";
	        htmlText += "</li>";
		} 
		htmlText += "</ul>";
	    htmlText += "</div>";
		out.println(htmlText);
		
	
}
catch(Exception e){
	out.println("something went wrong");
	out.println(e);
}
%>