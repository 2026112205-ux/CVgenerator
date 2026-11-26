<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Validation Error | Dynamic CV Builder</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <!-- top bar -->
    <header class="topbar">
        <div class="container">
            <div class="brand">
                <span class="logo">CV</span>
                <span>Dynamic Online CV Builder<br>
                    <span class="tagline">CSC584 Enterprise Programming &middot; MVC Pattern</span>
                </span>
            </div>
        </div>
    </header>

    <main class="container">

        <div class="page-head">
            <h1>We Could Not Generate Your CV</h1>
            <p>Some of the information you submitted did not pass validation.</p>
        </div>

        <div class="card error-card">

            <!-- 1. list of validation errors -->
            <div class="alert alert-error">
                <h2>&#9888; Please correct the following field(s):</h2>
                <ul>
                    <c:forEach var="error" items="${errors}">
                        <li><c:out value="${error}"/></li>
                    </c:forEach>
                </ul>
                <p class="error-summary-line">
                    Total problem(s) found:
                    <strong><c:out value="${fn:length(errors)}"/></strong>
                </p>
            </div>

            <!-- 2. echo of the submitted values -->
            <div class="echo-box">
                <p style="margin:0 0 6px;"><strong>Details we received:</strong></p>
                <p style="margin:0;">
                    Name:
                    <strong>
                        <c:choose>
                            <c:when test="${not empty cvData.fullName}"><c:out value="${cvData.fullName}"/></c:when>
                            <c:otherwise><em style="color:#b02a2a;">(empty)</em></c:otherwise>
                        </c:choose>
                    </strong>
                    &nbsp;&middot;&nbsp;
                    Email:
                    <strong>
                        <c:choose>
                            <c:when test="${not empty cvData.email}"><c:out value="${cvData.email}"/></c:when>
                            <c:otherwise><em style="color:#b02a2a;">(empty)</em></c:otherwise>
                        </c:choose>
                    </strong>
                    &nbsp;&middot;&nbsp;
                    Degree:
                    <strong>
                        <c:choose>
                            <c:when test="${not empty cvData.highestDegree}"><c:out value="${cvData.highestDegree}"/></c:when>
                            <c:otherwise><em style="color:#b02a2a;">(empty)</em></c:otherwise>
                        </c:choose>
                    </strong>
                </p>
            </div>

            <!-- 3. navigation back to the form -->
            <div class="actions" style="margin-top:22px;">
                <a class="btn btn-ghost" href="CVServlet?action=sample">Preview Sample CV</a>
                <a class="btn btn-primary" href="CVServlet">&larr; Back to CV Form</a>
            </div>

        </div>

        <p class="app-footer">
            Dynamic Online CV Builder &mdash; validation is performed by CVBean.validate() in the Model layer.
        </p>
    </main>
</body>
</html>
