<%-- 
    Document   : searchUser
    Created on : 22-feb-2015, 7:26:36
    Author     : Felipe
--%>

<%@page import="Bean.UserBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="javascript/jquery.tokeninput.js"></script>
    <style type="text/css">
        #Devs{
    width: 100%;
    height: 100%;
    margin: 0 auto;
    float: left;
    display: inline-block;
    margin-top: 20px;
    text-align: center;
    color: #ffffff;
    background-color: #2F3036;
    bottom: 0;
    left: 0;
    }
    #Devs a{
        color: #ffffff;
    }
    </style>
    <link rel="stylesheet" href="Styles/token-input.css" type="text/css" />
    <link rel="stylesheet" href="Styles/token-input-facebook.css" type="text/css" />
    <style type="text/css"><%@ include file="Styles/share.css"%></style>
        <title>JSP Page</title>
        
            <script type="text/javascript">
    $(document).ready(function() {
        $("input[type=button]").click(function () {
            alert("Would submit: " + $(this).siblings("input[type=text]").val());
        });
    });
    </script>
    </head>
    <body>
<!--        <form name="users">
<input type="text" name="name" id="name" onkeyup="showData(this.value);"><br>
        </form>
<ul id="results">
</ul>-->
<%String file = request.getParameter("filename");
  String category = request.getParameter("category");
%>
    <div id="shareBox">
        <h2>Search the user(s) you want to share <%=file%> on <%=category%></h2>
        <form action="share" method="post" >
            <input type="text" id="demo-input" name="shareWith" />
            <input type="hidden" name="imgName" value="<%=file%>">
            <input type="hidden" name="category" value="<%=category%>">
            <input id="shareButton" type="submit" value="Share" />
            <script type="text/javascript">
            $(document).ready(function() {
                $("#demo-input").tokenInput("userSearch", {preventDuplicates: true});
            });
            </script>
        </form>
    </div>
        <h2 style="color: red; margin: 0 auto; text-align: center;">${requestScope.message}</h2><br/>
                <div id="Devs">
            <span>Developers:</span> <a  href="https://plus.google.com/113546192742040163511/posts" target="_blank">Felipe Gutiérrez</a><span> and</span>
            <a  href="https://plus.google.com/100113038660504044024" target="_blank">Carolina Yepes</a>
            </br>
            <h3>Universidad EAFI - Tópicos en telemática</h3>
        </div>
    </body>
</html>
