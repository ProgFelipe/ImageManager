<%-- 
    Document   : userImgs
    Created on : 19-feb-2015, 12:06:03
    Author     : Felipe
--%>

<%@page import="DAO.UserDAO"%>
<%@page import="Servlet.StorageManager"%>
<%@page import="Bean.UserBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
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
        <title>JSP Page</title>
    </head>
    <body>
        <%UserBean currentUser = (UserBean) (session.getAttribute("currentSessionUser"));%>
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
            <% if(currentUser != null){
                String user = currentUser.getUsername();%>
        <h1>User: <span style="color: blueviolet;"><%=user%></span> images manager!</h1>
        
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
<%if(currentUser != null){ %>
            <table>
                <tr style="color: blueviolet;">
                    <td>User: <%out.print(currentUser.getUsername());%> </td>
                    <td>Download</td>
                    <td>Delete</td>
                    <td>Share</td>
                </tr>
        <%
            List imageUrlList = new ArrayList();  
            
            //Get user id
            UserDAO daoUser = new UserDAO();
            String userId = daoUser.getUserId(user);
            File imageCategory = new File(storagepath.getStoragePath()+userId);  
for(File imageCat : imageCategory.listFiles()){
        File imageDir = new File(storagepath.getStoragePath()+userId+"/"+imageCat.getName());  
        String category = imageCat.getName();
    for(File imageFile : imageDir.listFiles()){  
        String imageFileName = imageFile.getName();    
  %>
    <tr>
        <td><img style="width:200px; height: 200px;" src="servlet1?filename=<%=imageFileName%>&&category=<%=category%>"></td>
        <td><a href="servlet1?filename=<%=imageFileName%>&&category=<%=category%>">click for photo</a></td>
        <td><a href="deleteImg?filename=<%=imageFileName%>&&category=<%=category%>">Delete photo</a></td>
        <td><a href="shareImg?filename=<%=imageFileName%>&&category=<%=category%>">Share photo</a></td>
    </tr>
<%
    }}%></table><% 
}}%>
    <div id="clientBox">
            <% if(currentUser != null){%>
    <form id="logOut" action="LogOut">
        <input type="submit" value="Log Out"/>
    </form>
    <%}else{%>
    <p>Login</p>
        <form action="LoginAuth">
            <span>UserID: </span><input type="text" name="userId" value=""/><br/>
            <span>Password: </span><input type="password" name="password" value=""/><br/>
            <input type="submit" value="Login">
        </form>
    <%}%>
        <p><a href="registro.jsp">Register</a></p>
        <p><a href="uploader.jsp">Upload File</a></p>
    </div>
    </body>
</html>