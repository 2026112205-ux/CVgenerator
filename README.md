# Dynamic Online CV Builder

CSC584 Enterprise Programming — Individual Assignment 

|||
|-|-|
|**Name**|WAN AZAMUDDIN BIN WAN ABDUL MALEK|
|**Student ID**|2026112205|
|**Group**|2304C2|
|**Lecturer**|AHMAD AIMAN BIN SHALLAHUDDIN|
|**Semester**|Semester 4, 2026/2027 (20264)|

\---

## About

A small web application built with the MVC pattern using Java Servlet, JavaBean and JSP.

The user fills in one form — personal details, education, work experience and skills — and
the system generates a formatted CV that can be printed or saved as a PDF. There is also a
"Preview Sample CV" option that shows a pre-filled example, so the output can be checked
without typing anything.

\---

## Built with

* Java 11 (runs on 21)
* Jakarta Servlet 6.0
* JSTL 3.0
* JSP
* Apache Tomcat 10.1 / GlassFish 7
* Maven
* NetBeans

> This project uses `jakarta.servlet.\*`, so it needs \*\*Tomcat 10 or newer\*\*.
> Tomcat 9 and below use `javax.servlet.\*` and will not run this code.

\---

## How the MVC flow works

```
                    Browser
                       |
                       v
                  cvForm.jsp  (View)
                       |
              POST / CVServlet?action=sample
                       |
                       v
              CVServlet  (Controller)
                       |
                       v
                 CVBean  (Model)
                       |
                       v
                validate()
                       |
          +------------+------------+
          |                         |
       valid                     invalid
          |                         |
          v                         v
    cvView.jsp                 cvError.jsp
     (the CV)                (list of errors)
```

The **Model** (`CVBean`) holds the data and knows how to validate itself.
The **Controller** (`CVServlet`) reads the request, fills the bean, asks it to validate,
then picks which page to show. The **Views** (the three JSP files) only display things —
there is no Java logic inside them.

`web.xml` declares the servlet, maps it to `/CVServlet`, and sets `cvForm.jsp` as the
welcome file.

\---

## Project structure

```
DynamicCVProject/
├── pom.xml
└── src/main/
    ├── java/com/cvbuilder/
    │   ├── model/CVBean.java               Model - data + validation
    │   └── controller/CVServlet.java       Controller - doPost() and doGet()
    └── webapp/
        ├── WEB-INF/web.xml                 servlet mapping, welcome file
        ├── css/style.css                   CV template styling
        ├── cvForm.jsp                      View - the input form
        ├── cvView.jsp                      View - the generated CV
        └── cvError.jsp                     View - validation errors
```

\---

## Pages

|URL|What it shows|
|-|-|
|`/DynamicCVProject/`|The input form|
|`/DynamicCVProject/CVServlet?action=sample`|A pre-filled sample CV|
|Submit the form|Your own CV, generated from what you typed|
|Submit with missing fields|Error page listing what needs fixing|

\---

## Validation rules

`CVBean.validate()` checks four things:

1. Full name is not empty
2. Email is not empty **and** matches a valid format
3. Highest degree is not empty
4. At least one skill is provided

If any of these fail, the controller forwards to `cvError.jsp` with a list of the problems
so the user knows exactly what to fix.

\---

## Running the project

1. Open the folder in NetBeans — **File → Open Project**
2. Wait for dependencies to resolve
3. Make sure Tomcat 10.1 or GlassFish 7 is added under **Services → Servers**
4. Right-click the project → **Properties → Run** → select that server

   * Context Path: `/DynamicCVProject`
5. Press **Run**

Then open:

```
http://localhost:8080/DynamicCVProject/
```

### Building the WAR from the command line

```bash
mvn clean package
```

The WAR is created at `target/DynamicCVProject.war`. Copy it into Tomcat's `webapps`
folder if you want to deploy it without an IDE.

\---

## What was learned

* How the MVC pattern separates data, logic and presentation
* Passing a JavaBean from a servlet to a JSP using `request.setAttribute()` and `RequestDispatcher.forward()`
* Rendering data in a JSP with JSTL and EL, without any scriptlets
* Handling two flows from one servlet: `doPost()` for form submission and `doGet()` for the sample CV
* Doing validation in the Model rather than the Controller, so the rule lives with the data
* Configuring a servlet through `web.xml` instead of annotations

