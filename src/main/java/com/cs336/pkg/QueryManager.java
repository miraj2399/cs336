package com.cs336.pkg;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.DayOfWeek;

public class QueryManager {
	private Connection connection;
	public QueryManager() {
		this.connection = getConnection();
	}

	
public Connection getConnection() {
		
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

public String ConvertDateToSpecialString(String dateString) {
	//Define the formatter based on the expected format of the date string
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    // Parse the date string into a LocalDate object
    LocalDate date = LocalDate.parse(dateString, formatter);

    // Get the DayOfWeek enum for the parsed date
    DayOfWeek dayOfWeek = date.getDayOfWeek();

    // Get the integer value of the day of the week (1=Monday, 7=Sunday)
    int dayOfWeekInt = dayOfWeek.getValue();
    String dayOfWeekString;
    
    switch (dayOfWeekInt) {
    case 1:
    	dayOfWeekString = "1______";
        break;
    case 2:
    	dayOfWeekString = "_1_____";
        break;
    case 3:
    	dayOfWeekString = "__1____";
        break;
    case 4:
    	dayOfWeekString = "___1___";
        break;
    case 5:
    	dayOfWeekString = "____1__";
        break;
    case 6:
    	dayOfWeekString = "_____1_";
        break;
    case 7:
    	dayOfWeekString = "______1";
        break;
    default:
    	dayOfWeekString = "Invalid day";
        break;
}
    return dayOfWeekString;
	
}

public ResultSet searchDirectFlight(String origin, String destination, String dateString) {
	Statement st;
	try {
		String dayOfWeekString = ConvertDateToSpecialString(dateString);
		st = this.connection.createStatement();
		ResultSet rs;
		System.out.print(dayOfWeekString);
		rs = st.executeQuery("select * from flight where arriving_airport='"+destination +"' and departing_airport='"+origin+"'" + "and day_of_week like '"+dayOfWeekString+"'");
		return rs;
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		return null;
	}
	
}

public ResultSet searchOneTransitFlight(String origin, String destination, String dateString) {
	Statement st;
	try {
		String dayOfWeekString = ConvertDateToSpecialString(dateString);
		st = this.connection.createStatement();
		ResultSet rs;
		System.out.print(dayOfWeekString);
		rs = st.executeQuery(
				  "select f1.id as f1, f2.id as f2,"
				+ "f1.day_of_week as day_of_week_f1,"
				+ " f2.day_of_week as day_of_week_f2,"
				+ "f1.arriving_time as f1_arrives_at,"
				+ "f1.departing_time as f1_departs_at,"
				+ "f2.departing_time as f2_departs_at,"
				+ "f2.arriving_time as f2_arrives_at,"
				+ " f1.departing_airport as origin,"
				+ " f1.arriving_airport as connecting,"
				+ " f2.arriving_airport as destination"
				+ " from flight f1 join flight f2"
				+ " on f1.arriving_airport=f2.departing_airport"
				+ " where f1.departing_airport='"+origin+"' "
				+ "and  f2.arriving_airport='"+destination+"' "
				+ " and f2.departing_time>f1.arriving_time"
				+ " and f2.departing_time-f1.arriving_time>=500"
				+ " and f1.day_of_week like '" + dayOfWeekString+"' "
				// don't need to do anything  else, if only allow same day transit flight
				+ " and f2.day_of_week like '"+ dayOfWeekString+"'"
			);
		return rs;
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		return null;
	}
	

}

public ResultSet authenticate(String username, String password) {
	Statement st;
	try {
		st = this.connection.createStatement();
		ResultSet rs;
		rs = st.executeQuery("select * from customer where username='"+username+"' and password='"+password+"'");
		return rs;
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		return null;
	}
}

}