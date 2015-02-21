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
            String url = "jdbc:mysql://localhost/" + "imgdb"; 
            // assuming "DataSource" is your DataSource name
            Class.forName("com.mysql.jdbc.Driver");
            try
            {            	
               con = DriverManager.getConnection(url,"root",""); 				
            // assuming your SQL Server's	username is "root"               
            // and password is ""
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
