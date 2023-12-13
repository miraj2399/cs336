<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Question Posted</title>
</head>
<body>

<h1>Question Submission</h1>

<%
    // Retrieving the question from the form submission
    String question = request.getParameter("question");
	String repUsername = request.getParameter("repUsername");
	QueryManager query= new QueryManager();
	ResultSet rs = query.PostQuestions();
    // In a real application, you would store this in a database
    // For demonstration, we'll just display the question

    if(question != null && !question.trim().isEmpty()) {
%>
        <p><strong>Your Question:</strong> <%= question %></p>
        <p>Your question has been submitted successfully!</p>
<%
    } else {
%>
        <p>Error: No question was submitted. Please go back and try again.</p>
<%
    }
%>

</body>
</html>
