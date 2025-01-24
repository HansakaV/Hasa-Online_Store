<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Customer Save</title>
</head>
<body>
<h1>Customer Save</h1>
<br/>
<%
    String message = request.getParameter("message");
    String error = request.getParameter("error");
%>
<% if (message != null) { %>
<div style="color: green">
    <%= message %>
</div>
<% } %>
<% if (error != null) { %>
<div style="color: red">
    <%= error %>
</div>
<% } %>
<form action="item-save" method="post">
    <label for="Code">Code:</label><br/>
    <input type="text" id="Code" name="customer-name" required/><br/>

    <label for="Name">name:</label><br/>
    <input type="text" id="Name" name="customer-address" required/><br/>

    <label for="Brand">Brand:</label><br/>
    <input type="email" id="Brand" name="customer-email" required/><br/>

    <input type="submit" value="Submit"/>
</form>
</body>
</html>
