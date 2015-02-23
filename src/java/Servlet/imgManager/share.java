/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet.imgManager;

import Bean.UserBean;
import DAO.ImageDAO;
import DAO.UserDAO;
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
@WebServlet("/share")
public class share extends HttpServlet{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String sharedUsers = request.getParameter("shareWith");
        String imgName = request.getParameter("imgName");
        String imgCategory = request.getParameter("category");
        
                //Current session User
                HttpSession s=request.getSession();
                UserBean currentUser = (UserBean) (s.getAttribute("currentSessionUser"));
                String user = currentUser.getUsername();
                //Get user id
		UserDAO daoUser = new UserDAO();
                String userId = daoUser.getUserId(user);
                
                String users[] = sharedUsers.split(",");
                boolean send = false;
                for(int c = 0; c<users.length; c++){
                    send = ImageDAO.shareImg(userId, users[c], imgName, imgCategory);
                }
                if(send){
                request.setAttribute("message", "Shared Successfully with "+sharedUsers+" ; "+imgName+", "+imgCategory+"</br><a href='index.jsp'>Home</a>");
                }else{
                request.setAttribute("message", "There was an error");
                }
        getServletContext().getRequestDispatcher("/shareImg.jsp").forward(
            		request, response);
    }
    
}
