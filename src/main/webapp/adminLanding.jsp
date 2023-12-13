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

  <form  action="adminAction.jsp">
<label id="repUsername" data-value='<%= repUsername  %>'>Welcome Admin user: <%=session.getAttribute("user")%></label> <br><br>

  <input type='hidden' name="repUsername" value='<%= repUsername %>'><br><br>
  <input type="radio" id="Add customer/customer representative" name="choice" value="Add customer representative" checked>
  <label for="oneway">Add customer representative</label> <br><br>
  <input type="radio" id="Edit customer/customer representative" name="choice" value="Edit customer representative">
  <label for="roundtrip">Edit customer representative</label> <br><br>
  <input type="radio" id="Delete customer/customer representative" name="choice" value="Delete customer representative">
  <label for="roundtrip">Delete customer representative</label> <br><br>
  <input type="radio" id="Get Sales" name="choice" value="Get Sales">
  <label for="roundtrip">Get Sales</label> <br><br>
  <input type="radio" id="Get reservations" name="choice" value="Get reservations">
  <label for="roundtrip">Get reservations</label> <br><br>
  <input type="radio" id="Get summary of revenue" name="choice" value="Get summary of revenue">
  <label for="roundtrip">Get summary of revenue by customer</label> <br><br> 
  <input type="radio" id="Top customer" name="choice" value="Top customer">
  <label for="roundtrip">Top customer</label> <br><br>
  <input type="radio" id="Top active flights" name="choice" value="Top active flights">
  <label for="roundtrip">Top active flights</label> <br><br>
  
  <input type="submit" value="Submit" onClick="handleSubmit()">
  </form>
  
<br>
<a href='logout.jsp'>Log out</a>
<%
}
%>

