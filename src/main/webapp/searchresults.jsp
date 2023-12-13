<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Results</title>
</head>
<body>

<%
String keyword = request.getParameter("query");

out.println("<h1>Search results for keyword: " + keyword +"</h1>");

try{
				
		QueryManager query= new QueryManager();
		ResultSet rs = query.searchKeyword(keyword);
		while(rs.next()) {
			
			out.println("<p><strong>Question:</strong> " + rs.getString("question") + "</p>");
	       	if(rs.getString("answer") == null) {
	       		out.println("<p><strong>Answer:</strong> Not Answered</p>");
	       	} else {
				out.println("<p><strong>Answer:</strong> " + rs.getString("answer") + "</p>");
	       	}
	        out.println("<hr>");
			
		}
		
}
catch(Exception e){
	out.println("something went wrong");
	out.println(e);
}

%>

</body>
</html>
