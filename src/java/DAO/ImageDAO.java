/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Bean.ImgBean;
import static DAO.UserDAO.currentCon;
import Servlet.ConnectionManager;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Felipe
 */
public class ImageDAO {
    static Connection currentCon = null;
    static ResultSet rs = null;  
    //preparing some objects for connection 
    Statement stmt = null;   
    
    public byte[] getImage(int id){
        Blob image = null;
        byte[] imgData = null;
        //connect to DB 
        currentCon = ConnectionManager.getConnection();
        try {
            stmt=currentCon.createStatement();
            String Query = "select img from t_imgs where id = '"+id+"'";
            rs = stmt.executeQuery(Query);
            if (rs.next()) {
                    image = rs.getBlob("foto");
                    imgData = image.getBytes(1, (int) image.length());
                    System.out.println("Img found");
            }
            stmt.close();
            currentCon.close();
        } catch (Exception ex) {
            Logger.getLogger(ImageDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
       return imgData;
    }
    
     public static boolean uploadDataImg(ImgBean bean ){
       //preparing some objects for connection 
         Statement stmt = null;    
         boolean register = false;
         String userid = bean.getUserId();    
         String category = bean.getCategory();   
         String filename = bean.getFileName();
	 
         //String searchQuery = "select * from t_imgs where user='" + userid + "'";
         String registerQuery = "insert into t_imgs(userid, fileName, category ) values ('"+userid+"','"+filename+"','"+category+"')";
	 
      // "System.out.println" prints in the console; Normally used to trace the process
      System.out.println("Your userid name is " + userid);          
      System.out.println("Your img category is " + category);
      System.out.println("Your img name is " + filename);
      System.out.println("Query: "+registerQuery);
	    
      try 
      {
         currentCon = ConnectionManager.getConnection();
         stmt=currentCon.createStatement();
         stmt.executeUpdate(registerQuery);
         register = true;
         currentCon.close();
         stmt.close();
         //connect to DB 
         /*currentCon = ConnectionManager.getConnection();
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
         }*/
      } 
      catch (Exception ex) 
      {
         System.out.println("Upload fail: An Exception has occurred! " + ex);
      } 
          return register;
      }
     public static boolean deleteImg(ImgBean bean){
         Statement stmt = null;    
         boolean deleted = false;
         String userid = bean.getUserId();    
         String category = bean.getCategory();   
         String filename = bean.getFileName();
         //delete from t_imgs where userid = 1 and category = 'null' and fileName = 'P1010844.JPG'
         String registerQuery = "delete from t_imgs where userid = "+userid+" and category = '"+category+"' and fileName = '"+filename+"'";
         System.out.println("delete from t_imgs where userid = '"+userid+"' and category = '"+category+"' and fileName = '"+filename+"'");
            // "System.out.println" prints in the console; Normally used to trace the process
          System.out.println("Your userid name is " + userid);          
          System.out.println("Your img category is " + category);
          System.out.println("Your img name is " + filename);
          System.out.println("Query: "+registerQuery);
         try {
         currentCon = ConnectionManager.getConnection();
         stmt=currentCon.createStatement();
         stmt.executeUpdate(registerQuery);
         deleted = true;
         currentCon.close();
         stmt.close();
      }catch (Exception ex) 
      {
         System.out.println("Delete fail: An Exception has occurred! " + ex);
      } 
          return deleted;
     }
}