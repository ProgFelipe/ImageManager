/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet.imgManager;

import Bean.ImgBean;
import Bean.UserBean;
import DAO.ImageDAO;
import DAO.UserDAO;
import Servlet.StorageManager;
import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Felipe
 */
@WebServlet("/deleteImg")
public class delete extends HttpServlet{
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        String fileName = request.getParameter("filename");
        String category = request.getParameter("category");
        String sharedMe = request.getParameter("sharedMe");
        
        HttpSession s=request.getSession();
                UserBean currentUser = (UserBean) (s.getAttribute("currentSessionUser"));
                String user = currentUser.getUsername();
                                //Get user id
		UserDAO daoUser = new UserDAO();
                String userId = daoUser.getUserId(user);
                boolean daoDeleted = false;
                                //Set imgage metadata on DAO
                ImgBean img = new ImgBean();
                img.setUserId(userId);
                img.setCategory(category);
                img.setFileName(fileName);
                if( sharedMe == null ){
                        //Delete file on disk
                        StorageManager stm = new StorageManager();
                        String savePath = stm.getStoragePath()+userId;
                        File f=new File(savePath + File.separator + category + File.separator + fileName);
                        boolean flag=f.delete(); 
                        //Delete reference on dataBase
                        daoDeleted = ImageDAO.deleteImg(img);
                        if(daoDeleted && flag){
                            request.setAttribute("message", "Delete Successfull");
                        }else{
                            request.setAttribute("message", "There Was a problem trying to Delete the image");}
                            getServletContext().getRequestDispatcher("/userImgs.jsp").forward(request, response);
                }else{
                        daoDeleted = ImageDAO.deleteSharedWithMe(img);
                        if(daoDeleted){
                            request.setAttribute("message", "Delete Successfull");
                        }else{request.setAttribute("message", "There Was a problem trying to Delete the image");}
                            getServletContext().getRequestDispatcher("/userImgs.jsp").forward(request, response);
                }

    }
}
