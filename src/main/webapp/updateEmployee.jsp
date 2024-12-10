<%@ page import="com.EmployeeApp.Models.Employee" %>
<%@ page import="java.util.List" %>
<%@ page import="com.EmployeeApp.Models.KnownLanguage" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Employee Information</title>
    <link rel="stylesheet" type="text/css" href="css/style2.css">
    <script>
        const availableLanguages = [
            "Java", "C#", "C++", "Python", "JavaScript", "Ruby", "Go", "Swift", "PHP", "TypeScript",
            "Kotlin", "Rust", "SQL", "Scala", "Perl", "R", "Objective-C", "Lua", "MATLAB", "Haskell",
            "Assembly", "Dart", "Elixir", "Groovy", "Clojure", "F#", "VHDL", "Verilog", "Erlang", "Julia",
            "Forth", "COBOL", "Fortran", "ActionScript", "Hack", "Shell", "Tcl", "Prolog", "OCaml", "Smalltalk",
            "PowerShell", "Awk", "PostScript", "Simula", "Ada", "Chapel", "Nim", "Crystal", "Zig", "Vala",
            "GDScript", "Racket", "Xojo", "Solidity", "Vimscript", "Mercury", "Eiffel", "AutoHotkey",
            "Delphi", "Fantom", "Lisp", "OpenCL", "CUDA", "Turing", "SAS", "LabVIEW", "Logo", "NATURAL", "ML",
            "ABAP", "Io", "Wolfram", "PureScript", "Algol", "Curl"
        ];

        // Add new language entry to the form
        function addNewLanguage() {
            const container = document.getElementById("languages-container");

            const index = container.children.length;

            const entry = document.createElement("div");
            entry.className = "language-entry";
            entry.innerHTML = `
                <label for="languageName${index}">Language:</label>
                <select name="languageName${index}" id="languageName${index}">
                    ${availableLanguages.map(lang => `<option value="${lang}">${lang}</option>`).join('')}
                    <option value="Other">Other (Enter below)</option>
                </select>
                <input type="text" name="newLanguageName${index}" id="newLanguageName${index}" placeholder="Enter new language" style="display:none;" />

                <label for="languageScore${index}">Score:</label>
                <input type="number" name="languageScore${index}" id="languageScore${index}" min="0" max="100" required />
                <button type="button" onclick="removeLanguage(this)">Remove</button>

            `;
            container.appendChild(entry);

            const dropdown = entry.querySelector(`select[name="languageName${index}"]`);
            const newLanguageField = entry.querySelector(`input[name="newLanguageName${index}"]`);

            dropdown.addEventListener("change", function () {
                if (this.value === "Other") {
                    newLanguageField.style.display = "inline";
                } else {
                    newLanguageField.style.display = "none";
                }
            });
        }

        // Remove a language entry from the form
        function removeLanguage(button) {
            const entry = button.parentNode;
            entry.remove();
        }
        // Form validation logic
        function validateForm(event) {
            event.preventDefault();

            const firstName = document.getElementById("firstName").value.trim();
            const lastName = document.getElementById("lastName").value.trim();
            const designation = document.getElementById("designation").value.trim();

            let isValid = true;
            let errorMessage = "";

            // Validate first name
            if (firstName === "" || !/^[A-Za-z\s]+$/.test(firstName)) {
                errorMessage += "Invalid First Name.\n";
                isValid = false;
            }

            // Validate last name
            if (lastName === "" || !/^[A-Za-z\s]+$/.test(lastName)) {
                errorMessage += "Invalid Last Name.\n";
                isValid = false;
            }

            // Validate designation
            if (designation === "") {
                errorMessage += "Designation cannot be empty.\n";
                isValid = false;
            }

            // Validate language scores
            const languageNames = document.querySelectorAll("[name^='languageName']");
            const languageScores = document.querySelectorAll("[name^='languageScore']");

            languageScores.forEach((score, index) => {
                const name = languageNames[index].value.trim();
                if (name === "" ) {
                    errorMessage += `Invalid language name at position ${index + 1}.\n`;
                    isValid = false;
                }
                if (!/^\d+$/.test(score.value) || parseInt(score.value) < 0 || parseInt(score.value) > 100) {
                    errorMessage += `Invalid score for language at position ${index + 1}. Must be between 0 and 100.\n`;
                    isValid = false;
                }
            });

            if (!isValid) {
                alert(errorMessage);
                return false;
            }

            // Update the hidden languages field
            updateHiddenLanguagesField();

            // Submit the form if valid
            document.getElementById("updateEmployeeForm").submit();
        }

        // Update the hidden languages field with selected language names and scores
        function updateHiddenLanguagesField() {
            let languages = [];

            // Collect all language names and scores
            const languageNames = document.querySelectorAll("[name^='languageName']");
            const languageScores = document.querySelectorAll("[name^='languageScore']");

            languageScores.forEach((score, index) => {
                const name = languageNames[index].value.trim();
                if (name && score.value) {
                    // Create a language object with name and score
                    languages.push({
                        languageName: name, // Match the backend field name
                        scoreOutof100: parseInt(score.value) // Match the backend field name
                    });
                }
            });

            // Serialize the languages array into the hidden input field
            document.getElementById("languages").value = JSON.stringify(languages);

            // Debugging: Log the value of the hidden field to check if it's populated
            console.log("Languages Hidden Field:", document.getElementById("languages").value);
        }
    </script>
</head>
<body>
<div class="container">
    <h1>Update Employee Information</h1>
    <!-- Form for searching employee by ID -->
    <form action="EmployeeServlet" method="post">
        <input type="hidden" name="action" value="update">
        <label for="employeeId">Enter Employee ID to update:</label>
        <input type="text" id="employeeID" name="employeeID" required>
        <div class="form-buttons">
            <!-- Submit Button -->
            <button type="submit" class="submit-button">Search</button>
        </div>
    </form>
    <%
        String employeeId = request.getParameter("employeeID");

        if (employeeId != null && !employeeId.trim().isEmpty()) {
            List<Employee> employees = (List<Employee>) request.getAttribute("employees");

            if (employees != null && !employees.isEmpty()) {
                Employee matchedEmployee = null;

                for (Employee employee : employees) {
                    if (employee.getEmployeeID().equals(employeeId.trim())) {
                        matchedEmployee = employee;
                        break;
                    }
                }

                if (matchedEmployee != null) {
    %>
    <div class="scrollable-container">
    <!-- Update Employee Form -->
    <form id="updateEmployeeForm" action="EmployeeServlet" method="post" onsubmit="validateForm(event)">
        <input type="hidden" name="action" value="updateEmployee">
        <fieldset>
            <legend>Employee Information</legend>
            <label for="employeeID">Employee ID:</label>
            <input type="text" name="employeeID" id="employeeID" value="<%= matchedEmployee.getEmployeeID() %>" readonly required>

            <label for="firstName">First Name:</label>
            <input type="text" name="firstName" id="firstName" value="<%= matchedEmployee.getFirstName() %>" required>

            <label for="lastName">Last Name:</label>
            <input type="text" name="lastName" id="lastName" value="<%= matchedEmployee.getLastName() %>" required>

            <label for="designation">Designation:</label>
            <input type="text" name="designation" id="designation" value="<%= matchedEmployee.getDesignation() %>" required>

            <label>Known Languages:</label>
            <div id="languages-container">
                <%
                    int languageIndex = 0;
                    List<String> allLanguages = List.of("Java", "C#", "C++", "Python", "JavaScript", "Ruby", "Go", "Swift", "PHP",
                            "TypeScript", "Kotlin", "Rust", "SQL", "Scala", "Perl", "R", "Objective-C",
                            "Lua", "MATLAB", "Haskell", "Assembly", "Dart", "Elixir", "Groovy", "Clojure",
                            "F#", "VHDL", "Verilog", "Erlang", "Julia", "Forth", "COBOL", "Fortran",
                            "ActionScript", "Hack", "Shell", "Tcl", "Prolog", "OCaml", "Smalltalk",
                            "PowerShell", "Awk", "PostScript", "Simula", "Ada", "Chapel", "Nim", "Crystal",
                            "Zig", "Vala", "GDScript", "Racket", "Xojo", "Solidity", "Vimscript",
                            "Mercury", "Eiffel", "AutoHotkey", "Delphi", "Fantom", "Lisp", "OpenCL",
                            "CUDA", "Turing", "SAS", "LabVIEW", "Logo", "NATURAL", "ML", "ABAP", "Io",
                            "Wolfram", "PureScript", "Algol", "Curl");

                    for (KnownLanguage lang : matchedEmployee.getKnownLanguages()) {
                %>
                <div class="language-entry">
                    <label for="languageName<%= languageIndex %>">Language:</label>
                    <select name="languageName<%= languageIndex %>" id="languageName<%= languageIndex %>">
                        <%
                            for (String language : allLanguages) {
                        %>
                        <option value="<%= language %>" <%= lang.getLanguageName().equals(language) ? "selected" : "" %>>
                            <%= language %>
                        </option>
                        <% } %>
                        <option value="Other" <%= !allLanguages.contains(lang.getLanguageName()) ? "selected" : "" %>>Other</option>
                    </select>
                    <input type="text" name="newLanguageName<%= languageIndex %>" id="newLanguageName<%= languageIndex %>"
                           placeholder="Enter new language"
                           style="display: <%= !allLanguages.contains(lang.getLanguageName()) ? "inline" : "none" %>;"
                           value="<%= !allLanguages.contains(lang.getLanguageName()) ? lang.getLanguageName() : "" %>">

                    <label for="languageScore<%= languageIndex %>">Score:</label>
                    <input type="number" name="languageScore<%= languageIndex %>" id="languageScore<%= languageIndex %>"
                           value="<%= lang.getScoreOutof100() %>" min="0" max="100" required>
                </div>
                <%
                        languageIndex++;
                    }
                %>
            </div>


            <br>
            <div class="form-buttons">
            <button type="button" class="back-button" onclick="addNewLanguage()">Add New Language</button>
            </div>

            <!-- Hidden field for storing languages -->
            <input type="hidden" id="languages" name="languages">

            <div class="form-buttons">
                <!-- Back to Menu Button -->
                <button type="button" class="back-button" onclick="window.location.href='index.jsp'">Back to Menu</button>

                <!-- Submit Button -->
                <button type="submit" class="submit-button">Update</button>
            </div>
        </fieldset>
    </form>
    <%
    } else {
    %>
    <p class="error-message">Employee not found. Searched for: <%= employeeId %></p>
    <%
        }
    } else {
    %>
    <p class="error-message">No employee records available to search.</p>
    <%
            }
        }
    %>
    </div>
</div>
</body>
</html>
