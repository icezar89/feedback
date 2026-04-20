<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><spring:message code="feedback.title"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
</head>
<body class="bg-light"
      data-notification-type="<c:out value='${notificationType}'/>"
      data-notification-message="<c:out value='${notificationMessage}'/>"
      data-email-invalid-message="<spring:message code='feedback.email.invalid'/>">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/feedback"><spring:message code="app.name"/></a>
        <div class="navbar-nav">
            <a class="nav-link active" href="${pageContext.request.contextPath}/feedback"><spring:message code="nav.submitFeedback"/></a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/feedbacks"><spring:message code="nav.adminList"/></a>
        </div>
    </div>
</nav>

<main class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="bg-white border rounded p-4 shadow-sm">
                <h1 class="h3 mb-2"><spring:message code="feedback.heading"/></h1>

                <form:form method="post" action="${pageContext.request.contextPath}/feedback" modelAttribute="feedbackForm" novalidate="novalidate">
                    <div class="mb-3">
                        <form:label path="name" cssClass="form-label"><spring:message code="feedback.name"/></form:label>
                        <form:input path="name" cssClass="form-control" maxlength="100"/>
                        <form:errors path="name" cssClass="text-danger small d-block mt-1"/>
                    </div>

                    <div class="mb-3">
                        <form:label path="email" cssClass="form-label"><spring:message code="feedback.email"/></form:label>
                        <form:input path="email" type="email" cssClass="form-control" maxlength="100"/>
                        <form:errors path="email" cssClass="text-danger small d-block mt-1"/>
                    </div>

                    <div class="mb-3">
                        <form:label path="contactType" cssClass="form-label"><spring:message code="feedback.contactType"/></form:label>
                        <form:select path="contactType" cssClass="form-select">
                            <spring:message code="feedback.contactType.placeholder" var="contactTypePlaceholder"/>
                            <form:option value="" label="${contactTypePlaceholder}"/>
                            <c:forEach items="${contactTypes}" var="type">
                                <form:option value="${type.displayName}" label="${type.displayName}"/>
                            </c:forEach>
                        </form:select>
                        <form:errors path="contactType" cssClass="text-danger small d-block mt-1"/>
                    </div>

                    <div class="mb-3">
                        <div class="d-flex justify-content-between">
                            <form:label path="message" cssClass="form-label"><spring:message code="feedback.message"/></form:label>
                            <span class="small text-muted"><span id="messageCount">0</span>/1000</span>
                        </div>
                        <form:textarea path="message" cssClass="form-control" rows="6" maxlength="1000"/>
                        <form:errors path="message" cssClass="text-danger small d-block mt-1"/>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary"><spring:message code="feedback.submit"/></button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</main>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script src="${pageContext.request.contextPath}/js/feedback-form.js"></script>
</body>
</html>
