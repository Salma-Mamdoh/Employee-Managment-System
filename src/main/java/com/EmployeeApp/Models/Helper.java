package com.EmployeeApp.Models;

import java.util.*;

public class Helper {

    private List<Employee> employees;

    public Helper() {
        this.employees = new ArrayList<>();
    }

    public List<Employee> getEmployees() {
        return employees;
    }

    public void setEmployees(List<Employee> employeeList) {
        this.employees = employeeList;
    }

    public void addEmployee(Employee employee) {
        this.employees.add(employee);
    }

    public boolean removeEmployee(String employeeID) {
        Iterator<Employee> iterator = employees.iterator();
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
        for (Employee employee : employees) {
            if (employee.getEmployeeID().equalsIgnoreCase(employeeID)) {
                result.add(employee);
            }
        }
        return result;
    }

    public List<Employee> findEmployeesByFirstName(String firstName) {
        List<Employee> result = new ArrayList<>();
        for (Employee employee : employees) {
            if (employee.getFirstName().equalsIgnoreCase(firstName)) {
                result.add(employee);
            }
        }
        return result;
    }

    public List<Employee> findEmployeesByLastName(String lastName) {
        List<Employee> result = new ArrayList<>();
        for (Employee employee : employees) {
            if (employee.getLastName().equalsIgnoreCase(lastName)) {
                result.add(employee);
            }
        }
        return result;
    }

    public List<Employee> findEmployeesByDesignation(String designation) {
        List<Employee> result = new ArrayList<>();
        for (Employee employee : employees) {
            if (employee.getDesignation().equalsIgnoreCase(designation)) {
                result.add(employee);
            }
        }
        return result;
    }

    public boolean isDuplicateEmployeeID(String employeeID) {
        for (Employee employee : employees) {
            if (employee.getEmployeeID().equals(employeeID)) {
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
                                         String designation, Map<String, Integer> knownLanguages, boolean isUpdate) {
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

        // Validate known languages (Map)
        if (knownLanguages == null || knownLanguages.isEmpty()) {
            errorMessages.add("At least one known language must be provided.");
        } else {
            // Validate each language and its score
            for (Map.Entry<String, Integer> entry : knownLanguages.entrySet()) {
                String languageName = entry.getKey();
                Integer score = entry.getValue();

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
