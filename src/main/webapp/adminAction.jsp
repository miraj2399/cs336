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
	out.println("your selection is: " + choice);

	if (choice.equals("Add customer representative")) {
		
		response.sendRedirect("adminAddForm.jsp");
		
	} else if (choice.equals("Delete customer representative")) {
		
		response.sendRedirect("adminDeleteForm.jsp");
		
	} else if (choice.equals("Edit customer representative")) {
		
		response.sendRedirect("adminEditForm.jsp");
		
	} else if (choice.equals("Get Sales")) {
		
		response.sendRedirect("adminGetSalesForm.jsp");
		
	} else if (choice.equals("Get reservations")) {
		
		response.sendRedirect("adminGetReservationForm.jsp");
		
	} else if (choice.equals("Get summary of revenue")) {
		
		response.sendRedirect("summarrevenue.jsp");
		
	} else if (choice.equals("Top customer")) {
		
		QueryManager query= new QueryManager();
		ResultSet rs = query.findTopCustomerByRevenue();
		
	} else if (choice.equals("Top active flights")) {
		QueryManager query= new QueryManager();
		ResultSet rs = query.findTopActiveFlight();		
		
	}
		
}
catch(Exception e){
	out.println("something went wrong");
	out.println(e);
}
%>