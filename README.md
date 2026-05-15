# Heart Disease Risk Analysis

## Business Question
What patient factors best predict the likelihood of coronary heart disease?

## Dataset
SAheart — 462 real South African patient records including blood pressure,
cholesterol, tobacco use, obesity, alcohol consumption, and age.

## Tools Used
- R (bestglm, tidyverse, ggplot2)

## Process
1. Loaded and explored the SAheart dataset
2. Checked for missing values and summarised key statistics
3. Analysed disease rates across age groups and risk factors
4. Built a logistic regression model to predict heart disease
5. Evaluated model performance and visualised findings

## Key Findings
- The model predicted heart disease with **71.6% accuracy**
- Age, tobacco use, and LDL cholesterol were the strongest predictors
- Heart disease rate increases significantly from the 40s onwards
- Patients with heart disease had on average higher tobacco and LDL levels

## Visualisations

![Age Distribution](Rplot01.png)

![Tobacco vs LDL](Rplot.png)

![Disease Rate by Age Group](Rplot02.png)

## Reflection
This project taught me that statistical modelling is as much about asking
the right business question as it is about running the right model.
A 71.6% accuracy on real patient data using just 6 variables shows the
power of logistic regression as a baseline model.
