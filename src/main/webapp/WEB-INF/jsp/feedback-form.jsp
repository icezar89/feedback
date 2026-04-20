<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Submit Feedback</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
</head>
<body class="bg-light"
      data-notification-type="<c:out value='${notificationType}'/>"
      data-notification-message="<c:out value='${notificationMessage}'/>">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/feedback">Feedback App</a>
        <div class="navbar-nav">
            <a class="nav-link active" href="${pageContext.request.contextPath}/feedback">Submit Feedback</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/feedbacks">Admin List</a>
        </div>
    </div>
</nav>

<main class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="bg-white border rounded p-4 shadow-sm">
                <h1 class="h3 mb-2">Submit feedback</h1>

                <form:form method="post" action="${pageContext.request.contextPath}/feedback" modelAttribute="feedbackForm" novalidate="novalidate">
                    <div class="mb-3">
                        <form:label path="name" cssClass="form-label">Name</form:label>
                        <form:input path="name" cssClass="form-control" maxlength="100"/>
                        <form:errors path="name" cssClass="text-danger small d-block mt-1"/>
                    </div>

                    <div class="mb-3">
                        <form:label path="email" cssClass="form-label">Email address</form:label>
                        <form:input path="email" type="email" cssClass="form-control" maxlength="100"/>
                        <form:errors path="email" cssClass="text-danger small d-block mt-1"/>
                    </div>

                    <div class="mb-3">
                        <form:label path="contactType" cssClass="form-label">Contact type</form:label>
                        <form:select path="contactType" cssClass="form-select">
                            <form:option value="" label="Choose a contact type"/>
                            <c:forEach items="${contactTypes}" var="type">
                                <form:option value="${type.displayName}" label="${type.displayName}"/>
                            </c:forEach>
                        </form:select>
                        <form:errors path="contactType" cssClass="text-danger small d-block mt-1"/>
                    </div>

                    <div class="mb-3">
                        <div class="d-flex justify-content-between">
                            <form:label path="message" cssClass="form-label">Message</form:label>
                            <span class="small text-muted"><span id="messageCount">0</span>/1000</span>
                        </div>
                        <form:textarea path="message" cssClass="form-control" rows="6" maxlength="1000"/>
                        <form:errors path="message" cssClass="text-danger small d-block mt-1"/>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">Submit feedback</button>
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
