<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Enter Employee Information</title>
    <link rel="stylesheet" type="text/css" href="css/style2.css">
    <script type="text/javascript">
        // List of valid programming languages for the dropdown
        const validProgrammingLanguages = [
            "Java", "C#", "C++", "Python", "JavaScript", "Ruby", "Go", "Swift", "PHP", "TypeScript",
            "Kotlin", "Rust", "SQL", "Scala", "Perl", "R", "Objective-C", "Lua", "MATLAB", "Haskell",
            "Assembly", "Dart", "Elixir", "Groovy", "Clojure", "F#", "VHDL", "Verilog", "Erlang", "Julia",
            "Forth", "COBOL", "Fortran", "ActionScript", "Hack", "Shell", "Tcl", "Prolog", "OCaml", "Smalltalk",
            "PowerShell", "Awk", "PostScript", "Simula", "Ada", "Chapel", "Nim", "Crystal", "Zig", "Vala",
            "GDScript", "Racket", "Xojo", "OCaml", "Solidity", "Vimscript", "Mercury", "Eiffel", "AutoHotkey",
            "Delphi", "Fantom", "Lisp", "OpenCL", "CUDA", "Turing", "SAS", "LabVIEW", "Logo", "NATURAL", "ML",
            "ABAP", "Vala", "Io", "Wolfram", "Verilog", "ActionScript", "PureScript", "Algol", "Curl"
        ];

        // Dynamically add language fields with dropdown list
        function addLanguageFields() {
            let numLanguages = document.getElementsByName("numLanguages")[0].value;
            let languageFieldsDiv = document.getElementById("languageFields");

            languageFieldsDiv.innerHTML = ''; // Clear previous fields

            for (let i = 1; i <= numLanguages; i++) {
                // Create language selection dropdown
                let languageDropdown = '<label for="languageName_' + i + '">Language ' + i + ':</label>';
                languageDropdown += '<select id="languageName_' + i + '" name="languageName_' + i + '" required>';
                languageDropdown += '<option value="" disabled selected>Select Language</option>';

                // Add valid programming languages as options
                for (let language of validProgrammingLanguages) {
                    languageDropdown += `<option value="${language}">${language}</option>`;
                }
                languageDropdown += '</select>';

                // Create score input field
                let languageScoreField = `
                    <label for="languageScore_${i}">Score (Out of 100):</label>
                    <input type="number" id="languageScore_${i}" name="languageScore_${i}" min="0" max="100" required><br>
                `;

                // Append the dropdown and score input fields
                languageFieldsDiv.innerHTML += languageDropdown + languageScoreField;
            }
        }

        // Validate form inputs
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
                errorMessage = "Designation must contain only letters and spaces.";
                isValid = false;
            }

            // Validate Number of Languages
            if (!numLanguages || numLanguages <= 0 || isNaN(numLanguages)) {
                errorMessage = "Number of Known Languages must be at least 1.";
                isValid = false;
            } else {
                // Validate Known Languages (dropdown selection and score)
                for (let i = 1; i <= numLanguages; i++) {
                    let languageName = document.getElementById("languageName_" + i).value;
                    let languageScore = document.getElementById("languageScore_" + i).value.trim();

                    if (!languageName || !languageScore || isNaN(languageScore) || languageScore < 0 || languageScore > 100) {
                        errorMessage = `Invalid language entry for Language ${i}. Select a valid language and provide a score (0-100).`;
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

        // Update the hidden languages field with selected language names and scores
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
</div>
</body>
</html>
