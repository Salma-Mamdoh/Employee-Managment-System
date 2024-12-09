package com.EmployeeApp.Models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Map;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Employee {

    @JsonProperty("firstName")
    private String firstName;

    @JsonProperty("lastName")
    private String lastName;

    @JsonProperty("employeeID")
    private String employeeID;

    @JsonProperty("designation")
    private String designation;

    @JsonProperty("languages")
    private Map<String, Integer> knownLanguages;


    public Employee() {}

    // Parameterized constructor
    public Employee(String firstName, String lastName, String employeeID, String designation, Map<String, Integer> knownLanguages) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.employeeID = employeeID;
        this.designation = designation;
        this.knownLanguages = knownLanguages;
    }

    // Getters and setters
    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmployeeID() {
        return employeeID;
    }

    public void setEmployeeID(String employeeID) {
        this.employeeID = employeeID;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public Map<String, Integer> getKnownLanguages() {
        return knownLanguages;
    }

    public void setKnownLanguages(Map<String, Integer> knownLanguages) {
        this.knownLanguages = knownLanguages;
    }
}
