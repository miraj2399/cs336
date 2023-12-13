
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<script type="text/javascript">
  function handleSubmit()
  {
	  const choices = document.querySelectorAll('input[name="choice"]');
	    let choiceValue = null;

	    choices.forEach(choice => {
	      if (choice.checked) {
	        choiceValue = choice.value;
	      }
	    });
	 const repUsername = document.getElementById('repUsername').getAttribute('data-value');
     
  }
</script>

<%
String repUsername = (String) session.getAttribute("user");

if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%} else {
%>
Welcome <%=session.getAttribute("user")%> 
  <form action="customerQuestionLanding.jsp">
  <input type='hidden' name="repUsername" value='<%= repUsername %>'><br><br>
  <label for="destination">Choose one of these actions:</label><br><br>
  
  <input type="radio" id="browse" name="choice" value="browse" checked>
  <label for="oneway">Browse question and answers</label> <br><br>
  <input type="radio" id="search" name="choice" value="search">
  <label for="oneway">Search by keyword</label> <br><br>
  <input type="radio" id="post" name="choice" value="post">
  <label for="roundtrip">Post a question</label> <br><br>
  <input type="submit" value="Submit" onClick="handleSubmit()">
  </form>
   <br><br>
    <br><br>

<br>
<a href='logout.jsp'>Log out</a>
<%
}
%>
