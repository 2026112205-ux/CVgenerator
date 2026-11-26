<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty pageTitle ? 'Curriculum Vitae' : pageTitle} | Dynamic CV Builder</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <!-- top bar -->
    <header class="topbar no-print">
        <div class="container">
            <div class="brand">
                <span class="logo">CV</span>
                <span>Dynamic Online CV Builder<br>
                    <span class="tagline">CSC584 Enterprise Programming &middot; MVC Pattern</span>
                </span>
            </div>
            <a class="btn btn-ghost no-print" style="color:#fff;border-color:#8f9bb5;"
               href="CVServlet">&larr; Back to Form</a>
        </div>
    </header>

    <main class="container">
        <!-- toolbar, hidden when printing -->
        <div class="cv-toolbar no-print">
            <div class="meta">
                <c:choose>
                    <c:when test="${cvMode == 'sample'}">
                        <span class="mode-badge sample">Sample Template</span>
                        &nbsp; Pre-filled example &mdash; generate your own using the form.
                    </c:when>
                    <c:otherwise>
                        <span class="mode-badge custom">Generated CV</span>
                        &nbsp; Built from your submitted details.
                    </c:otherwise>
                </c:choose>
            </div>
            <div>
                <c:if test="${cvMode == 'sample'}">
                    <a class="btn btn-gold" href="CVServlet">Use This Template &rarr;</a>
                </c:if>
                <c:if test="${cvMode != 'sample'}">
                    <a class="btn btn-ghost" href="CVServlet">Edit Details</a>
                </c:if>
                <button type="button" class="btn btn-primary" onclick="window.print()">
                    Print / Save as PDF
                </button>
            </div>
        </div>

        <!-- the CV itself, styled to fit A4 when printed -->
        <article class="cv-sheet">

            <!-- name, job title and contact details -->
            <header class="cv-header">
                <h1 class="cv-name"><c:out value="${cvData.fullName}"/></h1>

                <c:if test="${not empty cvData.professionalTitle}">
                    <p class="cv-title"><c:out value="${cvData.professionalTitle}"/></p>
                </c:if>

                <ul class="cv-contact">
                    <c:if test="${not empty cvData.email}">
                        <li><span class="dot">&#9993;</span>
                            <c:out value="${cvData.email}"/></li>
                    </c:if>
                    <c:if test="${not empty cvData.phoneNumber}">
                        <li><span class="dot">&#9742;</span>
                            <c:out value="${cvData.phoneNumber}"/></li>
                    </c:if>
                    <c:if test="${not empty cvData.linkedInUrl}">
                        <li><span class="dot">&#128279;</span>
                            <a href="<c:out value='${cvData.linkedInUrl}'/>"
                               target="_blank" rel="noopener"
                               style="color:#dfe5f0;text-decoration:underline;">
                                <c:out value="${cvData.linkedInUrl}"/>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </header>

            <div class="cv-body">

                <!-- summary -->
                <c:if test="${not empty cvData.profileSummary}">
                    <section class="cv-section">
                        <h2>Professional Summary</h2>
                        <p class="cv-summary"><c:out value="${cvData.profileSummary}"/></p>
                    </section>
                </c:if>

                <!-- education -->
                <c:if test="${not empty cvData.highestDegree}">
                    <section class="cv-section">
                        <h2>Education</h2>
                        <div class="cv-entry-head">
                            <span class="role"><c:out value="${cvData.highestDegree}"/></span>
                            <c:if test="${not empty cvData.yearOfGraduation}">
                                <span class="date">Graduated <c:out value="${cvData.yearOfGraduation}"/></span>
                            </c:if>
                        </div>
                        <p class="cv-entry-sub">
                            <c:out value="${cvData.institutionName}"/>
                            <c:if test="${not empty cvData.majorField}">
                                &nbsp;&middot;&nbsp; Major: <c:out value="${cvData.majorField}"/>
                            </c:if>
                        </p>
                    </section>
                </c:if>

                <!-- work experience -->
                <c:if test="${not empty cvData.jobTitle or not empty cvData.companyName}">
                    <section class="cv-section">
                        <h2>Work Experience</h2>
                        <div class="cv-entry-head">
                            <span class="role">
                                <c:out value="${cvData.jobTitle}"/>
                                <c:if test="${not empty cvData.companyName}">
                                    &nbsp;&mdash;&nbsp;<c:out value="${cvData.companyName}"/>
                                </c:if>
                            </span>
                            <c:if test="${not empty cvData.duration}">
                                <span class="date"><c:out value="${cvData.duration}"/></span>
                            </c:if>
                        </div>
                        <c:if test="${not empty cvData.responsibilitiesList}">
                            <ul class="cv-list">
                                <c:forEach var="item" items="${cvData.responsibilitiesList}">
                                    <li><c:out value="${item}"/></li>
                                </c:forEach>
                            </ul>
                        </c:if>
                    </section>
                </c:if>

                <!-- skills -->
                <section class="cv-section">
                    <h2>Skills</h2>

                    <c:if test="${not empty cvData.technicalSkillsList}">
                        <p class="skill-sub-label">Technical Skills</p>
                        <ul class="skill-tags">
                            <c:forEach var="skill" items="${cvData.technicalSkillsList}">
                                <li><c:out value="${skill}"/></li>
                            </c:forEach>
                        </ul>
                    </c:if>

                    <c:if test="${not empty cvData.softSkillsList}">
                        <p class="skill-sub-label" style="margin-top:14px;">Soft Skills</p>
                        <ul class="skill-tags soft">
                            <c:forEach var="skill" items="${cvData.softSkillsList}">
                                <li><c:out value="${skill}"/></li>
                            </c:forEach>
                        </ul>
                    </c:if>
                </section>

            </div><!-- /cv-body -->

            <!-- footer -->
            <footer class="cv-footer">
                <span>
                    <c:out value="${cvData.fullName}"/> &mdash; Curriculum Vitae
                </span>
                <span>Generated by Dynamic Online CV Builder &middot; <c:out value="${cvData.email}"/></span>
            </footer>
        </article>

    </main>

    <p class="app-footer no-print">
        Dynamic Online CV Builder &mdash; Model &middot; View &middot; Controller
    </p>
</body>
</html>
