package com.cs336.pkg;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.SQLException;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.DayOfWeek;


public class ApplicationDB {
	
	public ApplicationDB(){
		
	}

	public Connection getConnection(){
		
		//Create a connection string
		String connectionUrl = "jdbc:mysql://localhost:3306/flight_reservation";
		Connection connection = null;
		
		try {
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			//Create a connection to your DB
			connection = DriverManager.getConnection(connectionUrl,"root", "rootroot");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return connection;
		
	}
	
	public void closeConnection(Connection connection){
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
	
	public static void main(String[] args) {
		String dateString = "2023-12-06"; // Example date string

        // Define the formatter based on the expected format of the date string
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // Parse the date string into a LocalDate object
        LocalDate date = LocalDate.parse(dateString, formatter);

        // Get the DayOfWeek enum for the parsed date
        DayOfWeek dayOfWeek = date.getDayOfWeek();

        // Print the day of the week (e.g., MONDAY, TUESDAY, etc.)
        System.out.println("Day of Week: " + dayOfWeek);

        // To get the name of the weekday as a string (e.g., "Monday")
        String dayOfWeekString = dayOfWeek.toString();
        System.out.println("Day of Week (String): " + dayOfWeekString);

	}

	
	

}
