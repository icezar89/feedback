Note: 
**I used CDN URLs for the JavaScript/CSS libraries instead of copying every library into the project because the interview time was short and this kept setup faster.**

## Stack

- Java 17
- Maven
- Spring Boot
- Spring MVC
- Spring Data JPA
- JSP and JSTL
- H2 in-memory database
- Jakarta Bean Validation
- Bootstrap 5
- jQuery
- Toastr

## Run Locally

```bash
mvn spring-boot:run
```

The application starts on `http://localhost:8080`.

## URLs

- Public feedback form: `http://localhost:8080/feedback`
- Admin feedback list: `http://localhost:8080/admin/feedbacks`
- H2 console: `http://localhost:8080/h2-console`

H2 console settings:

- JDBC URL: `jdbc:h2:mem:feedbackdb`
- User name: `sa`
- Password: leave empty

## Design Choices

- JSP views live under `src/main/webapp/WEB-INF/jsp`, with Spring MVC configured through `spring.mvc.view.prefix` and `spring.mvc.view.suffix`.
- The project uses WAR packaging because JSP rendering is better supported by the embedded Tomcat JSP engine in that layout.
- `FeedbackForm` is a form backing object with Bean Validation annotations, keeping request validation separate from the JPA entity.
- `ContactType` is an enum, so invalid values are rejected by Spring's binding and validation flow.
- The controller keeps web concerns small and delegates persistence and lookup logic to `FeedbackService`.
- Pagination is server-side through Spring Data JPA `Pageable`, with a fixed page size of 10.
- Filtering by contact type and sorting by submission date are handled in repository queries and pageable sorting.
- Toastr is used for user notifications. jQuery is used for light UI behavior such as the message character count.


## Potential Improvements

### Short-term
- **Replace JSP**
- **Switch to another database**

### Medium-term
- **Pagination controls in the admin view** – The backend already supports `Pageable`,
  but the UI does not yet expose page navigation controls, implement a library with pagination
  control.

### Long-term
- **Authentication & authorisation** 
- **REST API layer** – Expose a `/api/feedbacks` endpoint to decouple the backend from
  the view layer and enable future integrations (mobile app, third-party tools).
- **Email notifications** – Notify an internal team when a new  feedback is received
- **Rate limiting** – Rate limiting per IP (e.g. via Bucket4j or a gateway-level solution).
