/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Bean.UserBean;
import DAO.UserDAO;
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
/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/UserRegister")
public class UserRegister extends HttpServlet{
    
    public void doGet(HttpServletRequest request, HttpServletResponse response) 
			           throws ServletException, java.io.IOException {
        String pass = request.getParameter("txtpass");
        String pass2 = request.getParameter("txtpass2");
        if(request.getParameter("txtuser").isEmpty() || request.getParameter("txtpass").isEmpty() || request.getParameter("txtpass2").isEmpty()){
        request.setAttribute("message", "UserId or password is empty!");
		getServletContext().getRequestDispatcher("/registro.jsp").forward(
				request, response);
        }else{
            if(!pass.equals(pass2)){
            request.setAttribute("message", "passwords are not the same");
		getServletContext().getRequestDispatcher("/registro.jsp").forward(
				request, response);
            }else{
            UserBean user = new UserBean();
            user.setUserName(request.getParameter("txtuser"));
            user.setPassword(request.getParameter("txtpass"));
            request.getParameter("txtpass2");
            boolean register = UserDAO.Register(user);
                if (register){        
                  HttpSession session = request.getSession(true);	    
                  session.setAttribute("currentSessionUser",user); 
                  response.sendRedirect("uploader.jsp"); //logged-in page      		
                }else{ 
                      request.setAttribute("message", "That User Name already exist!");
		getServletContext().getRequestDispatcher("/registro.jsp").forward(
				request, response);
                    }
        }
        }
    }     
}
