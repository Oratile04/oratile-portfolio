install.packages(c("tidyverse", "ggplot2", "corrplot"))
library(tidyverse)
library(ggplot2)
library(corrplot)

# Use the built-in heart disease dataset — no download needed!
install.packages("heart")   # skip if already installed

# OR use the datasets that come with R automatically:
library(datasets)

sum(is.na(SAheart))

# Summary statistics for all columns
summary(SAheart)

# How many patients have heart disease?
table(SAheart$chd)

# Disease rate as a percentage
mean(SAheart$chd) * 100

# We'll use the SAheart dataset from the bestglm package
install.packages("bestglm")
library(bestglm)
data(SAheart)

# Previewing the data
head(SAheart)
dim(SAheart)
str(SAheart)

SAheart %>%
  group_by(chd) %>%
  summarise(
    avg_age      = round(mean(age), 1),
    avg_tobacco  = round(mean(tobacco), 1),
    avg_ldl      = round(mean(ldl), 1),
    avg_obesity  = round(mean(obesity), 1),
    avg_alcohol  = round(mean(alcohol), 1)
  )

# Disease rate by age group
SAheart %>%
  mutate(age_group = cut(age, breaks = c(0,30,40,50,60,100),
                         labels = c("under 30","30s","40s","50s","60+"))) %>%
  group_by(age_group) %>%
  summarise(disease_rate = round(mean(chd) * 100, 1))

# Build logistic regression model
model <- glm(chd ~ age + tobacco + ldl + obesity + alcohol + sbp,
             data   = SAheart,
             family = binomial)

# View full model results
summary(model)

# Odds ratios — which factors increase risk most?
round(exp(coef(model)), 3)

# Model accuracy
predicted <- ifelse(predict(model, type = "response") > 0.5, 1, 0)
actual    <- as.numeric(as.character(SAheart$chd))
accuracy  <- mean(predicted == actual) * 100
cat("Model accuracy:", round(accuracy, 1), "%\n")


# Chart 1: Age distribution by heart disease status
ggplot(SAheart, aes(x = age, fill = factor(chd))) +
  geom_histogram(bins = 20, alpha = 0.7, position = "identity") +
  scale_fill_manual(values = c("#4A90D9","#E05C5C"),
                    labels = c("No disease","Heart disease")) +
  labs(title = "Age distribution by heart disease status",
       x = "Age", y = "Number of patients", fill = "") +
  theme_minimal()

ggsave("chart1_age_distribution.png", width = 8, height = 5)

# Chart 2: Tobacco use vs LDL cholesterol
ggplot(SAheart, aes(x = tobacco, y = ldl, color = factor(chd))) +
  geom_point(alpha = 0.6, size = 2) +
  geom_smooth(method = "lm", se = FALSE) +
  scale_color_manual(values = c("#4A90D9","#E05C5C"),
                     labels = c("No disease","Heart disease")) +
  labs(title = "Tobacco use vs LDL cholesterol by disease status",
       x = "Tobacco (kg)", y = "LDL Cholesterol", color = "") +
  theme_minimal()

ggsave("chart2_tobacco_ldl.png", width = 8, height = 5)

# Chart 3: Disease rate by age group
SAheart %>%
  mutate(age_group = cut(age, breaks = c(0,30,40,50,60,100),
                         labels = c("under 30","30s","40s","50s","60+"))) %>%
  group_by(age_group) %>%
  summarise(disease_rate = mean(as.numeric(as.character(chd))) * 100) %>%
  ggplot(aes(x = age_group, y = disease_rate, fill = age_group)) +
  geom_col(show.legend = FALSE, alpha = 0.8) +
  labs(title = "Heart disease rate by age group",
       x = "Age group", y = "Disease rate (%)") +
  theme_minimal()

ggsave("chart3_age_group_rate.png", width = 8, height = 5)