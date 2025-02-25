# Java Web Application: Employee Json Management

## 📖 Project Overview
🎥 **Project Demonstration Video: 

https://github.com/user-attachments/assets/7d22508a-6713-4afe-a912-5dee0ac1c1fc

This Java web application allows users to create, store, retrieve, search, update, and delete employee records using JSON format. The program follows a structured JSON format to manage employee data efficiently.

### 🎯 Objectives:
- Read and parse a JSON array containing employee data.
- Allow users to add new employees.
- Implement search functionality by **EmployeeID** or **Designation**.
- Enable users to delete specific employee records.
- Update an employee’s designation.
- Retrieve and sort employees proficient in Java with a score higher than the MinScore specified by the User.

---

## 📊 JSON Structure
```json
[
    {
        "FirstName": "Sam",
        "LastName": "Jackson",
        "EmployeeID": 1000,
        "Designation": "Manager",
        "KnownLanguages": [
            { "LanguageName": "Java", "ScoreOutof100": 90 },
            { "LanguageName": "C#", "ScoreOutof100": 50 },
            { "LanguageName": "C++", "ScoreOutof100": 80 }
        ]
    },
    {
        "FirstName": "John",
        "LastName": "Adamo",
        "EmployeeID": 2000,
        "Designation": "Developer",
        "KnownLanguages": [
            { "LanguageName": "Perl", "ScoreOutof100": 30 },
            { "LanguageName": "Java", "ScoreOutof100": 65 },
            { "LanguageName": "C++", "ScoreOutof100": 70 }
        ]
    }
]
```

---

## 🛠 Features & Implementation
### ✅ Steps:

1️⃣ **Read JSON Array**
   - Load and parse employee data from a JSON file.

2️⃣ **Add New Employee**
   - Collect input for **FirstName, LastName, EmployeeID, Designation, KnownLanguages**.
   - Append the new record to the JSON array.

3️⃣ **Search Functionality**
   - Search employees by **EmployeeID** or **Designation**.

4️⃣ **Delete a Specific Employee Record**
   - Remove an employee entry based on EmployeeID.

5️⃣ **Update Employee Designation**
   - Example - Modify the designation of the employee with **EmployeeID = 2000** from **Developer** to **Team Leader**.

6️⃣ **Retrieve and Sort Employees Proficient in Any Language**
   - Example - Identify employees with Java proficiency **(Score > 50)**.
   - Sort results in ascending order based on Java score.

---

## 🚀 Key Takeaways
✅ **Efficient data storage** using JSON format.  
✅ **User-friendly** interface for managing employee records.  
✅ **Robust search functionality** for EmployeeID & Designation queries.  
✅ **Data persistence** ensures no loss of records between program runs.  
✅ **Flexible and scalable** to accommodate future enhancements.  

---

## 🛠 Technologies & Libraries Used
🔹 **Java** (JDK 11+)  
🔹 **JSON Processing Library** (Jackson / GSON)  
🔹 **Apache Tomcat** (Web Server)  
🔹 **CSS** for styling the interface  

---

## 🔮 Future Enhancements
🔹 Improve the GUI design for a better user experience.  
🔹 Implement database support (MySQL/PostgreSQL) for persistent storage.  
🔹 Add authentication and authorization features.  
🔹 Expose RESTful APIs for integration with other systems.  

