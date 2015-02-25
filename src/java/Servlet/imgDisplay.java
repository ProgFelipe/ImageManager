/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Bean.UserBean;
import DAO.UserDAO;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Felipe
 */
@WebServlet("/servlet1")
public class imgDisplay extends HttpServlet{

  public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException{
        String category = request.getParameter("category");
        String filename = request.getParameter("filename");
        String userId = request.getParameter("userid");
        //If userId == null means there are a logged user
        if(userId == null){
                //Current session User
                HttpSession s=request.getSession();
                UserBean currentUser = (UserBean) (s.getAttribute("currentSessionUser"));
                if(currentUser != null){
                String user = currentUser.getUsername().toString().trim();
                //Get user id
		UserDAO daoUser = new UserDAO();
                userId = daoUser.getUserId(user);}
        }
        if(userId != null){
            response.setContentType("image/jpeg");
            ServletOutputStream out;
            out = response.getOutputStream();
            StorageManager stm = new StorageManager();
            FileInputStream fin = new FileInputStream(stm.getStoragePath()+userId+"/"+category+"/"+filename);
            BufferedInputStream bin = new BufferedInputStream(fin);
            BufferedOutputStream bout = new BufferedOutputStream(out);
            int ch =0; ;
            while((ch=bin.read())!=-1)
            {
                bout.write(ch);
            }
            bin.close();
            fin.close();
            bout.close();
            out.close();
        }
  }
}
