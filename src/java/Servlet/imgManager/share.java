/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet.imgManager;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Felipe
 */
@WebServlet("/shareImg")
public class share extends HttpServlet{
    protected void doGET(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String users = request.getParameter("shareWith");
        System.err.println("Users :"+ users);
        request.setAttribute("message", "Share Successfull");
        getServletContext().getRequestDispatcher("/shareImg.jsp").forward(
            		request, response);
    }
    
}
