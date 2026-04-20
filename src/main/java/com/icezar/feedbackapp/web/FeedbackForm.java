package com.icezar.feedbackapp.web;

import com.icezar.feedbackapp.model.ContactType;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FeedbackForm {

    @Size(max = 100, message = "Name must be 100 characters or less.")
    private String name;

    @Email(message = "Please enter a valid email address.")
    @Size(max = 100, message = "Email address must be 100 characters or less.")
    private String email;

    @NotNull(message = "Please choose a contact type.")
    private ContactType contactType;

    @NotBlank(message = "Message is required.")
    @Size(max = 1000, message = "Message must be 1000 characters or less.")
    private String message;
}
