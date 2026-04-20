package com.icezar.feedbackapp.controller;

import com.icezar.feedbackapp.model.ContactType;
import com.icezar.feedbackapp.service.FeedbackService;
import com.icezar.feedbackapp.web.FeedbackForm;
import jakarta.validation.Valid;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class FeedbackController {

    private static final Logger logger = LogManager.getLogger(FeedbackController.class);
    private static final int ADMIN_PAGE_SIZE = 10;

    private final FeedbackService feedbackService;

    public FeedbackController(FeedbackService feedbackService) {
        this.feedbackService = feedbackService;
    }

    @ModelAttribute("contactTypes")
    public ContactType[] contactTypes() {
        return ContactType.values();
    }

    @GetMapping({"/", "/feedback"})
    public String showFeedbackForm(Model model) {
        if (!model.containsAttribute("feedbackForm")) {
            model.addAttribute("feedbackForm", new FeedbackForm());
        }
        return "feedback-form";
    }

    @PostMapping("/feedback")
    public String submitFeedback(
            @Valid @ModelAttribute("feedbackForm") FeedbackForm feedbackForm,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes,
            Model model) {

        if (bindingResult.hasErrors()) {
            logger.warn("Feedback submission failed validation with {} error(s)", bindingResult.getErrorCount());
            model.addAttribute("notificationType", "error");
            model.addAttribute("notificationMessage", "Please correct the highlighted fields.");
            return "feedback-form";
        }

        feedbackService.create(feedbackForm);
        logger.info("Feedback submission accepted for contactType={}", feedbackForm.getContactType());
        redirectAttributes.addFlashAttribute("notificationType", "success");
        redirectAttributes.addFlashAttribute("notificationMessage", "Thank you. Your feedback was submitted.");
        return "redirect:/feedback";
    }

    @GetMapping("/admin/feedbacks")
    public String listFeedbacks(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(required = false) ContactType contactType,
            @RequestParam(defaultValue = "submittedAt") String sort,
            @RequestParam(defaultValue = "desc") String direction,
            Model model) {

        Sort.Direction sortDirection = "asc".equalsIgnoreCase(direction)
                ? Sort.Direction.ASC
                : Sort.Direction.DESC;
        String sortField = normalizeSortField(sort);
        Pageable pageable = PageRequest.of(Math.max(page, 0), ADMIN_PAGE_SIZE, Sort.by(sortDirection, sortField));

        logger.info(
                "Admin feedback list requested: page={}, contactType={}, sort={}, direction={}",
                Math.max(page, 0),
                contactType,
                sortField,
                sortDirection);
        model.addAttribute("feedbackPage", feedbackService.findFeedbacks(contactType, pageable));
        model.addAttribute("selectedContactType", contactType);
        model.addAttribute("sort", sortField);
        model.addAttribute("direction", sortDirection.isAscending() ? "asc" : "desc");
        model.addAttribute("oppositeDirection", sortDirection.isAscending() ? "desc" : "asc");

        return "admin-feedbacks";
    }

    private String normalizeSortField(String sort) {
        if (!"id".equals(sort)
                && !"submittedAt".equals(sort)
                && !"name".equals(sort)
                && !"email".equals(sort)
                && !"contactType".equals(sort)
                && !"message".equals(sort)) {
            logger.warn("Invalid admin sort field '{}' requested; defaulting to submittedAt", sort);
        }
        return switch (sort) {
            case "id", "submittedAt", "name", "email", "contactType", "message" -> sort;
            default -> "submittedAt";
        };
    }
}
