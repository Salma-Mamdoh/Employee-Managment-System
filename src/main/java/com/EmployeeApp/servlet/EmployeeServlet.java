package com.EmployeeApp.servlet;

import com.EmployeeApp.Models.Employee;
import com.EmployeeApp.util.JSONUtil;
import com.EmployeeApp.Models.Helper;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.*;

public class EmployeeServlet extends HttpServlet {

    private Helper helper;

    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize the Helper object
        helper = new Helper();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Capture form data for employee
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String employeeID = request.getParameter("employeeID");
        String designation = request.getParameter("designation");

        // Parse the hidden languages field from JSON string to Map
        String languagesJson = request.getParameter("languages");
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Integer> knownLanguages = objectMapper.readValue(languagesJson, Map.class);

        // Validate the employee data
        //List<String> validationErrors = helper.validateEmployee(employeeID, firstName, lastName, designation, knownLanguages, false);
/*
        if (!validationErrors.isEmpty()) {
            System.out.println("hereeeeeeee");
            // If there are validation errors, return a bad request response with errors
            request.setAttribute("errors", validationErrors);
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }
*/
        // If validation passed, create the Employee object
        Employee newEmployee = new Employee(firstName, lastName, employeeID, designation, knownLanguages);

        // Add employee to JSON file
        JSONUtil.addEmployeeToJSON(newEmployee);

        // Redirect or forward to index.jsp with success message
        request.setAttribute("success", "Employee added successfully!");
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
