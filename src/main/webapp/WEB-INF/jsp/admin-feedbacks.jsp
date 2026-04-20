<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Feedback List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/feedback">Feedback App</a>
        <div class="navbar-nav">
            <a class="nav-link" href="${pageContext.request.contextPath}/feedback">Submit Feedback</a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/feedbacks">Admin List</a>
        </div>
    </div>
</nav>

<main class="container py-5">
    <div class="d-flex justify-content-between align-items-start mb-4">
        <div>
            <h1 class="h3 mb-1">Feedback entries</h1>
        </div>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/feedback">New feedback</a>
    </div>

    <form class="row g-3 align-items-end bg-white border rounded p-3 mb-4 shadow-sm" method="get" action="${pageContext.request.contextPath}/admin/feedbacks">
        <input type="hidden" name="sort" value="${sort}">
        <div class="col-md-4">
            <label for="contactType" class="form-label">Filter by contact type</label>
            <select id="contactType" name="contactType" class="form-select" onchange="this.form.submit()">
                <option value="">All contact types</option>
                <c:forEach items="${contactTypes}" var="type">
                    <option value="${type.displayName}" ${selectedContactType == type ? 'selected' : ''}>${type.displayName}</option>
                </c:forEach>
            </select>
        </div>
<%--        <div class="col-md-3">--%>
<%--            <label for="direction" class="form-label">Sort direction</label>--%>
<%--            <select id="direction" name="direction" class="form-select" onchange="this.form.submit()">--%>
<%--                <option value="desc" ${direction == 'desc' ? 'selected' : ''}>Newest first</option>--%>
<%--                <option value="asc" ${direction == 'asc' ? 'selected' : ''}>Oldest first</option>--%>
<%--            </select>--%>
<%--        </div>--%>
        <div class="col-md-5 d-flex gap-2">
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/feedbacks">Reset</a>
        </div>
    </form>

    <div class="bg-white border rounded shadow-sm">
        <div class="table-responsive">
            <table class="table table-striped table-hover align-middle mb-0">
                <thead class="table-dark">
                <tr>
                    <th>
                        <c:url var="idSortUrl" value="/admin/feedbacks">
                            <c:param name="page" value="0"/>
                            <c:param name="sort" value="id"/>
                            <c:param name="direction" value="${sort == 'id' ? oppositeDirection : 'asc'}"/>
                            <c:if test="${not empty selectedContactType}">
                                <c:param name="contactType" value="${selectedContactType.displayName}"/>
                            </c:if>
                        </c:url>
                        <a class="text-white text-decoration-none" href="${idSortUrl}">
                            ID
                            <c:if test="${sort == 'id'}"><span class="small">(${direction})</span></c:if>
                        </a>
                    </th>
                    <th>
                        <c:url var="submittedAtSortUrl" value="/admin/feedbacks">
                            <c:param name="page" value="0"/>
                            <c:param name="sort" value="submittedAt"/>
                            <c:param name="direction" value="${sort == 'submittedAt' ? oppositeDirection : 'desc'}"/>
                            <c:if test="${not empty selectedContactType}">
                                <c:param name="contactType" value="${selectedContactType.displayName}"/>
                            </c:if>
                        </c:url>
                        <a class="text-white text-decoration-none" href="${submittedAtSortUrl}">
                            Date of submission
                            <c:if test="${sort == 'submittedAt'}"><span class="small">(${direction == 'desc' ? 'newest' : 'oldest'})</span></c:if>
                        </a>
                    </th>
                    <th>
                        <c:url var="nameSortUrl" value="/admin/feedbacks">
                            <c:param name="page" value="0"/>
                            <c:param name="sort" value="name"/>
                            <c:param name="direction" value="${sort == 'name' ? oppositeDirection : 'asc'}"/>
                            <c:if test="${not empty selectedContactType}">
                                <c:param name="contactType" value="${selectedContactType.displayName}"/>
                            </c:if>
                        </c:url>
                        <a class="text-white text-decoration-none" href="${nameSortUrl}">
                            Name
                            <c:if test="${sort == 'name'}"><span class="small">(${direction})</span></c:if>
                        </a>
                    </th>
                    <th>
                        <c:url var="emailSortUrl" value="/admin/feedbacks">
                            <c:param name="page" value="0"/>
                            <c:param name="sort" value="email"/>
                            <c:param name="direction" value="${sort == 'email' ? oppositeDirection : 'asc'}"/>
                            <c:if test="${not empty selectedContactType}">
                                <c:param name="contactType" value="${selectedContactType.displayName}"/>
                            </c:if>
                        </c:url>
                        <a class="text-white text-decoration-none" href="${emailSortUrl}">
                            Email address
                            <c:if test="${sort == 'email'}"><span class="small">(${direction})</span></c:if>
                        </a>
                    </th>
                    <th>
                        <c:url var="contactTypeSortUrl" value="/admin/feedbacks">
                            <c:param name="page" value="0"/>
                            <c:param name="sort" value="contactType"/>
                            <c:param name="direction" value="${sort == 'contactType' ? oppositeDirection : 'asc'}"/>
                            <c:if test="${not empty selectedContactType}">
                                <c:param name="contactType" value="${selectedContactType.displayName}"/>
                            </c:if>
                        </c:url>
                        <a class="text-white text-decoration-none" href="${contactTypeSortUrl}">
                            Contact type
                            <c:if test="${sort == 'contactType'}"><span class="small">(${direction})</span></c:if>
                        </a>
                    </th>
                    <th>
                        <c:url var="messageSortUrl" value="/admin/feedbacks">
                            <c:param name="page" value="0"/>
                            <c:param name="sort" value="message"/>
                            <c:param name="direction" value="${sort == 'message' ? oppositeDirection : 'asc'}"/>
                            <c:if test="${not empty selectedContactType}">
                                <c:param name="contactType" value="${selectedContactType.displayName}"/>
                            </c:if>
                        </c:url>
                        <a class="text-white text-decoration-none" href="${messageSortUrl}">
                            Message
                            <c:if test="${sort == 'message'}"><span class="small">(${direction})</span></c:if>
                        </a>
                    </th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${feedbackPage.hasContent()}">
                        <c:forEach items="${feedbackPage.content}" var="feedback">
                            <tr>
                                <td>${feedback.id}</td>
                                <td><c:out value="${feedback.submittedAtDisplay}"/></td>
                                <td><c:out value="${empty feedback.name ? '-' : feedback.name}"/></td>
                                <td><c:out value="${empty feedback.email ? '-' : feedback.email}"/></td>
                                <td><span class="badge text-bg-secondary"><c:out value="${feedback.contactTypeDisplayName}"/></span></td>
                                <td style="min-width: 280px;"><c:out value="${feedback.message}"/></td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" class="text-center py-4 text-muted">No feedback entries found.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <c:if test="${feedbackPage.totalPages > 1}">
        <nav class="mt-4" aria-label="Feedback pagination">
            <ul class="pagination justify-content-center">
                <c:set var="previousDisabled" value="${feedbackPage.first ? 'disabled' : ''}"/>
                <li class="page-item ${previousDisabled}">
                    <c:url var="previousUrl" value="/admin/feedbacks">
                        <c:param name="page" value="${feedbackPage.number - 1}"/>
                        <c:param name="sort" value="${sort}"/>
                        <c:param name="direction" value="${direction}"/>
                        <c:if test="${not empty selectedContactType}">
                            <c:param name="contactType" value="${selectedContactType.displayName}"/>
                        </c:if>
                    </c:url>
                    <a class="page-link" href="${previousUrl}">Previous</a>
                </li>

                <c:forEach begin="0" end="${feedbackPage.totalPages - 1}" var="pageNumber">
                    <li class="page-item ${feedbackPage.number == pageNumber ? 'active' : ''}">
                        <c:url var="pageUrl" value="/admin/feedbacks">
                            <c:param name="page" value="${pageNumber}"/>
                            <c:param name="sort" value="${sort}"/>
                            <c:param name="direction" value="${direction}"/>
                            <c:if test="${not empty selectedContactType}">
                                <c:param name="contactType" value="${selectedContactType.displayName}"/>
                            </c:if>
                        </c:url>
                        <a class="page-link" href="${pageUrl}">${pageNumber + 1}</a>
                    </li>
                </c:forEach>

                <c:set var="nextDisabled" value="${feedbackPage.last ? 'disabled' : ''}"/>
                <li class="page-item ${nextDisabled}">
                    <c:url var="nextUrl" value="/admin/feedbacks">
                        <c:param name="page" value="${feedbackPage.number + 1}"/>
                        <c:param name="sort" value="${sort}"/>
                        <c:param name="direction" value="${direction}"/>
                        <c:if test="${not empty selectedContactType}">
                            <c:param name="contactType" value="${selectedContactType.displayName}"/>
                        </c:if>
                    </c:url>
                    <a class="page-link" href="${nextUrl}">Next</a>
                </li>
            </ul>
        </nav>
    </c:if>

    <p class="text-center text-muted mt-3">
        Showing page ${feedbackPage.number + 1} of ${feedbackPage.totalPages == 0 ? 1 : feedbackPage.totalPages},
        ${feedbackPage.totalElements} total entries.
    </p>
</main>

</body>
</html>
