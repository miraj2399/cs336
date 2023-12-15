<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<html>
<head>
   <title>Waiting List</title>
</head>
<body>
   <h2>View Waiting List for a Flight</h2>
   <form action="customerwaitlist.jsp" method="post">
       <label for="flightId">Enter Flight ID:</label>
       <input type="text" id="flightId" name="flightId" required>
       <input type="submit" value="View Waiting List">
   </form>
   <%
       if (request.getMethod().equals("POST")) {
           String flightId = request.getParameter("flightId"); 
           QueryManager queryManager = new QueryManager(); // Ensure this class is properly set up
           ResultSet rs = null;
           try {
               rs = queryManager.getWaitingListByFlightId(flightId);
               if (rs != null) {
                   out.println("<h3>Waiting List for Flight: " + flightId + "</h3>");
                   out.println("<ul>");
                   while (rs.next()) {
                       String username = rs.getString("username");
                       out.println("<li>" + username + "</li>");
                   }
                   out.println("</ul>");
               } else {
                   out.println("<p>No passengers found on the waiting list for this flight.</p>");
               }
           } catch (SQLException e) {
               out.println("SQL Error: " + e.getMessage());
           } finally {
               // Clean up
               if (rs != null) {
                   try { rs.close(); } catch (SQLException e) { /* Ignored */ }
               }
           }
       }
   %>
</body>
</html>
