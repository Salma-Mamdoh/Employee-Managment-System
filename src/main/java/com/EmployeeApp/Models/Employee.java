package com.EmployeeApp.Models;
import com.EmployeeApp.Models.KnownLanguage;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;
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
    private List<KnownLanguage> KnownLanguages;

    public Employee() {}

    // Parameterized constructor
    public Employee(String firstName, String lastName, String employeeID, String designation, List<KnownLanguage> knownLanguages) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.employeeID = employeeID;
        this.designation = designation;
        this.KnownLanguages = knownLanguages;
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

    @JsonIgnore
    public List<KnownLanguage> getKnownLanguages() {
        return KnownLanguages;
    }

    public void setKnownLanguages(List<KnownLanguage> knownLanguages) {
        this.KnownLanguages = knownLanguages;
    }
}
