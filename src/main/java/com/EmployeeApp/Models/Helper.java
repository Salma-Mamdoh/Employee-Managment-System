package com.EmployeeApp.Models;

import java.util.*;

public class Helper {

    private List<Employee> employeeList ;

    public Helper() {
        this.employeeList = new ArrayList<>();
    }

    public List<Employee> getEmployees() {
        return employeeList;
    }

    public void setEmployees(List<Employee> employeeList) {
        this.employeeList = employeeList;
    }

    public void addEmployee(Employee employee) {
        this.employeeList.add(employee);
    }

    public boolean removeEmployee(String employeeID) {
        Iterator<Employee> iterator = employeeList.iterator();
        while (iterator.hasNext()) {
            Employee employee = iterator.next();
            if (employee.getEmployeeID().equals(employeeID)) {
                iterator.remove();
                return true;
            }
        }
        return false; // Employee not found
    }

    public List<Employee> findEmployeesByEmployeeID(String employeeID) {
        List<Employee> result = new ArrayList<>();
        for (Employee employee : employeeList) {
            if (employee.getEmployeeID().equalsIgnoreCase(employeeID)) {
                result.add(employee);
            }
        }
        return result;
    }

    public List<Employee> findEmployeesByDesignation(String designation) {
        List<Employee> result = new ArrayList<>();
        for (Employee employee :employeeList) {
            if (employee.getDesignation().equalsIgnoreCase(designation)) {
                result.add(employee);
            }
        }
        return result;
    }

    public List<Employee> findEmployeesByLanguagesAndScore(String language, int minimumScore) {
        List<Employee> result = new ArrayList<>();


        // Filter employees from your database or data source
        for (Employee employee : employeeList) {
            for(KnownLanguage emlanguage: employee.getKnownLanguages()){
                if ((emlanguage.getLanguageName().equals(language)) && (emlanguage.getScoreOutof100()>=minimumScore) ){
                    result.add(employee);
                    break;
                }
            }

        }
        return result;
    }

    public boolean isDuplicateEmployeeID(String employeeID) {
        for (Employee employee : employeeList) {
            if (employee.getEmployeeID().equals(employeeID.trim())) {
                return true; // Duplicate ID found
            }
        }
        return false; // No duplicate found
    }

    public boolean isValidString(String name) {
        return name != null && name.matches("[a-zA-Z]+(\\s[a-zA-Z]+)*");
    }

    public boolean isValidEmployeeID(String employeeIDStr) {
        return employeeIDStr != null && !employeeIDStr.trim().isEmpty() && employeeIDStr.matches("\\d+");
    }

    public boolean isValidScore(int score) {
        return score >= 0 && score <= 100;
    }

    public boolean isValidLanguageName(String languageName) {
        if (languageName == null || languageName.trim().isEmpty()) {
            return false;
        }

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

        return validProgrammingLanguages.contains(languageName.trim());
    }

    public List<String> validateEmployee(String employeeID, String firstName, String lastName,
                                         String designation, List<KnownLanguage> knownLanguages, boolean isUpdate) {
        List<String> errorMessages = new ArrayList<>();

        // Validate Employee ID
        if (!isValidEmployeeID(employeeID)) {
            errorMessages.add("Invalid Employee ID.");
        }

        // If it's not an update and the ID is a duplicate, add an error message
        if (!isUpdate && isDuplicateEmployeeID(employeeID)) {
            errorMessages.add("Duplicate Employee ID: " + employeeID);
        }

        // Validate first and last names
        if (!isValidString(firstName)) {
            errorMessages.add("Invalid First Name.");
        }
        if (!isValidString(lastName)) {
            errorMessages.add("Invalid Last Name.");
        }

        // Validate designation
        if (designation == null || designation.trim().isEmpty()) {
            errorMessages.add("Designation is required.");
        }

        // Validate known languages
        if (knownLanguages == null || knownLanguages.isEmpty()) {
            errorMessages.add("At least one known language must be provided.");
        } else {
            // Validate each language and its score
            for (KnownLanguage language : knownLanguages) {
                String languageName = language.getLanguageName();
                int score = language.getScoreOutof100();

                // Validate language name
                if (!isValidLanguageName(languageName)) {
                    errorMessages.add("Invalid language name: " + languageName);
                }

                // Validate score
                if (!isValidScore(score)) {
                    errorMessages.add("Invalid score for language " + languageName + ": must be between 0 and 100.");
                }
            }
        }

        return errorMessages;
    }
}
