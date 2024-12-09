package com.EmployeeApp.util;

import com.EmployeeApp.Models.Employee;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

public class JSONUtil {
    // Path to the JSON file
    private static final String FILE_PATH = "C:\\Users\\E.J.S\\IdeaProjects\\SOA-Assignment3-Web\\src\\main\\resources\\Employees.json";

    public static void addEmployeeToJSON(Employee employee) throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        File jsonFile = new File(FILE_PATH);

        List<Employee> employees = new ArrayList<>();

        if (jsonFile.exists() && jsonFile.length() > 0) {
            employees = objectMapper.readValue(
                    jsonFile,
                    objectMapper.getTypeFactory().constructCollectionType(List.class, Employee.class)
            );
        }

        employees.add(employee);

        // Write back to JSON
        objectMapper.writerWithDefaultPrettyPrinter().writeValue(jsonFile, employees);
    }



    // Read employees from the JSON file and return a list of Employee objects
    public static List<Employee> readEmployeesAsJSON() {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            File file = new File(FILE_PATH);

            // If the file doesn't exist or is empty, return an empty list
            if (!file.exists() || file.length() == 0) {
                return new ArrayList<>();
            }

            // Read the JSON file and map it to an array of Employee objects
            Employee[] employeesArray = objectMapper.readValue(file, Employee[].class);

            // Convert the array to a modifiable List (ArrayList) and return it
            return new ArrayList<>(Arrays.asList(employeesArray));
        } catch (IOException e) {
            System.err.println("Error while reading employees from JSON: " + e.getMessage());
            e.printStackTrace();

            // Return an empty list on error
            return new ArrayList<>();
        }
    }


    // Helper function to check if the file exists, if not create it
    public static void checkAndCreateFileIfNeeded() {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                System.err.println("Error creating the file: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
}
