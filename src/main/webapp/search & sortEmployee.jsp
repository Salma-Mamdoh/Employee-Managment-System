<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search for Employee by Programming Languages</title>
    <link rel="stylesheet" type="text/css" href="css/style2.css">
</head>
<body>
<div class="container">
    <h2>Search for Employees by Programming Languages</h2>
    <form action="EmployeeServlet" method="post">
        <input type="hidden" name="action" value="searchByLanguages">

        <!-- Programming Languages Dropdown (Single selection) -->
        <div>
            <label for="programmingLanguages">Select Programming Language:</label>
            <select id="programmingLanguages" name="languages" required>
                <%
                    List<String> validProgrammingLanguages = Arrays.asList(
                            "Java", "C#", "C++", "Python", "JavaScript", "Ruby", "Go", "Swift", "PHP", "TypeScript",
                            "Kotlin", "Rust", "SQL", "Scala", "Perl", "R", "Objective-C", "Lua", "MATLAB", "Haskell",
                            "Assembly", "Dart", "Elixir", "Groovy", "Clojure", "F#", "VHDL", "Verilog", "Erlang", "Julia",
                            "Forth", "COBOL", "Fortran", "ActionScript", "Hack", "Shell", "Tcl", "Prolog", "OCaml", "Smalltalk",
                            "PowerShell", "Awk", "PostScript", "Simula", "Ada", "Chapel", "Nim", "Crystal", "Zig", "Vala",
                            "GDScript", "Racket", "Xojo", "OCaml", "Solidity", "Vimscript", "Mercury", "Eiffel", "AutoHotkey",
                            "Delphi", "Fantom", "Lisp", "OpenCL", "CUDA", "Turing", "SAS", "LabVIEW", "Logo", "NATURAL", "ML",
                            "ABAP", "Vala", "Io", "Wolfram", "Verilog", "ActionScript", "PureScript", "Algol", "Curl"
                    );
                    for (String language : validProgrammingLanguages) {
                %>
                <option value="<%= language %>"><%= language %></option>
                <% } %>
            </select>
        </div>

        <!-- Minimum Score Input -->
        <div>
            <label for="minimumScore">Minimum Score:</label>
            <input type="number" id="minimumScore" name="minimumScore" required>
        </div>

        <!-- Form Buttons -->
        <div class="form-buttons">
            <button type="button" class="back-button" onclick="window.location.href='index.jsp'">Back to Menu</button>
            <button type="submit" class="submit-button">Search</button>
        </div>
    </form>
</div>
</body>
</html>
