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

  <form  action="repAction.jsp">
<label id="repUsername" data-value='<%= repUsername %>'>Welcome Customer Representative <%=session.getAttribute("user")%></label> <br><br>

  <input type='hidden' name="repUsername" value='<%= repUsername %>'><br><br>
  <input type="radio" id="Book flight" name="choice" value="Book flight" checked>
  <label for="oneway">Book flight</label> <br><br>
  <input type="radio" id="Edit flight" name="choice" value="Edit flight">
  <label for="roundtrip">Edit flight</label> <br><br>
  
  <input type="radio" id="Add info to airline/airport" name="choice" value="Add info to airline/airport">
  <label for="roundtrip">Add info to airline/airport</label> <br><br>
  <input type="radio" id="Edit info to airline/airport" name="choice" value="Edit info to airline/airport">
  <label for="roundtrip">Edit info to airline/airport</label> <br><br>
  <input type="radio" id="Delete info to airline/airport" name="choice" value="Delete info to airline/airport">
  <label for="roundtrip">Delete info to airline/airport</label> <br><br>
  
  <input type="radio" id="Add info to flights" name="choice" value="Add info to flights">
  <label for="roundtrip">Add info to flights</label> <br><br>
  <input type="radio" id="Edit info to flights" name="choice" value="Edit info to flights">
  <label for="roundtrip">Edit info to flights</label> <br><br>
  <input type="radio" id="Delete info to flights" name="choice" value="Delete info to flights">
  <label for="roundtrip">Delete info to flights</label> <br><br>
  
  <input type="radio" id="waitlist" name="choice" value="waitlist">
  <label for="roundtrip">Get all on waitlist for a flight</label> <br><br>
  
  <input type="radio" id="allFlights" name="choice" value="allFlights">
  <label for="roundtrip">Get list of all flights for an airport</label> <br><br>
  
  <input type="radio" id="Answer question" name="choice" value="Answer question">
  <label for="roundtrip">Answer question</label> <br><br>
  
  <input type="submit" value="Submit" onClick="handleSubmit()">
  </form>
  
<br>
<a href='logout.jsp'>Log out</a>
<%
}
%>

