<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error</title>
    <link rel="stylesheet" type="text/css" href="css/style2.css">
</head>
<body>
<div class="container">
    <h2>Error</h2>

    <%-- Display error message if it exists --%>
    <% if (request.getAttribute("errorMessages") != null) { %>
    <div class="error-message">
        <p><%= request.getAttribute("errorMessages") %></p>
    </div>
    <% } %>

    <!-- Button to go back to the delete form -->
    <div class="form-buttons">
        <button type="button" class="back-button" onclick="window.location.href='deleteEmployee.jsp'">Back to Delete Form</button>
    </div>
</div>
</body>
</html>
