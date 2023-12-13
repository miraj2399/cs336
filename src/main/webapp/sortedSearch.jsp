<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>

<style>
    .flight-container {
        font-family: Arial, sans-serif;
        margin: 10px;
    }
    .flight-header {
        background-color: #f2f2f2;
        padding: 10px;
        text-align: center;
    }
    .flight-list {
        list-style: none;
        padding: 0;
    }
    .flight-item {
        background-color: #f2f2f2;
        margin-bottom: 10px;
        padding: 10px;
        border-radius: 5px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .book-button {
        background-color: green;
        color: white;
        padding: 5px 10px;
        border: none;
        border-radius: 3px;
        cursor: pointer;
    }
    .flight-details {
        margin-right: 10px;
    }
    
    .filter-buttons {
        text-align: center;
        margin-bottom: 20px;
    }
    .filter-button {
        background-color: #4CAF50;
        color: white;
        padding: 10px 20px;
        margin: 5px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    </style>

<script type="text/javascript">

var selectedFlights = [];
var sorted = false;

function toggleSortByPrice(){
	if (sorted){
		sorted = false;
	}
	else{
		sorted = true;
	}
	if (sorted){
		// Hide u
	    document.querySelectorAll('.unsorted').forEach(function(el) {
	        el.style.display = 'none';
	    });

	    // Show all direct flights
	    document.querySelectorAll('.sorted').forEach(function(el) {
	        el.style.display = 'block';
	    });
	}
	else{
		// Hide u
	    document.querySelectorAll('.sorted').forEach(function(el) {
	        el.style.display = 'none';
	    });

	    // Show all direct flights
	    document.querySelectorAll('.unsorted').forEach(function(el) {
	        el.style.display = 'block';
	    });
	}
}
function selectFlight(flight) {
    if (selectedFlights.includes(flight)) {
        selectedFlights = selectedFlights.filter((id) => id != flight);
    } else {
        selectedFlights.push(flight);
    }
    document.getElementById(flight).innerHTML =="select"?document.getElementById(flight).innerHTML ="UNSELECT": document.getElementById(flight).innerHTML ="select";
 
    const form = document.getElementById("bookingForm");
    var hiddenInput;
    if (document.getElementById("flight-data")){
    	hiddenInput = document.getElementById("flight-data");
    }
    else{
	hiddenInput = document.createElement('input');
    }
	hiddenInput.id = "flight-data";
    hiddenInput.setAttribute("type","hidden")
    hiddenInput.setAttribute("name","flights");
    hiddenInput.value = selectedFlights.join(",");
    form.appendChild(hiddenInput);
}




function bookFlights() {
    alert("Booking flights: " + selectedFlights.join(", "),+origin+destination+date);
}



function handleDirectFilter(){
    // Hide all one-stop flights
    document.querySelectorAll('.onestop').forEach(function(el) {
        el.style.display = 'none';
    });

    // Show all direct flights
    document.querySelectorAll('.direct').forEach(function(el) {
        el.style.display = 'block';
    });

    console.log("Showing only direct flights");
}

function handleOneStopFilter(){
    // Hide all direct flights
    document.querySelectorAll('.direct').forEach(function(el) {
        el.style.display = 'none';
    });

    // Show all one-stop flights
    document.querySelectorAll('.onestop').forEach(function(el) {
        el.style.display = 'block';
    });

    console.log("Showing only one-stop flights");
}



</script>

<%
try {
    String origin = request.getParameter("origin");
    String destination = request.getParameter("destination");
    String date  = request.getParameter("date");
    String choice = request.getParameter("choice");
    QueryManager query= new QueryManager();
    String htmlText = "<div id='reserve_text' data-value ='"+ choice +"'>";
    htmlText += "<form id='bookingForm' method='POST' action='bookFlights.jsp'>"; 
    htmlText += "<input type='hidden' id='origin' name='origin' value='" + origin + "'>";
    htmlText += "<input type='hidden' id='destination' name='destination' value='" + destination + "'>";
    htmlText += "<input type='hidden' id='date' name='date' value='" + date + "'>";
    htmlText += "<button type='submit'>book<button>";
    htmlText += "</form>";
    htmlText += "</div>";
    htmlText += "<h1>Flight from: "+ origin + " to "+destination+"</h1>";
    htmlText += "<div class='filter-buttons'>";
    htmlText += "<button onclick='handleDirectFilter()'>Direct</button> ";
    htmlText += "<button onclick='handleOneStopFilter()'>One Stop</button>";
    htmlText += "<h6> Sort by: &nbsp;";
    htmlText +="<form action='sortedSearch.jsp'>";
    htmlText += "<button onClick={toggleSortByPrice()} type='submit' > price </button>";
    htmlText += "<input type='hidden' name='" + "origin" + "' value='"+origin+ "'>";
    htmlText += "<input type='hidden' name='" + "destination" + "' value='"+destination+ "'>";
    htmlText += "<input type='hidden' name='" + "choice" + "' value='"+choice+ "'>";
    htmlText += "<input type='hidden' name='" + "date" + "' value='"+date+ "'>";
    htmlText += "</form>";
    htmlText += "<button onClick={toggleSortByPrice()}> departure time </button>";
    htmlText += "<button onClick={toggleSortByPrice()}> arriving time </button>";
    htmlText += "<button onClick={toggleSortByPrice()}> duration </button>";
    htmlText += "<button onClick={toggleSortByPrice()}> none </button>";
    
    htmlText += "</div>";

    ResultSet rs = query.searchDirectFlight(origin, destination, date,true);

    htmlText += "<div class='direct'>";
    htmlText += "<h3>Direct flights:</h3>";
    htmlText += "<ul style='list-style-type:none; padding: 0;'>";
    while (rs.next()) {
        htmlText += "<li class='flight-item'>";
        htmlText += "Flight ID: " + rs.getString("id") + "<br>";
        htmlText += "Departs: " + rs.getString("departing_time") + "<br>";
        htmlText += "Arrives: " + rs.getString("arriving_time") + "<br>";
        htmlText += "Price: " + rs.getString("price");
        
        htmlText += "<button class='book-button' id='"+rs.getString("id")+"' onclick='selectFlight(\"" + rs.getString("id") + "\")'>select</button>";
        htmlText += "</li>";
    }
    htmlText += "</ul>";
    htmlText += "</div>";

    // Handling one-stop flights
    rs = query.searchOneTransitFlight(origin, destination, date);
    htmlText += "<div class='onestop'>";
    htmlText += "<h3>Flights with One Transit:</h3>";
    htmlText += "<ul style='list-style-type:none; padding: 0;'>";
    while (rs.next()) {
        htmlText += "<li class='flight-item'>";
        // Example details for one-stop flights, adjust according to your schema
        htmlText += "Transit Flight ID: " + rs.getString("f1") + "<br>";
        htmlText += "Departs: " + rs.getString("f1_departs_at") + "<br>";
        htmlText += "Arrives at Transit: " + rs.getString("f1_arrives_at") + "<br>";
        htmlText += "Connects to Flight ID: " + rs.getString("f2") + "<br>";
        htmlText += "Final Arrival: " + rs.getString("f2_arrives_at") + "<br>";
        htmlText += "<button class='book-button' onclick='selectFlight(\"" + rs.getString("f1") + "\")'>select</button>";
        htmlText += "</li>";
    }
    htmlText += "</ul>";
    htmlText += "</div>";

    out.println(htmlText);
    htmlText = "";
  
    
    if (choice.equals("roundtrip")){
    	rs = query.searchDirectFlight(destination, origin, date,true);
    	
        htmlText += "<div class='direct'>";
        htmlText += "<h3>Direct flights:</h3>";
        htmlText += "<ul style='list-style-type:none; padding: 0;'>";
        while (rs.next()) {
            htmlText += "<li class='flight-item'>";
            htmlText += "Flight ID: " + rs.getString("id") + "<br>";
            htmlText += "Departs: " + rs.getString("departing_time") + "<br>";
            htmlText += "Arrives: " + rs.getString("arriving_time") + "<br>";
            htmlText += "Price: " + rs.getString("price");
            htmlText += "<button class='book-button' id='"+rs.getString("id")+"' onclick='selectFlight(\"" + rs.getString("id") + "\")'>select</button>";
            htmlText += "</li>";
        }
        htmlText += "</ul>";
        htmlText += "</div>";

        // Handling one-stop flights
        rs = query.searchOneTransitFlight(origin, destination, date);
        htmlText += "<div class='onestop'>";
        htmlText += "<h3>Flights with One Transit:</h3>";
        htmlText += "<ul style='list-style-type:none; padding: 0;'>";
        while (rs.next()) {
            htmlText += "<li class='flight-item'>";
            // Example details for one-stop flights, adjust according to your schema
            htmlText += "Transit Flight ID: " + rs.getString("f1") + "<br>";
            htmlText += "Departs: " + rs.getString("f1_departs_at") + "<br>";
            htmlText += "Arrives at Transit: " + rs.getString("f1_arrives_at") + "<br>";
            htmlText += "Connects to Flight ID: " + rs.getString("f2") + "<br>";
            htmlText += "Final Arrival: " + rs.getString("f2_arrives_at") + "<br>";
            htmlText += "<button class='book-button' onclick='selectFlight(\"" + rs.getString("f1") + "\")'>select</button>";
            htmlText += "</li>";
        }
        htmlText += "</ul>";
        htmlText += "</div>";

        out.println(htmlText);
        
    	
    }
    
}
catch(Exception e) {
    out.println("Something went wrong");
    out.println(e);
}
%>