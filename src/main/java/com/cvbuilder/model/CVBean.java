package com.cvbuilder.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class CVBean implements Serializable {

    private static final long serialVersionUID = 1L;

    // ---------- personal information ----------
    private String fullName = "";
    private String professionalTitle = "";
    private String email = "";
    private String phoneNumber = "";
    private String linkedInUrl = "";
    private String profileSummary = "";

    // ---------- education ----------
    private String highestDegree = "";
    private String institutionName = "";
    private String yearOfGraduation = "";
    private String majorField = "";

    // ---------- work experience ----------
    private String jobTitle = "";
    private String companyName = "";
    private String duration = "";
    private String responsibilities = "";

    // ---------- skills ----------
    private String technicalSkills = "";
    private String softSkills = "";

    // stores the error messages from validate() so the servlet can display them
    private List<String> validationErrors = new ArrayList<>();

    // no-argument constructor (required by the JavaBean standard and by EL)
    public CVBean() {
    }

    /**
     * Checks the mandatory fields. Returns true if the data is ok, false if
     * something is missing or invalid. The messages are kept in the
     * validationErrors list so they can be shown on the error page.
     */
    public boolean validate() {

        // reset first, in case validate() gets called more than once
        validationErrors = new ArrayList<>();

        // full name cannot be empty
        if (isBlank(fullName)) {
            validationErrors.add("Full Name is required and cannot be empty.");
        }

        // email cannot be empty, and must look like a real email address
        if (isBlank(email)) {
            validationErrors.add("Email is required and cannot be empty.");
        } else if (!isValidEmail(email)) {
            validationErrors.add("Email format is invalid. "
                    + "Please use a valid address such as name@example.com.");
        }

        // degree cannot be empty
        if (isBlank(highestDegree)) {
            validationErrors.add("Highest Degree is required and cannot be empty.");
        }

        // must have at least one technical skill
        if (isBlank(technicalSkills)) {
            validationErrors.add("At least one Skill is required. "
                    + "Please enter your technical skills separated by commas.");
        }

        return validationErrors.isEmpty();
    }

    /**
     * Small helper so the servlet can check whether the last validate() call
     * passed or not.
     */
    public boolean isValid() {
        return validationErrors.isEmpty();
    }

    // ---------- private helper methods ----------

    // true if the value is null, empty, or only spaces
    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    // simple email format check using regex
    private boolean isValidEmail(String value) {
        String emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
        return value.trim().matches(emailRegex);
    }

    // splits "Java, SQL, HTML" into a list so the JSP can loop through it
    private List<String> splitSkills(String csv) {
        List<String> skills = new ArrayList<>();
        if (csv == null) {
            return skills;
        }
        for (String part : csv.split(",")) {
            String trimmed = part.trim();
            if (!trimmed.isEmpty()) {
                skills.add(trimmed);
            }
        }
        return skills;
    }

    // ---------- getters and setters ----------
    // (setters use trim() and handle null so the JSP never shows "null")

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName == null ? "" : fullName.trim();
    }

    public String getProfessionalTitle() {
        return professionalTitle;
    }

    public void setProfessionalTitle(String professionalTitle) {
        this.professionalTitle = professionalTitle == null ? "" : professionalTitle.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? "" : email.trim();
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber == null ? "" : phoneNumber.trim();
    }

    public String getLinkedInUrl() {
        return linkedInUrl;
    }

    public void setLinkedInUrl(String linkedInUrl) {
        this.linkedInUrl = linkedInUrl == null ? "" : linkedInUrl.trim();
    }

    public String getProfileSummary() {
        return profileSummary;
    }

    public void setProfileSummary(String profileSummary) {
        this.profileSummary = profileSummary == null ? "" : profileSummary.trim();
    }

    public String getHighestDegree() {
        return highestDegree;
    }

    public void setHighestDegree(String highestDegree) {
        this.highestDegree = highestDegree == null ? "" : highestDegree.trim();
    }

    public String getInstitutionName() {
        return institutionName;
    }

    public void setInstitutionName(String institutionName) {
        this.institutionName = institutionName == null ? "" : institutionName.trim();
    }

    public String getYearOfGraduation() {
        return yearOfGraduation;
    }

    public void setYearOfGraduation(String yearOfGraduation) {
        this.yearOfGraduation = yearOfGraduation == null ? "" : yearOfGraduation.trim();
    }

    public String getMajorField() {
        return majorField;
    }

    public void setMajorField(String majorField) {
        this.majorField = majorField == null ? "" : majorField.trim();
    }

    public String getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle == null ? "" : jobTitle.trim();
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName == null ? "" : companyName.trim();
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration == null ? "" : duration.trim();
    }

    public String getResponsibilities() {
        return responsibilities;
    }

    public void setResponsibilities(String responsibilities) {
        this.responsibilities = responsibilities == null ? "" : responsibilities.trim();
    }

    public String getTechnicalSkills() {
        return technicalSkills;
    }

    public void setTechnicalSkills(String technicalSkills) {
        this.technicalSkills = technicalSkills == null ? "" : technicalSkills.trim();
    }

    public String getSoftSkills() {
        return softSkills;
    }

    public void setSoftSkills(String softSkills) {
        this.softSkills = softSkills == null ? "" : softSkills.trim();
    }

    // ---------- read-only helpers used by the JSP ----------

    public List<String> getTechnicalSkillsList() {
        return splitSkills(technicalSkills);
    }

    public List<String> getSoftSkillsList() {
        return splitSkills(softSkills);
    }

    // splits the responsibilities textarea into one line per bullet point
    public List<String> getResponsibilitiesList() {
        List<String> items = new ArrayList<>();
        if (responsibilities == null) {
            return items;
        }
        for (String line : responsibilities.split("\\r?\\n")) {
            String trimmed = line.trim();
            if (!trimmed.isEmpty()) {
                items.add(trimmed);
            }
        }
        return items;
    }

    public List<String> getValidationErrors() {
        return validationErrors;
    }

    public void setValidationErrors(List<String> validationErrors) {
        this.validationErrors = validationErrors;
    }
}
