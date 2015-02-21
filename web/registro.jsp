<%-- 
    Document   : insertar
    Created on : 09-feb-2015, 21:51:09
    Author     : Felipe
--%>

<%@page import="Bean.UserBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css"><%@ include file="Styles/styles.css"%></style>
        <style type="text/css"><%@ include file="Styles/mobile.css"%></style>
        <style type="text/css">
            body{
                margin: 0 auto;
                text-align: center;
                background-color: #EEEEEE;
            }
            reguser{
                border-style: solid;
                border-width: 2px;
                background-color: yellow;
                width: 20%;
                text-align: center;
                float: left;
                margin: 0 auto;
            }
        </style>
    </head>
    <body>
        <h1>Register!</h1>
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
            <% if(currentUser != null){out.print("<p style='color: red'>Log out to register an user</p><p style='color: blue;'>Current User:  "+currentUser.getUsername()+"</p>");}else{ %>
        <form id="reguser" name="reguser" action="UserRegister">
            UserID:<br/> <input type="text" name="txtuser"/><br/>
            Password:<br/> <input type="password" name="txtpass"/><br/><br/>
            Confirm Password:<br/><input type="password" name="txtpass2"/><br/><br/>
            <input type="submit" value="Register" />
        </form>
        <%};%>
    <div id="clientBox">
            <% if(currentUser != null){%>
    <form id="logOut" action="LogOut">
        <input type="submit" value="Log Out"/>
    </form>
    <%}else{%>
    <%}%>
        <p><a href="registro.jsp">Register</a></p>
        <p><a href="uploader.jsp">Upload File</a></p>
    </div> 
        <h2 style="color: red;">${requestScope.message}</h2><br/>
    </body>
</html>
