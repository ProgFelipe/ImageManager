<%-- 
    Document   : index
    Created on : 09-feb-2015, 15:06:24
    Author     : Felipe Gutiérrez
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
             import="Bean.UserBean"%>
<!DOCTYPE html>
<html>
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
<title>File Upload</title>
<style type="text/css"><%@ include file="Styles/styles.css"%></style>
        <style type="text/css"><%@ include file="Styles/mobile.css"%></style>
        <style type="text/css">
            body{
                margin: 0 auto;
                text-align: center;
                background-color: #EEEEEE;
            }
uplform{
    float: left;
    margin-left: 17%;
}
        </style>
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
<center>         
			
            <% if(currentUser != null){out.print("Current user : "+currentUser.getUsername()); %>         
	<h1>File Uploader</h1>


	<form id="uplform" method="post" action="UploadServlet" enctype="multipart/form-data">
            <span> Select file to upload:</span><input type="file" name="file" size="60" /> <span>( Max size 16 mb)</span> <br />
            <!---<span>File name: </span><input type="text" name="fileName"/><br/>-->
            <span>Choose Category: </span><select name="category" id="categories">
                <option value="photo" selected>Photo</option>
                <option value="paints">Paints</option>
                <option value="nature">Nature</option>
                <option value="abstract">Abstract</option>
            </select>
		<br /> <input type="submit" value="Upload" />
	</form>
        <%
        }else{out.print("<p style='color: red;'>VISITOR: ONLY REGISTER USERS CAN UPLOAD IMAGES</p>");
            %>
            <br/>
            <a href="registro.jsp">Register</a>
            <br/>
            <a href="index.jsp">Back to Home</a>
            <br/>
            <p>Or Login</p>
            <%
            };
        %>
</center>
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
        <h2 style="color: red;">${requestScope.message}</h2><br/>
</body>
</html>