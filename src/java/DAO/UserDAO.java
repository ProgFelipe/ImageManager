package DAO;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Felipe
 */
import Servlet.ConnectionManager;
import Bean.UserBean;
import Servlet.UploadServlet;
 import java.text.*;
   import java.util.*;
   import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

   public class UserDAO 	
   {
      static Connection currentCon = null;
      static ResultSet rs = null;  
	
	
	
      public static UserBean login(UserBean bean) {
	
         //preparing some objects for connection 
         Statement stmt = null;    
	
         String username = bean.getUsername();    
         String password = bean.getPassword();   
	    
         String searchQuery =
               "select * from t_users where user='"
                        + username
                        + "' AND password='"
                        + password
                        + "'";
	    
      // "System.out.println" prints in the console; Normally used to trace the process
      System.out.println("Your user name is " + username);          
      System.out.println("Your password is " + password);
      System.out.println("Query: "+searchQuery);
	    
      try 
      {
         //connect to DB 
         currentCon = ConnectionManager.getConnection();
         stmt=currentCon.createStatement();
         rs = stmt.executeQuery(searchQuery);	        
         boolean more = rs.next();
	       
         // if user does not exist set the isValid variable to false
         if (!more) 
         {
            System.out.println("Sorry, you are not a registered user! Please sign up first");
            bean.setValid(false);
         } 
	        
         //if user exists set the isValid variable to true
         else if (more) 
         {
            String firstName = rs.getString("user");
	     	
            System.out.println("Welcome " + firstName);
            bean.setUserName(firstName);
            bean.setValid(true);
         }
      } 

      catch (Exception ex) 
      {
         System.out.println("Log In failed: An Exception has occurred! " + ex);
      } 
	    
      //some exception handling
      finally 
      {
         if (rs != null)	{
            try {
               rs.close();
            } catch (Exception e) {}
               rs = null;
            }
	
         if (stmt != null) {
            try {
               stmt.close();
            } catch (Exception e) {}
               stmt = null;
            }
	
         if (currentCon != null) {
            try {
               currentCon.close();
            } catch (Exception e) {
            }

            currentCon = null;
         }
      }

return bean;
	
      }
      
      public static boolean Register(UserBean bean ){
       //preparing some objects for connection 
         Statement stmt = null;    
         boolean register = false;
         String username = bean.getUsername();    
         String password = bean.getPassword();   
	 
         String searchQuery = "select * from t_users where user='" + username+ "'";
         String registerQuery = "insert into t_users(user, password) values ('"+username+"','"+password+"')";
	 
      // "System.out.println" prints in the console; Normally used to trace the process
      System.out.println("Your user name is " + username);          
      System.out.println("Your password is " + password);
      System.out.println("Query: "+registerQuery);
	    
      try 
      {
         //connect to DB 
         currentCon = ConnectionManager.getConnection();
         stmt=currentCon.createStatement();
         rs = stmt.executeQuery(searchQuery);
         boolean more = rs.next();
         System.out.println("**¨*¨*¨*¨*UserID existente ? "+ more);
         if(more){
             //User exist
         }else{
             //register User
             register = true;
             stmt.executeUpdate(registerQuery);
         }
      } 
      catch (Exception ex) 
      {
         System.out.println("Register fail: An Exception has occurred! " + ex);
      } 
          return register;
      }
      
      
     public String getUserId(String userName){
         //connect to DB 
            currentCon = ConnectionManager.getConnection();           
            String searchQuery = "select * from t_users where user='" + userName + "'";
            String userid = "";
            try {
                Statement stmt1 =currentCon.createStatement();
                rs = stmt1.executeQuery(searchQuery);
                boolean more = rs.next();
                // if user does not exist set the isValid variable to false
                    if (!more) 
                    {
                       System.out.println("Sorry, you are not a registered user! Please sign up first");
                    } 
                    //if user exists set the isValid variable to true
                    else if (more) 
                    {
                        userid = rs.getString("id_usuario");
                        System.err.println("Usuauriaiuiisaiduiausi "+userid);
                    }
            } catch (SQLException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            }finally {
            if (currentCon != null) {
                // closes the database connection
                try {
                    currentCon.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            }
        return userid;
        }
   }
