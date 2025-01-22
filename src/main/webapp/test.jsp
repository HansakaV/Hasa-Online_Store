<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 1/21/2025
  Time: 11:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>test</title>
</head>
<body>
<h1>This Is For Testing</h1>
<%
    String name = (String) request.getAttribute("name");
    if (name != null) {
        System.out.println("Name retrieved: " + name);
    } else {
        System.out.println("Name attribute is null.");
    }
%>


</body>
</html>
