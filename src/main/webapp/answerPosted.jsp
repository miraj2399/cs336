<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Answer Posted</title>
</head>
<body>

<h1>Answer Submission</h1>

<%
    // Retrieving data from the form submission
    String answer = request.getParameter("answer");
    String answerQuestionId = request.getParameter("answerQuestionId");

    // In a real application, you would store these in a database
    // For demonstration, we'll just display the data

    if(answer != null && !answer.trim().isEmpty() && answerQuestionId != null && !answerQuestionId.trim().isEmpty()) {
%>
        <p><strong>Question ID:</strong> <%= answerQuestionId %></p>
        <p><strong>Answer:</strong> <%= answer %></p>
        <p>Your answer has been submitted successfully!</p>
<%
    } else {
%>
        <p>Error: There was an issue submitting your answer. Please ensure all fields are filled out correctly and try again.</p>
<%
    }
%>

</body>
</html>
