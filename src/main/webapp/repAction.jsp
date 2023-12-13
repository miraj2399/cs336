<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<script type="text/javascript">
  function handleSubmit(customerId, customerUsername, customerQuestion, repUsername, questionId)
  {  
     window.location.href = 'answerQuestion.jsp?customerId=' + encodeURIComponent(customerId) +
     '&customerUsername=' + encodeURIComponent(customerUsername) +
     '&customerQuestion=' + encodeURIComponent(customerQuestion) + '&repUsername=' + repUsername + '&questionId=' + questionId;
  
  }
</script>

<% 
try{
	String choice = request.getParameter("choice");
	String repUsername = request.getParameter("repUsername");
	out.println("Action selected: " + choice);

	if (choice.equals("Book flight")) {
		
		response.sendRedirect("repBookFlightForm.jsp");		
		
	} else if (choice.equals("Edit flight")) {
		
		response.sendRedirect("repCancelFlightForm.jsp");		
		
	} else if (choice.equals("Add info to airline/airport")) {
		
		response.sendRedirect("repAddAirlineAirportForm.jsp");	
				
	} else if (choice.equals("Edit info to airline/airport")) {
		
		response.sendRedirect("repEditAirlineAirportForm.jsp");	
		
	} else if (choice.equals("Delete info to airline/airport")) {
		
		response.sendRedirect("repDeleteAirlineAirportForm.jsp");	
		
	} else if (choice.equals("Add info to flights")) {
		
		response.sendRedirect("repAddFlightForm.jsp");	
		
	} else if (choice.equals("Edit info to flights")) {
		
		response.sendRedirect("repEditFlightForm.jsp");	 
		
	} else if (choice.equals("Delete info to flights")) {
		
		response.sendRedirect("repDeleteFlightForm.jsp");	
		
	} else if (choice.equals("allFlights")) {
		
		response.sendRedirect("repAllFlightsForm.jsp");	
		
	} else if (choice.equals("Answer question")) {
		QueryManager query= new QueryManager();     
		ResultSet rs = query.browseQuestions();		
		String htmlText ="<h3>All questions:</h3>";
		htmlText += "<ul>";
		while (rs.next()) {
			String customerId = rs.getString("id");
			String customerUsername = rs.getString("customer");
			String customerQuestion = rs.getString("question");
			htmlText = htmlText+ "<li> Question id: "+rs.getString("id") + " and customer username " + rs.getString("customer") + " and the question is " + rs.getString("question") + "      <button onClick='handleSubmit(\"" + rs.getString("id") + "\", \"" + rs.getString("customer") + "\", \"" + rs.getString("question") + "\", \"" + repUsername + "\", \"" + rs.getString("id") + "\")'>Select</button><br><br>";
		htmlText += "</ul>";
		out.println(htmlText);
		htmlText  = "";
		}
	}
		
}
catch(Exception e){
	out.println("something went wrong");
	out.println(e);
}
%>