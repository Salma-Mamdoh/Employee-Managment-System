package com.EmployeeApp.servlet;

import com.EmployeeApp.Models.Helper;
import com.EmployeeApp.Models.KnownLanguage;
import com.EmployeeApp.Models.Employee;
import com.EmployeeApp.util.JSONUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.util.List;

public class EmployeeServlet extends HttpServlet {

    private final Helper helper = new Helper(); // Instance of Helper class

    private static final String FILE_PATH = "C:\\Users\\E.J.S\\IdeaProjects\\SOA-Assignment3-Web\\src\\main\\resources\\Employees.json";


    @Override
    public void init() throws ServletException {
        try {
            File xmlFile = new File(FILE_PATH);
            if (!xmlFile.exists()) {
                JSONUtil.checkAndCreateFileIfNeeded();
            }
            List<Employee> employees = JSONUtil.readEmployeesAsJSON();
            helper.setEmployees(employees);
            //System.out.println(helper.getEmployees());
        } catch (Exception e) {
            throw new ServletException("Error reading student data from XML.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addEmployee".equals(action)) {
            try {
                addEmployee(request, response);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        } else if ("search".equals(action)) {
            String searchType = request.getParameter("searchType");
            if ("employeeID".equals(searchType)) {
                searchStudentEmployeeID(request, response);
            } else if ("designation".equals(searchType)) {
                searchStudentDesignation(request, response);
            }
        }

    }



    private void addEmployee(HttpServletRequest request, HttpServletResponse response) throws Exception{
        // Extract input parameters from the request
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String employeeID = request.getParameter("employeeID");
        String designation = request.getParameter("designation");
        String languagesJson = request.getParameter("languages"); // Languages in JSON format

        // Parse the languages JSON to a List of KnownLanguage objects
        ObjectMapper objectMapper = new ObjectMapper();
        List<KnownLanguage> knownLanguages = objectMapper.readValue(
                languagesJson,
                objectMapper.getTypeFactory().constructCollectionType(List.class, KnownLanguage.class)
        );
        //System.out.println("hereeeeeeee");
        // Validate the employee data using the Helper class
        List<String> validationErrors = helper.validateEmployee(employeeID, firstName, lastName, designation, knownLanguages, false);

        // If there are validation errors, set them in the request and forward back to the JSP page
        if (!validationErrors.isEmpty()) {
            request.setAttribute("errorMessages", validationErrors);
            request.getRequestDispatcher("addEmployee.jsp").forward(request, response);
            return;
        }

        // If validation passes, create a new Employee object
        Employee employee = new Employee();
        employee.setFirstName(firstName);
        employee.setLastName(lastName);
        employee.setEmployeeID(employeeID);
        employee.setDesignation(designation);
        employee.setKnownLanguages(knownLanguages);

        // Add the employee to the system using Helper
        helper.addEmployee(employee);
        //System.out.println("hereeeeeeeee");
        // Save the employee to a JSON file (persistent storage)
        JSONUtil.addEmployeeToJSON(employee);

        // Set a success message and forward to the success page
        request.setAttribute("success", "Employee added successfully!");
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    private void searchStudentEmployeeID(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String employeeID = request.getParameter("employeeID");
        List<Employee> employee = helper.findEmployeesByEmployeeID(employeeID);
        request.setAttribute("employees", employee);
        RequestDispatcher dispatcher = request.getRequestDispatcher("EmployeeDetail.jsp");
        dispatcher.forward(request, response);
    }

    private void searchStudentDesignation(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String designation = request.getParameter("designation");
        List<Employee> Employees = helper.findEmployeesByDesignation(designation);
        request.setAttribute("employees", Employees);
        RequestDispatcher dispatcher = request.getRequestDispatcher("EmployeeDetail.jsp");
        dispatcher.forward(request, response);
    }
}
