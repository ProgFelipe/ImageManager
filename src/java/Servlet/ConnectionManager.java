package Servlet;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Felipe
 */
   import java.sql.*;

public class ConnectionManager {

      static Connection con;
      static String url;
      
      public static Connection getConnection()
      {
         try
         {
            //String url = "jdbc:mysql://localhost/" + "imgdb"; 
            String url = "jdbc:mysql://localhost/" + "fgutier7"; 
            // assuming "imgdb" is your DataSource name
            Class.forName("com.mysql.jdbc.Driver");
            try
            {            	
               //con = DriverManager.getConnection(url,"root",""); 				
                con = DriverManager.getConnection(url,"fgutier7","fgutier7"); 				
            // assuming your SQL Server's	username is "fgutier7"               
            // and password is "fgutier7"
            }catch (SQLException ex)
            {
               ex.printStackTrace();
            }
         }catch(ClassNotFoundException e)
         {
            System.out.println(e);
         }
      return con;
        } 
}
