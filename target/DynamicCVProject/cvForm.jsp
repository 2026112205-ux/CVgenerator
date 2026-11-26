<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dynamic CV Builder | Enter Your Details</title>
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
            <h1>Build Your Professional CV</h1>
            <p>Fill in the form below. Fields marked <span class="req">*</span> are mandatory.
               Your CV is generated instantly &mdash; no account needed.</p>
        </div>

        <div class="card">
            <!-- when this form is submitted it goes to the servlet (doPost) -->
            <form method="post" action="CVServlet" novalidate>

                <!-- personal details -->
                <fieldset>
                    <legend>1. Personal Information</legend>
                    <div class="grid-2">

                        <div class="form-row">
                            <label for="fullName">Full Name <span class="req">*</span></label>
                            <input type="text" id="fullName" name="fullName"
                                   placeholder="WAN AZAMUDDIN" required>
                        </div>

                        <div class="form-row">
                            <label for="professionalTitle">Professional Title</label>
                            <input type="text" id="professionalTitle" name="professionalTitle"
                                   placeholder="e.g. Junior Software Engineer">
                        </div>

                        <div class="form-row">
                            <label for="email">Email Address <span class="req">*</span></label>
                            <input type="email" id="email" name="email"
                                   placeholder="gay@example.com" required>
                        </div>

                        <div class="form-row">
                            <label for="phoneNumber">Phone Number</label>
                            <input type="tel" id="phoneNumber" name="phoneNumber"
                                   placeholder="e.g. +60 12-345 6789">
                        </div>

                        <div class="form-row full">
                            <label for="linkedInUrl">LinkedIn / GitHub URL</label>
                            <input type="url" id="linkedInUrl" name="linkedInUrl"
                                   placeholder="e.g. https://www.linkedin.com/in/your-profile">
                        </div>

                        <div class="form-row full">
                            <label for="profileSummary">Profile Summary</label>
                            <textarea id="profileSummary" name="profileSummary" rows="4"
                                      placeholder="A short paragraph describing your professional background, strengths and career goals."></textarea>
                            <span class="hint">Tip: 3&ndash;4 sentences make the best impression.</span>
                        </div>
                    </div>
                </fieldset>

                <!-- education -->
                <fieldset>
                    <legend>2. Education</legend>
                    <div class="grid-2">

                        <div class="form-row">
                            <label for="highestDegree">Highest Degree <span class="req">*</span></label>
                            <input type="text" id="highestDegree" name="highestDegree"
                                   placeholder="e.g. Bachelor of Computer Science (Hons.)" required>
                        </div>

                        <div class="form-row">
                            <label for="institutionName">Institution Name</label>
                            <input type="text" id="institutionName" name="institutionName"
                                   placeholder="e.g. Universiti Teknologi MARA (UiTM)">
                        </div>

                        <div class="form-row">
                            <label for="yearOfGraduation">Year of Graduation</label>
                            <input type="number" id="yearOfGraduation" name="yearOfGraduation"
                                   min="1970" max="2040" placeholder="e.g. 2026">
                        </div>

                        <div class="form-row">
                            <label for="majorField">Major / Field of Study</label>
                            <input type="text" id="majorField" name="majorField"
                                   placeholder="e.g. Software Engineering">
                        </div>
                    </div>
                </fieldset>

                <!-- latest job -->
                <fieldset>
                    <legend>3. Most Recent Work Experience</legend>
                    <div class="grid-2">

                        <div class="form-row">
                            <label for="jobTitle">Job Title</label>
                            <input type="text" id="jobTitle" name="jobTitle"
                                   placeholder="e.g. Software Engineer (Junior)">
                        </div>

                        <div class="form-row">
                            <label for="companyName">Company Name</label>
                            <input type="text" id="companyName" name="companyName"
                                   placeholder="e.g. TechNova Solutions Sdn. Bhd.">
                        </div>

                        <div class="form-row full">
                            <label for="duration">Duration</label>
                            <input type="text" id="duration" name="duration"
                                   placeholder="e.g. July 2025 - Present">
                        </div>

                        <div class="form-row full">
                            <label for="responsibilities">Key Responsibilities / Achievements</label>
                            <textarea id="responsibilities" name="responsibilities" rows="4"
                                      placeholder="Write one achievement per line, e.g.&#10;Developed REST APIs used by 5,000+ customers&#10;Reduced page load time by 30%"></textarea>
                            <span class="hint">One responsibility or achievement per line &mdash; each line becomes a bullet point.</span>
                        </div>
                    </div>
                </fieldset>

                <!-- skills -->
                <fieldset>
                    <legend>4. Skills</legend>
                    <div class="grid-2">

                        <div class="form-row full">
                            <label for="technicalSkills">Technical Skills <span class="req">*</span></label>
                            <input type="text" id="technicalSkills" name="technicalSkills"
                                   placeholder="e.g. Java, JSP, Servlets, MySQL, HTML, CSS, Git" required>
                            <span class="hint">Separate each skill with a comma &mdash; at least one skill is required.</span>
                        </div>

                        <div class="form-row full">
                            <label for="softSkills">Soft Skills</label>
                            <input type="text" id="softSkills" name="softSkills"
                                   placeholder="e.g. Teamwork, Communication, Time Management">
                            <span class="hint">Separate each skill with a comma.</span>
                        </div>
                    </div>
                </fieldset>

                <!-- buttons -->
                <div class="actions">
                    <span class="left-note"><span class="req">*</span> Required fields</span>
                    <button type="reset" class="btn btn-ghost">Clear Form</button>
                    <!-- normal submit button, uses the POST flow -->
                    <button type="submit" class="btn btn-primary">Generate My CV &rarr;</button>
                </div>
            </form>

            <hr style="border:0;border-top:1px solid #d7dce5;margin:22px 0 18px;">

            <!-- GET request, this is the sample CV flow -->
            <div class="actions" style="justify-content:center;">
                <span class="left-note" style="margin-right:12px;">
                    Not sure where to start? See how a completed CV looks:
                </span>
                <a class="btn btn-gold" href="CVServlet?action=sample">Preview Sample CV</a>
            </div>
        </div>

        <p class="app-footer">
            Dynamic Online CV Builder &mdash; Model &middot; View &middot; Controller &middot; Servlet + JSP + JavaBean
        </p>
    </main>
</body>
</html>
