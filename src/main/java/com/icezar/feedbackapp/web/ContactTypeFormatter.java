package com.icezar.feedbackapp.web;

import com.icezar.feedbackapp.model.ContactType;
import java.text.ParseException;
import java.util.Locale;
import org.springframework.format.Formatter;
import org.springframework.stereotype.Component;

@Component
public class ContactTypeFormatter implements Formatter<ContactType> {

    @Override
    public ContactType parse(String text, Locale locale) throws ParseException {
        if (text == null || text.isBlank()) {
            return null;
        }

        for (ContactType contactType : ContactType.values()) {
            if (contactType.getDisplayName().equalsIgnoreCase(text.trim())) {
                return contactType;
            }
        }

        throw new ParseException("Unsupported contact type: " + text, 0);
    }

    @Override
    public String print(ContactType object, Locale locale) {
        return object == null ? "" : object.getDisplayName();
    }
}
