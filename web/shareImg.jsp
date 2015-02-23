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
        <h2>Search the user(s) you want to share the <%=file%></h2>
        <form action="share" method="post" >
            <input type="text" id="demo-input" name="shareWith" />
            <input id="shareButton" type="submit" value="Share" />
            <script type="text/javascript">
            $(document).ready(function() {
                $("#demo-input").tokenInput("userSearch", {preventDuplicates: true});
            });
            </script>
        </form>
    </div>
        <h2 style="color: red; margin: 0 auto; text-align: center;">${requestScope.message}</h2><br/>
    </body>
</html>
