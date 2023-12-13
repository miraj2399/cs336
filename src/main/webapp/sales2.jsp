<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Monthly Sales Report</title>
</head>
<body>
<%
    String month = request.getParameter("month");
    String year = request.getParameter("year");

    if (month != null && year != null) {
        out.print("Month: " + month + "<br>Year: " + year + "<br>");

        QueryManager query = new QueryManager(); // Make sure QueryManager is properly initialized
        ResultSet rs = query.salesMethod(month, year);

        if (rs != null) {
            try {
                if (rs.next()) {
                    out.println("Total Revenue: $" + rs.getDouble("Total_Revenue"));
                } else {
                    out.println("No sales data found for the specified month and year.");
                }
            } catch (SQLException e) {
                out.println("Database error: " + e.getMessage());
            } finally {
                // Close ResultSet
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        } else {
            out.println("No results returned.");
        }
    } else {
        out.println("Month and year parameters are required.");
    }
%>
</body>
</html>
