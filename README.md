# Java Web Application: Student XML Management

## 📖 Project Overview
🎥 **Project Demonstration Video: 

https://github.com/user-attachments/assets/7d22508a-6713-4afe-a912-5dee0ac1c1fc

This Java web application allows users to create, store, retrieve, search, and delete student records using XML files. The program follows a structured XML format to manage student data efficiently.

### 🎯 Objectives:
- Build an XML document to store student data.
- Allow users to specify the number of students to enter.
- Collect student information interactively.
- Store student data in an XML file following a defined structure.
- Implement search functionality by **FirstName** or **GPA**.
- Allow users to delete a specific student record.
- Ensure that if an XML file already exists, the application reads from it instead of creating a new file.

---

## 📊 XML Structure
```xml
<University>
    <Student ID="20200134">
        <FirstName>Ahmed</FirstName>
        <LastName>Mohamed</LastName>
        <Gender>Male</Gender>
        <GPA>3.17</GPA>
        <Level>4</Level>
        <Address>Giza</Address>
    </Student>
</University>
```

---

## 🛠 Features & Implementation
### ✅ Steps:

1️⃣ **Build XML Document**
   - Creates a structured XML file to store student data.
   
2️⃣ **User Input for Student Count**
   - Asks the user to specify how many student records they want to add.
   
3️⃣ **Collect Student Data**
   - Takes input for **ID, FirstName, LastName, Gender, GPA, Level, Address**.
   
4️⃣ **Store Data in XML File**
   - Saves all student records in XML format, preserving structure.
   
5️⃣ **Search Functionality**
   - Allows searching by **GPA** or **FirstName** and retrieves matching records.
   
6️⃣ **Delete a Student Record**
   - Enables selecting and deleting a specific student entry from the XML file.
   
7️⃣ **File Persistence**
   - Checks for an existing XML file and reads from it instead of creating a new file every time.

---

## 🚀 Key Takeaways
✅ **Efficient data storage** using XML format.  
✅ **User-friendly** interface for managing student records.  
✅ **Robust search functionality** for GPA & FirstName queries.  
✅ **Data persistence** ensures no loss of records between program runs.  
✅ **Easy record management** including deletion of specific entries.  

---

## 🛠 Technologies & Libraries Used
🔹 **Java** (JDK 11+)  
🔹 **DOM Parser** (Java XML Processing API) 
🔹 **Apache Tomcat** (Web Server)  
🔹 **CSS** for styling the interface  

---

## 🔮 Future Enhancements
🔹 Improve the GUI design for better user experience.
🔹 Implement database support (MySQL/PostgreSQL) for persistent storage.
