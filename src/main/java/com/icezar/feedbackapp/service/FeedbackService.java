package com.icezar.feedbackapp.service;

import com.icezar.feedbackapp.model.ContactType;
import com.icezar.feedbackapp.model.Feedback;
import com.icezar.feedbackapp.repository.FeedbackRepository;
import com.icezar.feedbackapp.web.AdminFeedbackDto;
import com.icezar.feedbackapp.web.FeedbackForm;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class FeedbackService {

    private static final Logger logger = LogManager.getLogger(FeedbackService.class);

    private final FeedbackRepository feedbackRepository;

    public FeedbackService(FeedbackRepository feedbackRepository) {
        this.feedbackRepository = feedbackRepository;
    }

    @Transactional
    public Feedback create(FeedbackForm form) {
        Feedback feedback = new Feedback();
        feedback.setName(blankToNull(form.getName()));
        feedback.setEmail(blankToNull(form.getEmail()));
        feedback.setContactType(form.getContactType());
        feedback.setMessage(form.getMessage().trim());
        Feedback savedFeedback = feedbackRepository.save(feedback);
        logger.info(
                "Feedback saved: id={}, contactType={}, hasName={}, hasEmail={}",
                savedFeedback.getId(),
                savedFeedback.getContactType(),
                savedFeedback.getName() != null,
                savedFeedback.getEmail() != null);
        return savedFeedback;
    }

    @Transactional(readOnly = true)
    public Page<AdminFeedbackDto> findFeedbacks(ContactType contactType, Pageable pageable) {
        logger.debug("Finding feedbacks: contactType={}, pageable={}", contactType, pageable);
        if (contactType == null) {
            return feedbackRepository.findAll(pageable).map(this::toAdminFeedbackDto);
        }
        return feedbackRepository.findByContactType(contactType, pageable).map(this::toAdminFeedbackDto);
    }

    private AdminFeedbackDto toAdminFeedbackDto(Feedback feedback) {
        return new AdminFeedbackDto(
                feedback.getId(),
                feedback.getName(),
                feedback.getEmail(),
                feedback.getContactType().getDisplayName(),
                feedback.getMessage(),
                feedback.getSubmittedAt());
    }

    private String blankToNull(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        return value.trim();
    }
}
