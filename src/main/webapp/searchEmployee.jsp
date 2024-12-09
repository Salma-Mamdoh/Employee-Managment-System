<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search for Employee</title>
    <link rel="stylesheet" type="text/css" href="css/style2.css">
    <script>
        // JavaScript to toggle input fields based on selected search type
        function toggleSearchField() {
            // Hide all fields initially
            document.querySelectorAll('.searchField').forEach(field => field.style.display = 'none');

            // Get the selected search type
            var searchType = document.querySelector('input[name="searchType"]:checked').value;

            // Show the corresponding field
            document.getElementById("searchBy" + searchType.charAt(0).toUpperCase() + searchType.slice(1)).style.display = 'block';
        }
    </script>
</head>
<body>
<div class="container">
    <h2>Search for Employee</h2>
    <form action="EmployeeServlet" method="post">
        <input type="hidden" name="action" value="search">

        <!-- Radio buttons to select search type -->
        <label>
            <input type="radio" name="searchType" value="employeeID" onclick="toggleSearchField()" checked>
            Search by Employee ID
        </label>
        <label>
            <input type="radio" name="searchType" value="designation" onclick="toggleSearchField()">
            Search by Designation
        </label>

        <!-- Input fields for each search type -->
        <div id="searchByEmployeeID" class="searchField">
            <label for="employeeID">Employee ID:</label>
            <input type="text" id="employeeID" name="employeeID">
        </div>

        <div id="searchByDesignation" class="searchField" style="display: none;">
            <label for="designation">Designation:</label>
            <input type="text" id="designation" name="designation">
        </div>

    </form>
    <div class="form-buttons">
        <!-- Back to Menu Button -->
        <button type="button" class="back-button" onclick="window.location.href='index.jsp'">Back to Menu</button>

        <!-- Submit Button -->
        <button type="submit" class="submit-button">Search</button>
</div>
</body>
</html>
