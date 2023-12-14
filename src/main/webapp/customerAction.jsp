<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<%@ page import="java.net.URLEncoder" %>
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
	if (choice.equals("qna")) {
		
		response.sendRedirect("customerView.jsp");
		
	} else if (choice.equals("flightInfo")) {
		
		response.sendRedirect("success.jsp");
	
	}
		
}
catch(Exception e){
	out.println("something went wrong");
	out.println(e);
}
%>
