package com.icezar.feedbackapp.config;

import com.icezar.feedbackapp.model.ContactType;
import com.icezar.feedbackapp.model.Feedback;
import com.icezar.feedbackapp.repository.FeedbackRepository;
import java.time.LocalDateTime;
import java.util.List;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DemoDataLoader implements CommandLineRunner {

    private final FeedbackRepository feedbackRepository;

    public DemoDataLoader(FeedbackRepository feedbackRepository) {
        this.feedbackRepository = feedbackRepository;
    }

    @Override
    public void run(String... args) {
        if (feedbackRepository.count() > 0) {
            return;
        }

        feedbackRepository.saveAll(List.of(
                demo("Alice Martin", "alice@example.com", ContactType.GENERAL, "The public form is easy to use.", 0),
                demo("Daniel Popescu", "daniel@example.com", ContactType.SUPPORT, "I need help finding my previous ticket.", 1),
                demo("Maya Chen", "maya@example.com", ContactType.MARKETING, "Please send campaign information.", 2),
                demo("Chris Novak", "", ContactType.GENERAL, "Anonymous-friendly feedback is useful.", 3),
                demo("Elena Ionescu", "elena@example.com", ContactType.SUPPORT, "The response time was excellent.", 4),
                demo("Iacob Cezar", "cez@example.com", ContactType.MARKETING, "Interested in partnership options.", 5),
                demo("Olivia Brown", "olivia@example.com", ContactType.GENERAL, "The UI looks clean and professional.", 6),
                demo("Liam Garcia", "liam@example.com", ContactType.SUPPORT, "I found a small typo on the help page.", 7),
                demo("Sophia Rossi", "sophia@example.com", ContactType.MARKETING, "Can I receive the monthly newsletter?", 8),
                demo("Victor Lee", "victor@example.com", ContactType.GENERAL, "Pagination makes the admin page readable.", 9),
                demo("Cezar Iacob", "cezar@example.com", ContactType.SUPPORT, "Please clarify account recovery steps.", 10),
                demo("Matei Dumitru", "matei@example.com", ContactType.GENERAL, "Good interview-sized application scope.", 11)
        ));
    }

    private Feedback demo(String name, String email, ContactType contactType, String message, int daysAgo) {
        Feedback feedback = new Feedback();
        feedback.setName(name);
        feedback.setEmail(email);
        feedback.setContactType(contactType);
        feedback.setMessage(message);
        feedback.setSubmittedAt(LocalDateTime.now().minusDays(daysAgo));
        return feedback;
    }
}
