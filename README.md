# 🎓 Leave Management System

A web-based **Leave Management System** developed using **Java, JDBC, MySQL, HTML, CSS, and Servlet-JSP**, designed for managing student/employees leave applications efficiently in an educational institution/organization.

## 📌 Project Overview

The system allows **students** to apply for leave online, **faculty** to approve or reject leave requests, and an **admin** to manage users, view all applications, generate reports, and perform administrative tasks.

> ✅ This project was developed as part of my academic curriculum and is now complete and deployed locally.

---

## ✨ Features

### 👩‍🎓 Student
- Apply for leave
- View status of leave applications

### 👨‍🏫 Faculty
- View pending leave applications
- Approve or reject leave applications

### 👩‍💼 Admin
- Manage student and faculty users
- View all and pending applications
- Change admin password
- Generate PDF reports

---

## 🧰 Tech Stack

| Technology | Purpose |
|------------|---------|
| Java       | Backend logic and server-side programming |
| Servlet & JSP | Web interface and dynamic content rendering |
| JDBC       | Database connectivity |
| MySQL      | Database to store user and leave data |
| HTML/CSS   | Front-end design |
| Apache Tomcat | Server deployment and testing |

---

## 🔐 Roles & Permissions

| Role     | Description |
|----------|-------------|
| **Student** | Can apply for leave and check status |
| **Faculty** | Can review, approve or reject leave |
| **Admin**   | Manages users, views applications, generates reports |

---

## 📸 Screenshots

> Add screenshots of:  
> - Student Leave Form  
> - Faculty Dashboard  
> - Admin Panel  
> *(Use `![screenshot](path)` in GitHub if you have image files)*

---

## 📝 How to Run

Follow these steps to set up and run the Leave Management System on your local machine:

---

### 1️⃣ Install Eclipse IDE (Recommended)

- Download and install **Eclipse IDE for Enterprise Java and Web Developers** from the official site:  
  🔗 [https://www.eclipse.org/downloads/](https://www.eclipse.org/downloads/)

- During setup:
  - Ensure **Java 21 JDK** is already installed.
  - You can download it from [Oracle JDK 21](https://www.oracle.com/java/technologies/javase/jdk21-archive-downloads.html)
  - Set Java 21 as default JDK in Eclipse via:  
    `Window → Preferences → Java → Installed JREs → Add → Standard VM → Select JDK 21 folder → Finish`

---

### 2️⃣ Clone the GitHub Project and Import into Eclipse

#### a. Clone the project from GitHub:

Open a terminal and run:

```bash
`git clone https://github.com/yourusername/LeaveManagementSystem.git`
```
When cloning the repository, you will be prompted for your GitHub **username** and a **personal access token** (instead of a password).

### 📌 To generate a token:
1. Go to GitHub → **Settings**
2. Click on **Developer Settings**
3. Go to **Personal Access Tokens → Tokens (Classic)**
4. Click **Generate new token**
5. Enable the following scope:
   - `repo`
6. Copy the generated token and **save it somewhere safe**.
7. Use this token as your password when cloning the repository.

---

## 📥 Import into Eclipse

1. Open **Eclipse**
2. Go to: `File → Import → General → Existing Projects into Workspace`
3. Click **Next**
4. Browse to the folder where you cloned the repo (`LeaveManagementSystem`)
5. Select the project and click **Finish**

---

## ⚙️ Set Build Path and JDBC Connector

This project uses **MySQL Connector J v9.3.0** for database connectivity.

### To configure:
1. Right-click on the project → `Build Path → Configure Build Path`
2. Go to the **Libraries** tab
3. Click **Add JARs...**
4. Navigate to the following location inside the project: `LeaveManagementSystem/src/main/webapp/WEB-INF/lib/mysql-connector-j-9.3.0.jar`
5. Select and **Add** the JAR
6. Click **Apply and Close**

---

## 🛢️ MySQL Database Setup

1. Open **MySQL Workbench** or **command line**
2. Create the required database

### 📂 SQL Script:

Locate and execute the SQL script found at: `LeaveManagementSystem/resources/databaseStructure.txt`


This will create the necessary tables and schema.

### ⚠️ Important:

Ensure your MySQL server is running with the following configuration:

- **Host**: `localhost`
- **Port**: `3306`

Default database credentials used in the code:

```java
String url = "jdbc:mysql://localhost:3306/leave_management_db";
String user = "root";
String password = "root";
```
---

▶️ Run the Project using Apache Tomcat
Setup Apache Tomcat in Eclipse:

Go to Servers tab → New → Server

Choose Apache Tomcat (v10.x recommended for Java 21)

Browse and select your downloaded Tomcat folder

Add your project to the server

Right-click the project → Run As → Run on Server

Once deployed, open your browser and visit: `http://localhost:8080/LeaveManagementSystem/`

---

✅ You are now ready to use the Leave Management System locally!

--- 

🙋 Need Help?
Raise an issue: 🔗 [Github Issue](https://github.com/connect-psr/LeaveManagementSystem/issues) 



