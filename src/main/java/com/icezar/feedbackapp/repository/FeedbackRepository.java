package com.icezar.feedbackapp.repository;

import com.icezar.feedbackapp.model.ContactType;
import com.icezar.feedbackapp.model.Feedback;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FeedbackRepository extends JpaRepository<Feedback, Long> {

    Page<Feedback> findByContactType(ContactType contactType, Pageable pageable);
}
