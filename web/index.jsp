<%-- 
    Document   : index
    Created on : 09-feb-2015, 16:40:53
    Author     : Felipe
--%>

<%@page import="DAO.UserDAO"%>
<%@page import="Servlet.StorageManager"%>
<%@page import="Servlet.ConnectionManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"
        import="Bean.UserBean"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>JSP Page</title>
        <style type="text/css"><%@ include file="Styles/styles.css"%></style>
        <style type="text/css"><%@ include file="Styles/mobile.css"%></style>
                <style type="text/css">
            table{
                float:left;
                display: inline-block;
            }
            table tr td{
                border: solid; border-width: 1px;
            }
        </style>
    </head>
    <body>
                <article>
  <header>
    <% UserBean currentUser = (UserBean) (session.getAttribute("currentSessionUser"));%>
    <h1>WELCOME <% if(currentUser != null){out.print(currentUser.getUsername());}else{out.print("VISITOR");}; %></h1>  
    
  </header>
  <p>WWF's mission is to stop the degradation of our planet's natural environment,
  and build a future in which humans live in harmony with nature.</p>
</article>
        <nav id="menu">
            <ul>
		<li><a href="index.jsp">Home</a></li>
		<li>
			<a href="#">Categories ￬</a>
			<ul class="hidden">
                            	<li><a href="index.jsp?category=Photo">Photo</a></li>
				<li><a href="index.jsp?category=Paints">Paints</a></li>
                                <li><a href="index.jsp?category=Nature">Nature</a></li>
                                <li><a href="index.jsp?category=Abstract">Abstract</a></li>
			</ul>
		</li>
		<li><a href="registro.jsp">Register</a></li>
		<li><a href="uploader.jsp">Upload</a></li>
                <% if(currentUser != null){%><li><a href="userImgs.jsp">My Images</a></li><%}%>
            </ul>
	</nav>
        <br/>

        <!--
        User keys and images
        <a style="color: red;" href="images.jsp">All User Images</a>-->
        <% String category = request.getParameter("category");
            if(category != null ){
                
            %>
            
            
            <h2>Gallery ¡<%out.print(category);%>!</h2>
            <div id="gallery">
        <ul>
        <%
            List imageUrlList = new ArrayList();  
            //Get userS ids
            Connection con = ConnectionManager.getConnection();
            Statement stm = con.createStatement();
            ResultSet rss;
            String part = request.getParameter("part");
            if(part != null){
                //Start on row part
                int ipart = Integer.parseInt(part)*10;
                //Next 10 rows
                int next = ipart+10;
                rss = stm.executeQuery("SELECT * FROM t_imgs where category = '"+category+"' ORDER BY date DESC LIMIT "+ipart+","+next+"");
            }else{
                rss = stm.executeQuery("SELECT * FROM t_imgs where category = '"+category+"' ORDER BY date DESC LIMIT 10");}
    while(rss.next()){
            String userId = rss.getString(2).toString().trim();
            String file = rss.getString(3).toString().trim();
            String categories = rss.getString(4).toString().trim();
            String date = rss.getString(5).toString().trim();
            StorageManager storagepath = new StorageManager();
            File imageDir = new File(storagepath.getStoragePath()+userId);  
            if(imageDir.isDirectory()){
  %>
    <li id="imgRow">
        <img style="width:200px; height: 200px;" src="servlet1?filename=<%=file%>&&userid=<%=userId%>&&category=<%=categories%>">
        <p>Name: <%out.print(file);%></p>
        <p>Upload: <%out.print(date);%></p>
        <%if(currentUser != null){ %>
        <a class="option" target="_blank" href="servlet1?filename=<%=file%>&&userid=<%=userId%>&&category=<%=categories%>">Download photo</a>
        <a class="option" href="shareImg.jsp?filename=<%=file%>&&category=<%=categories%>">Share photo</a>
        <%}%>
    </li>
<%
    }}%>
            </ul>   
            <ul>
                <% rss = stm.executeQuery("SELECT count(*) FROM t_imgs where category = '"+category+"'");
       rss.next();
       int rows = rss.getInt(1);
       int parts = Math.round(rows/10);
       stm.close();
       rss.close();
       con.close();
       for(int c = 0; c <= parts; c++){
    %>
    <li id="parts"><a href="index.jsp?part=<%=c%>&&category=<%=category%>"><%=c%></a></li>
    <%}%>
    </ul>
</div><%}else{%>          
                     <h2>Gallery</h2>
                     <div id="gallery">
                      <%@page import="java.io.*" %> 
        <%@page import="java.util.*" %> <%!        
        public void GetDirectory(String a_Path, Vector a_files, Vector a_folders) {
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
            GetDirectory(storagepath.getStoragePath(), l_Files, l_Folders);%> 
            <ul>                
        <%
            List imageUrlList = new ArrayList();  
            //Get userS ids
            Connection con = ConnectionManager.getConnection();
            Statement stm = con.createStatement();
            String part = request.getParameter("part");
            ResultSet rss;
            if(part != null){
                //Start on row part
                int ipart = Integer.parseInt(part)*10;
                //Next 10 rows
                int next = ipart+10;
                rss = stm.executeQuery("SELECT * FROM t_imgs ORDER BY date DESC LIMIT "+ipart+","+next+"");
            }else{
                rss = stm.executeQuery("SELECT * FROM t_imgs ORDER BY date DESC LIMIT 10");
            }
    while(rss.next()){
            String userId = rss.getString(2).toString().trim();
            String file = rss.getString(3).toString().trim();
            String categories = rss.getString(4).toString().trim();
            String date = rss.getString(5).toString().trim();
            File imageDir = new File(storagepath.getStoragePath()+userId);  
            if(imageDir.isDirectory()){
  %>
    <li id="imgRow">
        <img style="width:200px; height: 200px;" src="servlet1?filename=<%=file%>&&userid=<%=userId%>&&category=<%=categories%>">
        <p>Name: <%out.print(file);%></p>
        <p>Upload: <%out.print(date);%></p>
        <%if(currentUser != null){ %>
        <a class="option" target="_blank" href="servlet1?filename=<%=file%>&&category=<%=categories%>&&userid=<%=userId%>">Download photo</a>
        <a class="option" href="shareImg.jsp?filename=<%=file%>&&category=<%=categories%>">Share photo</a>
        <%}%>   
    </li>
<%
    }}%>
    </ul>
    <ul>
    <% rss = stm.executeQuery("SELECT count(*) FROM t_imgs");
       rss.next();
       int rows = rss.getInt(1);
       int parts = (Integer)rows/10;
       stm.close();
       rss.close();
       con.close();
       for(int c = 0; c <= parts; c++){
    %>
    <li id="parts"><a href="index.jsp?part=<%=c%>"><%=c%></a></li>
    <%}%>
    </ul>
                 </div>
         <%}%>
    

       
    <div id="clientBox">
    <% if(currentUser != null){%>
    <form id="logOut" action="LogOut">
        <input type="submit" value="Log Out"/>
    </form>
    <%}else{%>
    <p>Login</p>
        <form action="LoginAuth">
            <span>UserID:</span><br/> <input type="text" name="userId" value=""/><br/>
            <span>Password:</span><br/> <input type="password" name="password" value=""/><br/>
            <input type="submit" value="Login">
        </form>
    <%}%>
        <p><a href="registro.jsp">Register</a></p>
        <p><a href="uploader.jsp">Upload File</a></p>
    </div>
        <div id="Devs">
            <span>Developers:</span> <a  href="https://plus.google.com/113546192742040163511/posts" target="_blank">Felipe Gutiérrez</a><span> and</span>
            <a  href="https://plus.google.com/100113038660504044024" target="_blank">Carolina Yepes</a>
            </br>
            <h3>Universidad EAFI - Tópicos en telemática</h3>
        </div>
    </body>
</html>
