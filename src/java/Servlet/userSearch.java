/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Felipe
 */
@WebServlet("/userSearch")
public class userSearch extends HttpServlet{
    
    public void doGet(HttpServletRequest request, HttpServletResponse response){
        String name = request.getParameter("q"); 
        try{
           Connection con = ConnectionManager.getConnection();
           Statement st=con.createStatement();
           
           ResultSet rss = st.executeQuery("select count(*) from t_users where user like '"+name+"%'");
           rss.next();
           int rows = rss.getInt(1);
           ResultSet rs = st.executeQuery("select * from t_users where user like '"+name+"%'");
           
           String users = "[";
           int count = 1;
            System.err.println("Numero col "+rows);
           while(rs.next())
            {
            users=users+"{\"id\": \""+rs.getString("id_usuario")+"\", \"name\": \""+rs.getString("user")+"\"}";
            if(count < rows){
                users+=",";
            }
            count++;
            }
           users += "]";
           System.err.println("Users "+users);
           response.getWriter().println(users);
           rss.close();
           rs.close();
           st.close();
           con.close();
        }
         catch (Exception e) {
            e.printStackTrace();
        }
    } 
    
}
