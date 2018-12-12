//        -- Class: CSE 3330
//        -- Semester: Fall 2018
//        -- Student Name: Gentry, Zachery, zcg4385
//        -- Student ID: 1001144385
//        -- Assignment: Project #4

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.sql.*;
import java.util.Scanner;

final class Main {

    //Credentials for database connection
    final static String user = "zcg4385";
    final static String password = "Apple123";
    final static String db = "zcg4385";
    final static String jdbc = "jdbc:mysql://localhost:3306/" + db + "?user=" + user + "&password=" + password;

    public static void main(String[] args) throws Exception {
        System.out.println("Welcome to Project 4! Please select one of the following options by entering the corresponding number.");

        // Configure database connection
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection(jdbc);
        Statement stmt = con.createStatement();

        Scanner input = new Scanner(System.in);

        //////////////////////////////////////
        // M A I N  P R O G R A M  L O O P ///
        //////////////////////////////////////
        while (true) {

            // Present users with their input choices
            System.out.println("\n" +
                    "1. Check if Pilot is busy on a certain day and show the pilot assignments for\n" +
                    "this day.\n" +
                    "2. Assign a Pilot to a flight leg instance\n" +
                    "3. Add a Pilot\n" +
                    "4. Quit\n");

            // User enters a command (1, 2, 3, 4, or q)
            System.out.print("Enter command> ");
            char[] userInput = input.nextLine().toCharArray();

            char c;
            // Catch exception if user enters nothing
            try {
                c = userInput[0];
            } catch (Exception e) {
                c = '0';
            }

            switch (c) {
                case '1': // Check if pilot is busy
                    checkPilotBusy(stmt);
                    break;
                case '2': // Assign a pilot to a flight leg instance
                    assignPilotToFlight(stmt);
                    break;
                case '3': // Add a pilot to database
                    addPilot(stmt);
                    break;
                case '4': // Exit
                case 'q': // Exit
                    System.out.println("Goodbye!");
                    stmt.close();
                    con.close();
                    return;
                default: // Incorrect input
                    System.out.println("Try another command.");
                    break;
            }
        }

    }

    // Queries the database for a pilot matching name and date
    public static void checkPilotBusy(Statement stmt) throws Exception {
        Scanner s = new Scanner(System.in);

        // Get name and date for specific pilot
        System.out.print("Enter name of pilot> ");
        String name = s.nextLine();
        System.out.print("Enter a certain day to check in format year-month-day> ");
        String date = s.nextLine();

        ResultSet rs = stmt.executeQuery("select * from PilotFlyAssignments where Name = " + wrapInQuotes(name) + " and FDate = " + wrapInQuotes(date) + ";");

        System.out.println("\nHere is what " + name + " is doing on " + date + ".");

        BufferedWriter writer = new BufferedWriter(new FileWriter("output.txt", true));

        // Loops through the results of the query, formats it into a table, and writes the result to a text file.
        while (rs.next()) {
            StringBuilder output = new StringBuilder();
            output.append("-------------------------------------------\n");
            output.append("| ID: " + rs.getString("ID"));
            output.append("\n| Name: " + rs.getString("Name"));
            output.append("\n| FLNO: " + rs.getString("FLNO"));
            output.append("\n| From: " + rs.getString("F"));
            output.append("\n| To: " + rs.getString("T"));
            output.append("\n| Flight Date: " + rs.getString("FDate"));
            output.append("\n-------------------------------------------\n");
            writer.append(output);
            System.out.println(output);
        }
        writer.close();

        rs.close();

    }

    // Assigns a specific pilot given their ID to a Flight Leg Instance given its key
    public static void assignPilotToFlight(Statement stmt) throws Exception {
        Scanner s = new Scanner(System.in);

        System.out.print("Enter the ID of the pilot> ");
        String ID = s.nextLine();
        System.out.print("Enter the FLNO> ");
        String FLNO = s.nextLine();
        System.out.print("Enter the Seq> ");
        String Seq = s.nextLine();
        System.out.print("Enter the FDate of format year-month-day> ");
        String FDate = s.nextLine();

        // Query FlightLegInstances for matching key
        ResultSet rs = stmt.executeQuery("select * from FlightLegInstance where (FLNO, Seq, FDate) = (" +
                wrapInQuotes(FLNO) + ", " + wrapInQuotes(Seq) + ", " + wrapInQuotes(FDate) + ")");

        // Don't do anything if no results come up
        int rsCounter = 0;
        while (rs.next()) {
            rsCounter++;
        }
        if (rsCounter == 0) {
            System.out.println("ERROR: No flight leg instances match that given key.");
            return;
        }

        stmt.executeUpdate("update FlightLegInstance SET Pilot = " + ID + " where (FLNO, Seq, FDate) = (" +
                wrapInQuotes(FLNO) + ", " + wrapInQuotes(Seq) + ", " + wrapInQuotes(FDate) + ")");
    }

    // Add a pilot to the database. Input is ID, Name, and the date hired.
    public static void addPilot(Statement stmt) throws Exception {
        Scanner s = new Scanner(System.in);

        System.out.print("Enter an ID for the pilot> ");
        String ID = s.nextLine();
        System.out.print("Enter name of pilot> ");
        String name = s.nextLine();
        System.out.print("Enter the date hired for " + name + " in format year-month-day> ");
        String date = s.nextLine();

        ResultSet rs;

        // Check and throw error if another pilot exists with same ID. Don't add to database
        rs = stmt.executeQuery("select * from Pilot where ID = " + wrapInQuotes(ID));
        while (rs.next()) {
            System.out.println("\nERROR: This ID is already in use.");
            return;
        }
        // Check and ask user to continue if pilot exists with same name
        rs = stmt.executeQuery("select * from Pilot where Name = " + wrapInQuotes(name));
        while (rs.next()) {
            System.out.print("\nERROR: This name is already in use.\nWould you like to continue? (y/n)> ");
            String input = s.nextLine();
            if (input.equals("y") || input.equals("yes")) {
                break;
            } else {
                return;
            }
        }

        stmt.executeUpdate("insert into Pilot values (" + ID + ", " + wrapInQuotes(name) + ", " + wrapInQuotes(date) + ")");
    }

    // Helper function to wrap strings in quotes for use with query strings
    public static String wrapInQuotes(String s) {
        return "\"" + s + "\"";
    }

}