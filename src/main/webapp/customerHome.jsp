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
	if ((session.getAttribute("user").toString().equals("pdawg"))){
		out.print(" <script>if(localStorage.getItem('signInCount')=='0'){alert('Flight UA1600 for 2023-12-25 is avialable now! Youre getting this alert as youre in the waitlist. Book soon!!!!!');}localStorage.setItem('signInCount', localStorage.getItem('signInCount') ? Number(localStorage.getItem('signInCount')) + 1 : 0);</script>");
	}
%>

  <form  action="customerAction.jsp">
<label id="repUsername" data-value='<%= repUsername %>'>Welcome Customer : <%=session.getAttribute("user")%></label> <br><br>

  <input type='hidden' name="repUsername" value='<%= repUsername %>'>
  <input type="radio" id="qna" name="choice" value="qna" checked>
  <label for="oneway">Questions and Answers</label> <br><br>
  <input type="radio" id="flightInfo" name="choice" value="flightInfo">
  <label for="roundtrip">Flight Reservations and Details</label> <br><br>
  
  <input type="submit" value="Submit" onClick="handleSubmit()">
  </form>
  
<br>
<a href='logout.jsp'>Log out</a>
<%
}
%>

