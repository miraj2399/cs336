<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script type="text/javascript">
  function handleSubmit()
  {
	    const repUsername = document.getElementById('repUsername').getAttribute('data-value');
	    
  }
</script>
<h1>Post a Question or Answer</h1>

<!-- Form for posting a question -->
<%
String repUsername = (String) session.getAttribute("user");
if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%} else {
%>
<h2>Post a Question</h2>
<form action="QuestionAndQuery.jsp" method="post">
<label id="repUsername" data-value='<%= repUsername %>'>Welcome Customer <%=session.getAttribute("user")%></label> <br><br>
    <label for="question">Question:</label><br>
    <textarea id="question" name="question" rows="4" cols="50" required></textarea><br><br>
    <input type="submit" value="Post Question">
</form>

<!-- Form for posting an answer -->
<h2>Post an Answer</h2>
<form action="answerPosted.jsp" method="post">
    <label for="answerQuestionId">Question ID:</label><br>
    <input type="text" id="answerQuestionId" name="answerQuestionId" required><br><br>
    <label for="answer">Answer:</label><br>
    <textarea id="answer" name="answer" rows="4" cols="50" required></textarea><br><br>
    <input type="submit" value="Post Answer">
</form>

</body>
</html>
