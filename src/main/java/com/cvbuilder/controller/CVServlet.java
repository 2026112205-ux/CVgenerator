package com.cvbuilder.controller;

import com.cvbuilder.model.CVBean;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class CVServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // view paths kept in one place so they are easy to change
    private static final String VIEW_FORM = "/cvForm.jsp";
    private static final String VIEW_CV = "/cvView.jsp";
    private static final String VIEW_ERROR = "/cvError.jsp";

    /**
     * Handles the form submission from cvForm.jsp (POST flow).
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // so names with accents or symbols don't get messed up
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 1. read all the form parameters
        String fullName = request.getParameter("fullName");
        String professionalTitle = request.getParameter("professionalTitle");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String linkedInUrl = request.getParameter("linkedInUrl");
        String profileSummary = request.getParameter("profileSummary");

        String highestDegree = request.getParameter("highestDegree");
        String institutionName = request.getParameter("institutionName");
        String yearOfGraduation = request.getParameter("yearOfGraduation");
        String majorField = request.getParameter("majorField");

        String jobTitle = request.getParameter("jobTitle");
        String companyName = request.getParameter("companyName");
        String duration = request.getParameter("duration");
        String responsibilities = request.getParameter("responsibilities");

        String technicalSkills = request.getParameter("technicalSkills");
        String softSkills = request.getParameter("softSkills");

        // 2. put everything into the bean using the setters
        CVBean cvBean = new CVBean();
        cvBean.setFullName(fullName);
        cvBean.setProfessionalTitle(professionalTitle);
        cvBean.setEmail(email);
        cvBean.setPhoneNumber(phoneNumber);
        cvBean.setLinkedInUrl(linkedInUrl);
        cvBean.setProfileSummary(profileSummary);

        cvBean.setHighestDegree(highestDegree);
        cvBean.setInstitutionName(institutionName);
        cvBean.setYearOfGraduation(yearOfGraduation);
        cvBean.setMajorField(majorField);

        cvBean.setJobTitle(jobTitle);
        cvBean.setCompanyName(companyName);
        cvBean.setDuration(duration);
        cvBean.setResponsibilities(responsibilities);

        cvBean.setTechnicalSkills(technicalSkills);
        cvBean.setSoftSkills(softSkills);

        // 3. let the bean check the data (the rules live in the Model)
        if (cvBean.validate()) {
            // everything is ok, put the bean in the request scope and show the CV
            request.setAttribute("cvData", cvBean);
            request.setAttribute("cvMode", "custom");
            request.setAttribute("pageTitle", "Your Generated CV");
            forward(request, response, VIEW_CV);
        } else {
            // something is missing or wrong, show the error page instead
            request.setAttribute("errors", cvBean.getValidationErrors());
            request.setAttribute("cvData", cvBean);
            request.setAttribute("pageTitle", "Validation Error");
            forward(request, response, VIEW_ERROR);
        }
    }

    /**
     * Handles GET requests: the sample CV, or the normal form page.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");

        if ("sample".equalsIgnoreCase(action)) {
            // build a bean that is already filled in with dummy data
            CVBean sampleBean = buildSampleCV();

            // same view as the POST flow, so I only need one CV template
            request.setAttribute("cvData", sampleBean);
            request.setAttribute("cvMode", "sample");
            request.setAttribute("pageTitle", "Sample CV Template");
            forward(request, response, VIEW_CV);
        } else {
            // no action, just show the form (this is also the welcome page)
            request.setAttribute("pageTitle", "CV Builder");
            forward(request, response, VIEW_FORM);
        }
    }

    /**
     * Creates the sample CV for the "Generate Template" feature. All the
     * values are set through the setters, no user input needed.
     */
    private CVBean buildSampleCV() {

        CVBean bean = new CVBean();

        // personal info
        bean.setFullName("WAN AZAMUDDIN BIN WAN ABDUL MALEK");
        bean.setProfessionalTitle("Software Developer");
        bean.setEmail("gay@gmail.com");
        bean.setPhoneNumber("012-778 4415");
        bean.setLinkedInUrl("https://www.linkedin.com/in/wanazamuddin");
        bean.setProfileSummary(
                "Fresh graduate in Computer Science from UiTM with a strong interest in "
              + "backend development. During my internship I worked on a Java web system "
              + "for a logistics company and got comfortable with servlets, JSP and MySQL. "
              + "Looking for a junior developer role where I can keep learning."
        );

        // education
        bean.setHighestDegree("Bachelor of Computer Science (Hons.)");
        bean.setInstitutionName("Universiti Teknologi MARA (UiTM), Shah Alam");
        bean.setYearOfGraduation("2025");
        bean.setMajorField("Software Engineering");

        // work experience
        bean.setJobTitle("Software Developer Intern");
        bean.setCompanyName("SwiftLogix Sdn. Bhd., Subang Jaya");
        bean.setDuration("March 2025 - August 2025");
        bean.setResponsibilities(
                "Built and fixed Java Servlets and JSP pages for the customer tracking module.\n"
              + "Wrote SQL queries and stored procedures for the MySQL database.\n"
              + "Helped test the system before release and fixed bugs reported by users.\n"
              + "Joined the weekly sprint meetings and updated my tasks in Jira.");

        // skills
        bean.setTechnicalSkills(
                "Java, JSP, Servlets, MySQL, HTML, CSS, JavaScript, Bootstrap, Git");
        bean.setSoftSkills(
                "Teamwork, Communication, Time Management, Willing to Learn");

        return bean;
    }

    /**
     * Tiny helper so I don't repeat the same three lines for every forward.
     */
    private void forward(HttpServletRequest request,
                         HttpServletResponse response,
                         String viewPath) throws ServletException, IOException {

        RequestDispatcher dispatcher = request.getRequestDispatcher(viewPath);
        dispatcher.forward(request, response);
    }
}
