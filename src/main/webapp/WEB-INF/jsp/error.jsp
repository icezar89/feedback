<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><spring:message code="error.title"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/feedback"><spring:message code="app.name"/></a>
        <div class="navbar-nav">
            <a class="nav-link" href="${pageContext.request.contextPath}/feedback"><spring:message code="nav.submitFeedback"/></a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/feedbacks"><spring:message code="nav.adminList"/></a>
        </div>
    </div>
</nav>

<main class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="bg-white border rounded p-4 shadow-sm text-center">
                <p class="text-muted mb-2"><spring:message code="error.status" arguments="${statusCode}"/></p>
                <h1 class="h3 mb-3"><c:out value="${errorTitle}"/></h1>
                <p class="mb-4"><c:out value="${errorMessage}"/></p>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/feedback"><spring:message code="error.backToFeedback"/></a>
            </div>
        </div>
    </div>
</main>
</body>
</html>
