<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Enter Employee Information</title>
    <link rel="stylesheet" type="text/css" href="css/style2.css">
    <script type="text/javascript">
        // Validate the form input
        function validateForm() {
            let firstName = document.getElementsByName("firstName")[0].value.trim();
            let lastName = document.getElementsByName("lastName")[0].value.trim();
            let employeeID = document.getElementsByName("employeeID")[0].value.trim();
            let designation = document.getElementsByName("designation")[0].value.trim();
            let numLanguages = document.getElementsByName("numLanguages")[0].value;
            let isValid = true;
            let errorMessage = "";

            // Validate required fields
            if (!firstName || !lastName || !employeeID || !designation) {
                errorMessage = "All fields are required.";
                isValid = false;
            }

            // Validate Employee ID (numeric only)
            if (!/^\d+$/.test(employeeID)) {
                errorMessage = "Employee ID must be numeric.";
                isValid = false;
            }

            // Validate Name (letters and spaces only)
            if (!/^[a-zA-Z\s]+$/.test(firstName)) {
                errorMessage = "First name must contain only letters and spaces.";
                isValid = false;
            }
            if (!/^[a-zA-Z\s]+$/.test(lastName)) {
                errorMessage = "Last name must contain only letters and spaces.";
                isValid = false;
            }

            if (!/^[a-zA-Z\s]+$/.test(designation)) {
                errorMessage = "designation must contain only letters and spaces.";
                isValid = false;
            }

            // Validate Number of Languages
            if (!numLanguages || numLanguages <= 0 || isNaN(numLanguages)) {
                errorMessage = "Number of Known Languages must be at least 1.";
                isValid = false;
            } else {
                // Validate Known Languages (dynamic fields)
                for (let i = 1; i <= numLanguages; i++) {
                    let languageName = document.getElementById("languageName_" + i).value.trim();
                    let languageScore = document.getElementById("languageScore_" + i).value.trim();

                    if (!languageName || !languageScore || isNaN(languageScore) || languageScore < 0 || languageScore > 100) {
                        errorMessage = `Invalid language entry for Language ${i}. Provide a valid name and score (0-100).`;
                        isValid = false;
                        break;
                    }
                }
            }

            // Show error message if validation fails
            if (!isValid) {
                document.getElementById("error").innerHTML = errorMessage;
            } else {
                // Update the hidden languages field before submitting
                updateHiddenLanguagesField();
            }

            return isValid; // Prevent form submission if invalid
        }

        // Dynamically add language fields
        function addLanguageFields() {
            let numLanguages = document.getElementsByName("numLanguages")[0].value;
            let languageFieldsDiv = document.getElementById("languageFields");

            languageFieldsDiv.innerHTML = ''; // Clear previous fields
            for (let i = 1; i <= numLanguages; i++) {
                let languageFieldHTML = `
                    <label for="languageName_${i}">Language ${i}:</label>
                    <input type="text" id="languageName_${i}" name="languageName_${i}" required>
                    <label for="languageScore_${i}">Score (Out of 100):</label>
                    <input type="number" id="languageScore_${i}" name="languageScore_${i}" min="0" max="100" required><br>
                `;
                languageFieldsDiv.innerHTML += languageFieldHTML;
            }
        }

        function updateHiddenLanguagesField() {
            let numLanguages = document.getElementsByName("numLanguages")[0].value;
            let languages = [];

            // Collect all language names and scores
            for (let i = 1; i <= numLanguages; i++) {
                let languageName = document.getElementById("languageName_" + i).value.trim();
                let languageScore = document.getElementById("languageScore_" + i).value.trim();

                if (languageName && languageScore) {
                    // Create a language object with name and score
                    languages.push({
                        languageName: languageName, // Match the backend field name
                        scoreOutof100: parseInt(languageScore) // Match the backend field name
                    });
                }
            }

            // Serialize the languages array into the hidden input field
            document.getElementById("languages").value = JSON.stringify(languages);

            // Debugging: Log the value of the hidden field to check if it's populated
            console.log("Languages Hidden Field:", document.getElementById("languages").value);
        }




    </script>
</head>
<body>
<div class="container">
    <h2>Enter Employee Information</h2>
    <%
        List<String> errorMessages = (List<String>) request.getAttribute("errorMessages");
    %>
    <form action="EmployeeServlet" method="post" onsubmit="return validateForm()">
        <input type="hidden" name="action" value="addEmployee">

        <fieldset>
            <legend>Employee Information</legend>

            <label for="firstName">First Name:</label>
            <input type="text" name="firstName" required>

            <label for="lastName">Last Name:</label>
            <input type="text" name="lastName" required>

            <label for="employeeID">Employee ID:</label>
            <input type="text" name="employeeID" required>

            <label for="designation">Designation:</label>
            <input type="text" name="designation" required>

            <label for="numLanguages">Number of Known Languages:</label>
            <input type="number" name="numLanguages" min="1" onchange="addLanguageFields()" required>

            <div id="languageFields"></div>

            <input type="hidden" name="languages" id="languages"> <!-- Hidden field for languages -->

            <div id="error" style="color: red;"></div>

            <!-- Buttons Section -->
            <div class="form-buttons">
                <!-- Back to Menu Button -->
                <button type="button" class="back-button" onclick="window.location.href='index.jsp'">Back to Menu</button>

                <!-- Submit Button -->
                <button type="submit" class="submit-button">Submit</button>
            </div>
        </fieldset>
    </form>
    <%
        if (errorMessages != null && !errorMessages.isEmpty()) {
    %>
    <div class="error-messages">
        <ul>
            <% for (String errorMessage : errorMessages) { %>
            <li><%= errorMessage %></li>
            <% } %>
        </ul>
    </div>
    <%
        }
    %>
</div>
</body>
</html>
