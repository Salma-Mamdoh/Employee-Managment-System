package com.EmployeeApp.Models;

import com.fasterxml.jackson.annotation.JsonAlias;
import com.fasterxml.jackson.annotation.JsonProperty;

public class KnownLanguage {
    @JsonProperty("languageName")
    @JsonAlias("LanguageName")
    private String languageName;

    @JsonProperty("scoreOutof100")
    @JsonAlias("ScoreOutof100")
    private int scoreOutof100;

    // Constructor
    public KnownLanguage(String languageName, int scoreOutof100) {
        this.languageName = languageName;
        this.scoreOutof100 = scoreOutof100;
    }

    // Default constructor (required for Jackson)
    public KnownLanguage() {}

    // Getters and Setters
    public String getLanguageName() {
        return languageName;
    }

    public void setLanguageName(String languageName) {
        this.languageName = languageName;
    }

    public int getScoreOutof100() {
        return scoreOutof100;
    }

    public void setScoreOutof100(int scoreOutof100) {
        this.scoreOutof100 = scoreOutof100;
    }

    @Override
    public String toString() {
        return "KnownLanguage{" +
                "languageName='" + languageName + '\'' +
                ", scoreOutof100=" + scoreOutof100 +
                '}';
    }
}
