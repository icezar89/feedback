<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Error</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/feedback">Feedback App</a>
        <div class="navbar-nav">
            <a class="nav-link" href="${pageContext.request.contextPath}/feedback">Submit Feedback</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/feedbacks">Admin List</a>
        </div>
    </div>
</nav>

<main class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="bg-white border rounded p-4 shadow-sm text-center">
                <p class="text-muted mb-2">Error ${statusCode}</p>
                <h1 class="h3 mb-3"><c:out value="${errorTitle}"/></h1>
                <p class="mb-4"><c:out value="${errorMessage}"/></p>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/feedback">Back to feedback form</a>
            </div>
        </div>
    </div>
</main>
</body>
</html>
