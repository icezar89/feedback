package com.icezar.feedbackapp;

import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.arrayContaining;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.flash;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import com.icezar.feedbackapp.model.ContactType;
import com.icezar.feedbackapp.model.Feedback;
import com.icezar.feedbackapp.repository.FeedbackRepository;
import java.util.List;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

@SpringBootTest
@AutoConfigureMockMvc
class FeedbackAppApplicationTests {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private FeedbackRepository feedbackRepository;

    @BeforeEach
    void setUp() {
        feedbackRepository.deleteAll();
    }

    @Test
    void contextLoads() {
    }

    @Test
    void feedbackFormPageLoads() throws Exception {
        mockMvc.perform(get("/feedback"))
                .andExpect(status().isOk())
                .andExpect(view().name("feedback-form"))
                .andExpect(model().attributeExists("feedbackForm"))
                .andExpect(model().attribute("contactTypes",
                        arrayContaining(ContactType.GENERAL, ContactType.MARKETING, ContactType.SUPPORT)));
    }

    @Test
    void validFeedbackSubmissionSavesFeedbackAndRedirects() throws Exception {
        mockMvc.perform(post("/feedback")
                        .param("name", "John Doe")
                        .param("email", "john@example.com")
                        .param("contactType", "support")
                        .param("message", "Please contact me about support."))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/feedback"))
                .andExpect(flash().attribute("notificationType", "success"))
                .andExpect(flash().attribute("notificationMessage", "Thank you. Your feedback was submitted."));

        List<Feedback> feedbacks = feedbackRepository.findAll();
        assertThat(feedbacks).hasSize(1);
        assertThat(feedbacks.get(0).getName()).isEqualTo("John Doe");
        assertThat(feedbacks.get(0).getEmail()).isEqualTo("john@example.com");
        assertThat(feedbacks.get(0).getContactType()).isEqualTo(ContactType.SUPPORT);
        assertThat(feedbacks.get(0).getMessage()).isEqualTo("Please contact me about support.");
        assertThat(feedbacks.get(0).getSubmittedAt()).isNotNull();
    }

    @Test
    void invalidFeedbackSubmissionReturnsFormWithValidationMessage() throws Exception {
        mockMvc.perform(post("/feedback")
                        .param("name", "John Doe")
                        .param("email", "not-valid")
                        .param("contactType", "")
                        .param("message", ""))
                .andExpect(status().isOk())
                .andExpect(view().name("feedback-form"))
                .andExpect(model().attributeHasFieldErrors("feedbackForm", "email", "contactType", "message"))
                .andExpect(model().attribute("notificationType", "error"))
                .andExpect(model().attribute("notificationMessage", "Please correct the highlighted fields."));

        assertThat(feedbackRepository.findAll()).isEmpty();
    }

    @Test
    void adminFeedbackListSupportsFilteringAndSorting() throws Exception {
        Feedback supportFeedback = feedback(ContactType.SUPPORT, "Support request");
        Feedback marketingFeedback = feedback(ContactType.MARKETING, "Marketing request");
        feedbackRepository.saveAll(List.of(supportFeedback, marketingFeedback));

        mockMvc.perform(get("/admin/feedbacks")
                        .param("contactType", "support")
                        .param("sort", "message")
                        .param("direction", "asc"))
                .andExpect(status().isOk())
                .andExpect(view().name("admin-feedbacks"))
                .andExpect(model().attribute("selectedContactType", ContactType.SUPPORT))
                .andExpect(model().attribute("sort", "message"))
                .andExpect(model().attribute("direction", "asc"))
                .andExpect(model().attribute("oppositeDirection", "desc"))
                .andExpect(model().attributeExists("feedbackPage"));
    }

    @Test
    void adminFeedbackListDefaultsInvalidSortToSubmittedAt() throws Exception {
        mockMvc.perform(get("/admin/feedbacks")
                        .param("sort", "invalid"))
                .andExpect(status().isOk())
                .andExpect(view().name("admin-feedbacks"))
                .andExpect(model().attribute("sort", "submittedAt"));
    }

    private Feedback feedback(ContactType contactType, String message) {
        Feedback feedback = new Feedback();
        feedback.setContactType(contactType);
        feedback.setMessage(message);
        return feedback;
    }
}
