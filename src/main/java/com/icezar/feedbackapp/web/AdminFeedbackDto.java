package com.icezar.feedbackapp.web;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import lombok.Getter;

@Getter
public class AdminFeedbackDto {

    private static final DateTimeFormatter SUBMITTED_AT_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    private final Long id;
    private final String name;
    private final String email;
    private final String contactTypeDisplayName;
    private final String message;
    private final String submittedAtDisplay;

    public AdminFeedbackDto(
            Long id,
            String name,
            String email,
            String contactTypeDisplayName,
            String message,
            LocalDateTime submittedAt) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.contactTypeDisplayName = contactTypeDisplayName;
        this.message = message;
        this.submittedAtDisplay = formatSubmittedAt(submittedAt);
    }

    private String formatSubmittedAt(LocalDateTime submittedAt) {
        if (submittedAt == null) {
            return "";
        }
        return submittedAt.format(SUBMITTED_AT_FORMATTER);
    }
}
