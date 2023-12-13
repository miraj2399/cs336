<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script type="text/javascript">
  function handleSubmit()
  {
	    const question = document.getElementById('question').value;
	    const repUsername = document.getElementById('repUsername').getAttribute('data-value');
	    
	    console.log("LOOK -- " + repUsername);
	    
  }
</script>

<h1>Welcome Customer <%=session.getAttribute("user")%></h1>

<!-- Form for posting a question -->
<%
String repUsername = (String) session.getAttribute("user");
if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%}
%>
<form action="QuestionAndQuery.jsp" method="post">
<label id="repUsername" data-value='<%= repUsername %>'><strong>Post a Question</strong></label> <br><br>
    <label for="question">Question:</label><br>
    <textarea id="question" name="question" rows="4" cols="50" required></textarea><br><br>
	<input type="submit" value="Submit" onClick="handleSubmit()">
</form>



