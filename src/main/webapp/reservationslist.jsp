<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.QueryManager" %>  <!-- Make sure this path matches your package structure -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Flight Reservations</title>
</head>
<body>

<%
    QueryManager manager = new QueryManager();
    String flightNumber = "your_flight_number"; // Replace with an actual flight number

    try {
        ResultSet rs = manager.getReservationsByFlightNumber(flightNumber);
        
        if (rs != null) {
            boolean hasResults = false;

            while (rs.next()) {
                hasResults = true;
                int bookingId = rs.getInt("B.id");
                int flightId = rs.getInt("F.id");

                out.println("<p>Booking ID: " + bookingId + "<br>Flight ID: " + flightId + "</p>");
            }

            if (!hasResults) {
                out.println("<p>No reservations found for flight number " + flightNumber + "</p>");
            }

            rs.close();
        } else {
            out.println("<p>Error: ResultSet is null.</p>");
        }
    } catch (SQLException e) {
        out.println("<p>SQL Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    }
%>
 

</body>
</html>
