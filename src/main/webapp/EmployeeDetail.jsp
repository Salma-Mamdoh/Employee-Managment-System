<%@ page import="com.EmployeeApp.Models.KnownLanguage" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<title>Employee Information</title>
<link rel="stylesheet" type="text/css" href="css/style2.css">

<html>
<head>
    <title>Employee Details</title>
</head>
<body>
<div class="container">
    <h2>Employee Details</h2>

    <%
        // Retrieve the "employees" attribute from the request
        java.util.List<com.EmployeeApp.Models.Employee> employees = (java.util.List<com.EmployeeApp.Models.Employee>) request.getAttribute("employees");
    %>

    <% if (employees != null && !employees.isEmpty()) { %>
    <div class="result-summary">
        <p><strong>Number of Employees Found:</strong> <%= employees.size() %></p>
    </div>

    <div class="employee-info">
        <fieldset>
            <legend>Employees Found</legend>
            <% for (com.EmployeeApp.Models.Employee employee : employees) { %>
            <p><strong>ID:</strong> <span><%= employee.getEmployeeID() %></span></p>
            <p><strong>First Name:</strong> <span><%= employee.getFirstName() %></span></p>
            <p><strong>Last Name:</strong> <span><%= employee.getLastName() %></span></p>
            <p><strong>Designation:</strong> <span><%= employee.getDesignation() %></span></p>

            <p><strong>Known Languages and Scores:</strong></p>
            <%
                // Assuming KnownLanguages is a Map<String, Integer> where key is the language and value is the score
                java.util.List<KnownLanguage> languages = employee.getKnownLanguages();
                if (languages != null && !languages.isEmpty()) {
                    out.print("<ul>");
                    for (KnownLanguage language: languages) {
                        out.print("<li><strong>" + language.getLanguageName() + ":</strong> " + language.getScoreOutof100() + "</li>");
                    }
                    out.print("</ul>");
                } else {
                    out.print("<p>No languages available</p>");
                }
            %>

            <hr/> <!-- Separate each employee with a line -->
            <% } %>
        </fieldset>
    </div>
    <% } else { %>
    <div class="error-message">
        <p>No employees were found matching the criteria.</p>
    </div>
    <% } %>

    <div class="form-buttons">
        <!-- Back to Menu Button -->
        <button type="button" class="back-button" onclick="window.location.href='index.jsp'">Back to Menu</button>
    </div>
    </div>
</body>
</html>
