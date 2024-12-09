<%--
  Created by IntelliJ IDEA.
  User: E.J.S
  Date: 11/9/2024
  Time: 9:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Delete Student</title>
    <link rel="stylesheet" type="text/css" href="css/style2.css">
</head>
<body>
<div class="container">
    <h2>Delete Student</h2>
    <form action="EmployeeServlet" method="post">
        <input type="hidden" name="action" value="delete">

        <label for="employeeID">Enter Student ID to Delete:</label>
        <input type="text" id="employeeID" name="employeeID" required>

        <!-- Buttons Section -->
        <div class="form-buttons">
            <!-- Back to Menu Button -->
            <button type="button" class="back-button" onclick="window.location.href='index.jsp'">Back to Menu</button>

            <!-- Submit Button -->
            <button type="submit" class="submit-button">Delete</button>
        </div>
    </form>
</div>
</body>
</html>
