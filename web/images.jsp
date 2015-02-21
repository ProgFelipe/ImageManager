<%-- 
    Document   : images
    Created on : 18-feb-2015, 18:47:21
    Author     : Felipe
--%>

<%@page import="Servlet.ConnectionManager"%>
<%@page import="Bean.UserBean"%>
<%@page import="DAO.UserDAO"%>
<%@page import="Servlet.StorageManager"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
            table{
                margin: 0 auto;
                text-align: center;
            }
            table tr td{
                border: solid; border-width: 1px;
            }
            body{
                margin: 0 auto;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <h1>Hello this are all the images!</h1>
        <table style="border: solid; border-width: 2px;">
                    <tr>
                        <td>PrimaryKey</td>
                        <td>UserId(Foreing)</td>
                        <td>imgName</td>
                        <td>Category</td>
                        <td>Date</td>
                    </tr>
        <%
            ConnectionManager cmng = new ConnectionManager();
             Connection con = cmng.getConnection();
             Statement stm = con.createStatement();
             ResultSet rs = stm.executeQuery("select * from t_imgs");
             while(rs.next()){
            %>
            
                    <tr>
                        <td><%out.print(rs.getString(1));%></td>
                        <td><%out.print(rs.getString(2));%></td>
                        <td><%out.print(rs.getString(3));%></td>
                        <td><%out.print(rs.getString(4));%></td>
                        <td><%out.print(rs.getString(5));%></td>
                    </tr>
            
            <%}%>
        </table>
        <table>
            <tr style="color: blueviolet;"><td>All images</td><td>Files</td><tr>
             <%@page import="java.io.*" %> 
        <%@page import="java.util.*" %> 
        <%!        public void GetDirectory(String a_Path, Vector a_files, Vector a_folders) {
                File l_Directory = new File(a_Path);
                File[] l_files = l_Directory.listFiles();

                for (int c = 0; c < l_files.length; c++) {
                    if (l_files[c].isDirectory()) {
                        a_folders.add(l_files[c].getName());
                    } else {
                        a_files.add(l_files[c].getName());
                    }
                }


            }
        %> 
                    <%
            Vector l_Files = new Vector(), l_Folders = new Vector();
            StorageManager storagepath = new StorageManager();
            GetDirectory(storagepath.getStoragePath(), l_Files, l_Folders);

            //folders should be left out... 
            //for( int a = 0 ; a<l_Folders.size() ; a++ ) 
            //out.println( "[<b>"+l_Folders.elementAt(a).toString() + "</b>]<br>") ; 

            //generate files as XML 


            for (int a = 0; a < l_Files.size(); a++) {
                //out.println("<img src='" + l_Files.elementAt(a).toString() + "'/>");
                out.println("<p>" + l_Files.elementAt(a).toString() + "</p>");
            }

        %> 
        <%
        
                
               String userId = "";
    ResultSet rss = stm.executeQuery("SELECT id_usuario FROM t_users");
    while(rss.next()){
            List imageUrlList = new ArrayList();
            userId = rss.getString(1).toString().trim();
            System.err.println("USUARIO USUARIO "+userId);
            File imageDir = new File(storagepath.getStoragePath()+userId);  
            System.err.println(imageDir);
imageDir = new File(storagepath.getStoragePath()+userId);
if(imageDir.isDirectory()){
for(File imageFile : imageDir.listFiles()){  
  String imageFileName = imageFile.getName();    
  %>
    <tr>
        <td><p><%=imageFileName%></p></td>
        <td><a href="servlet1?filename=<%=imageFileName%>&&userid=<%=userId%>">click for photo</a></td>
    </tr>
<%
}
}
    }
        %>
        </table>
    </body>
</html>

