<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Flight Reservations</title>
</head>
<body>

<%

    String flightNumber = request.getParameter("flightNumber");
	
    if (flightNumber != null && !flightNumber.isEmpty()) {
        QueryManager queryManager = new QueryManager(); // Assuming QueryManager is correctly initialized with a DB connection
        try {

            ResultSet rs = queryManager.ReservationsFlight(flightNumber);
            if (rs == null) { 
            	out.print("There is no reservations for this flight");
            }
            if (rs != null) {
            	out.println("<h1>All Reservations for the flight: " + flightNumber + " </h1><br>");
                while (rs.next()) {
                    int bookingId = rs.getInt(1); // Assuming the first column in the result set is the booking ID
                    String flight_id = rs.getString(2);
                    String departs_date = rs.getString(3);
                    String arrives_date = rs.getString(4);
                    int seat_no = rs.getInt(5);
                    int c = rs.getInt(6);
                    int plane_id = rs.getInt(7);
                    
                    out.println("<p>Booking ID: " + bookingId + ", Flight ID: " + flight_id + ", Departs Date: " + departs_date + ", Arrive Date: " + arrives_date + ", Seat Number: " + seat_no + ", Class: " + c + ", Plane Id: " + plane_id + "</p>");
                }
                rs.close();
            } else {
                out.println("<p>No reservations found for flight number: " + flightNumber + "</p>");
            }
        } catch (SQLException e) {
            out.println("<p>Error retrieving reservations: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>Please provide a flight number.</p>");
    }
%>

</body>
</html>