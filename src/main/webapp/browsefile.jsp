<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Browse Questions</title>
</head>
<body>

<h1>Browse Questions and Answers</h1>

<%
    // Sample questions and answers
    class QuestionAnswer {
        String question;
        String answer;

        public QuestionAnswer(String question, String answer) {
            this.question = question;
            this.answer = answer;
        }
    }

    QuestionAnswer[] qaList = {
        new QuestionAnswer("What is the capital of France?", "The capital of France is Paris."),
        new QuestionAnswer("How does photosynthesis work?", "Photosynthesis is the process by which green plants and some other organisms use sunlight to synthesize nutrients from carbon dioxide and water."),
        new QuestionAnswer("Who wrote 'Romeo and Juliet'?", "William Shakespeare wrote 'Romeo and Juliet'.")
        // Add more questions and answers as needed
    };

    for (QuestionAnswer qa : qaList) {
        out.println("<p><strong>Question:</strong> " + qa.question + "</p>");
        out.println("<p><strong>Answer:</strong> " + qa.answer + "</p>");
        out.println("<hr>");
    }
%>

</body>
</html>
