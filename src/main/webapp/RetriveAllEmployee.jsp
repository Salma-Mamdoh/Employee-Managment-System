<html>
<head>
    <title>Employee Management System</title>
    <link rel="stylesheet" type="text/css" href="css/style2.css"> <!-- Link to your CSS file -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQuery for simplicity -->

    <script type="text/javascript">
        // This function sends the request using AJAX as soon as the page is loaded
        window.onload = function() {
            // Use AJAX to send the request to the servlet
            $.ajax({
                type: "POST", // HTTP method
                url: "EmployeeServlet", // The servlet that will handle the request
                data: { action: "retrieveAllEmployees" }, // The data to send (action)
                success: function(response) {
                    // On success, load the response into the page (or handle the response as needed)
                    // For example, you can display the employees' data in a div:
                    $("#employeeList").html(response); // Assuming the servlet sends HTML or a partial page
                },
                error: function(xhr, status, error) {
                    // Handle any errors (optional)
                    alert("An error occurred: " + error);
                }
            });
        };
    </script>
</head>
<body>
<div class="container">
    <!-- This will be populated with employee details via AJAX -->
    <div id="employeeList"></div>
</div>
</body>
</html>
