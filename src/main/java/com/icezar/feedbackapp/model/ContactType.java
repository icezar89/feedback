package com.icezar.feedbackapp.model;

public enum ContactType {
    GENERAL("General"),
    MARKETING("Marketing"),
    SUPPORT("Support");

    private final String displayName;

    ContactType(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
