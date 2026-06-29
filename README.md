# Asthma Risk Factor Analysis — Programming for Data Analysis

<p align="center">
  <img src="https://img.shields.io/badge/R-4.0+-276DC3?style=flat&logo=r&logoColor=white" />
  <img src="https://img.shields.io/badge/ggplot2-Visualization-7B68EE?style=flat" />
  <img src="https://img.shields.io/badge/Dataset-11%2C072%20records-009688?style=flat" />
  <img src="https://img.shields.io/badge/APU-072024--MHJ-0EA5E9?style=flat" />
</p>

<p align="center">
  <strong>A group data analysis project investigating which patient and environmental factors are most strongly associated with asthma diagnosis, using R and a hypothesis-driven, iterative analytical workflow.</strong>
</p>

---

![Diagnosis Distribution](docs/images/diagnosis_distribution.png)

---

## Table of Contents

- [Overview](#overview)
- [The Problem It Explores](#the-problem-it-explores)
- [Hypothesis](#hypothesis)
- [Methodology](#methodology)
- [Key Findings](#key-findings)
- [Revised Hypothesis & Final Conclusion](#revised-hypothesis--final-conclusion)
- [Tech Stack & Libraries](#tech-stack--libraries)
- [Project Structure](#project-structure)
- [Dataset](#dataset)
- [How to Reproduce](#how-to-reproduce)
- [Limitations](#limitations)
- [References](#references)

---

## Overview

This project analyzes an **11,072-record patient dataset** to identify which demographic, environmental, and lifestyle factors are most strongly associated with an asthma diagnosis. It was built entirely in **R**, using `ggplot2` and a wide range of statistical and visualization libraries to explore correlations, run significance tests, and iteratively refine a working hypothesis based on what the data actually showed.

The project follows a deliberately transparent, iterative analytical process: an initial hypothesis was formed, tested rigorously, found to be statistically weak, and then **revised based on evidence** — arriving at a stronger, data-backed final conclusion. This mirrors a real-world exploratory data analysis (EDA) workflow rather than cherry-picking results to fit an assumption.

> This was a 4-person group assignment for the *Programming for Data Analysis* module at Asia Pacific University of Technology & Innovation (APU).

---

## The Problem It Explores

Asthma is a chronic respiratory condition influenced by a complex mix of genetic, environmental, and lifestyle factors. Understanding which variables actually correlate with diagnosis — versus which are commonly assumed to matter but don't — has real value for public health screening and awareness campaigns.

This project specifically asks: **given a rich patient dataset, which combination of factors most reliably flags elevated asthma risk?**

---

## Hypothesis

**Initial hypothesis:**

> "Patients of Caucasian ethnicity who have a pollen exposure greater than 4, engage in over six hours of physical activity per week, and do not have a family history of asthma are at a heightened risk of experiencing asthma attacks."

This hypothesis was built around four variables — **Ethnicity**, **Pollen Exposure**, **Physical Activity**, and **Family History of Asthma** — chosen based on common assumptions about asthma risk factors.

---

## Methodology

The analysis followed a structured, multi-stage pipeline in R:

### 1. Data Import, Cleaning & Exploration
- Loaded the raw dataset (11,072 records, 29 columns) via `read.csv()`
- Handled missing values using **mode imputation** for categorical fields and **mean imputation** for continuous fields
- Verified data integrity with `summary()`, `str()`, and `View()` at each cleaning step

### 2. Hypothesis-Driven Filtering
- Sequentially filtered the diagnosed-patient subset (8,968 of 11,072) by each hypothesis variable
- Measured what percentage of the diagnosed population survived each filter, to gauge how strong/weak each variable was as a predictor

### 3. Statistical Testing
- **Chi-Square tests of independence** for categorical relationships (e.g. Ethnicity × Diagnosis, Family History × Diagnosis)
- **ANOVA + Tukey HSD post-hoc tests** to assess whether physical activity levels significantly affected outcomes across groups
- **Correlation matrices** (Pearson) across all numeric variables to check for relationships the filtering approach might miss

### 4. Multi-Angle Visualization
Each of the four core variables (Ethnicity, Pollen Exposure, Physical Activity, Family History) was independently explored using a different combination of chart types — including violin plots, mosaic plots, heatmaps, 3D scatter plots (via `plotly`), waffle charts, dumbbell plots, and radar charts — to triangulate findings from multiple visual perspectives before drawing conclusions.

### 5. Hypothesis Revision
When the initial four-variable hypothesis proved statistically weak (see [Key Findings](#key-findings)), the team performed a **second full pass** — distributing and visualizing *every column* in the dataset — to identify stronger candidate variables, then re-tested and rebuilt the hypothesis around the new evidence.

---

## Key Findings

### Initial hypothesis: weak

Filtering the diagnosed population sequentially by Ethnicity → Pollen Exposure → Physical Activity → Family History showed a sharp drop-off at each stage:

![Hypothesis filter funnel](docs/images/full_hypothesis_funnel.png)

| Filter Step | Patients Remaining | % of Diagnosed Population |
|---|---|---|
| Diagnosed (Diagnosis = 1) | 8,968 | 100% |
| No Family History of Asthma | 6,529 | ~73% |
| Caucasian Ethnicity | 3,692 | ~41% |
| Pollen Exposure ≥ 4 | 3,162 | ~35% |
| Physical Activity > 6 hrs/week | **408** | **~5%** |

Only **~5% of diagnosed patients** satisfied all four original hypothesis conditions simultaneously — far too low a proportion to consider the hypothesis robust. Each individual variable also showed weak explanatory power in isolation:

- **Ethnicity:** Chi-Square test showed statistical significance (p < 2.2e-16), but the Caucasian-only subset only captured ~56% of diagnosed patients — not a strong enough majority to be a reliable standalone predictor.
- **Pollen Exposure:** No meaningful correlation with physical activity or other variables (correlation coefficients consistently near 0).
- **Physical Activity:** ANOVA confirmed statistical significance (F = 10.97, p < 2e-16), but the practical effect size remained small.
- **Family History of Asthma:** Chi-Square confirmed significance (X² = 1865.3, p < 2.2e-16), but only ~5% of the full dataset had a positive family history at all — limiting its standalone usefulness as a filter.

A radar chart summarizing each independent filtering pass visualizes this consistently weak signal across all four variables:

![Radar chart summary](docs/images/radar_chart_team_summary.png)

### Pivot: testing the full dataset

Recognizing the limitations of the initial hypothesis, the team visualized the distribution of **every column** in the dataset (Age, BMI, Smoking, Sleep Quality, Lung Function, Pet Allergy, and more) to identify stronger candidate variables — leading to the discovery of two much stronger predictors:

**Lung Function (FVC) vs. Ethnicity:**

![Lung function vs ethnicity](docs/images/lung_function_vs_ethnicity.png)

Patients with `LungFunctionFVC ≥ 3` (8,537 of 8,968 diagnosed patients) made up a dramatically larger share of the diagnosed population than the Caucasian ethnicity filter (5,024 patients) — suggesting lung function is a far more relevant signal than ethnicity.

**Pet Allergy vs. Family History of Asthma:**

![Pet allergy vs family history](docs/images/pet_allergy_vs_family_history.png)

86.7% of diagnosed patients had **no pet allergy**, compared to 72.8% with no family history of asthma — indicating the *absence* of pet allergy was a more consistent pattern across diagnosed patients than family history status.

---

## Revised Hypothesis & Final Conclusion

Based on this evidence, the hypothesis was rebuilt around the two newly identified strong variables (Lung Function FVC, Pet Allergy) combined with the two original variables that retained some explanatory value (Physical Activity, Pollen Exposure) — with adjusted, evidence-based thresholds:

> **"Patients without pet allergies, with lung function (FVC) greater than three, engaging in more than three hours of physical activity, and exposed to pollen levels exceeding two, are at a heightened risk of asthma."**

This revised hypothesis was satisfied by **6,679 of 8,968 diagnosed patients (~74.5%)** — a dramatically stronger and more statistically defensible result than the original ~5%.

---

## Tech Stack & Libraries

| Category | Tools |
|---|---|
| **Language** | R |
| **Data Wrangling** | `dplyr`, `tidyr`, `janitor`, `Tmisc`, `readr` |
| **Core Visualization** | `ggplot2`, `GGally` (`ggpairs`), `ggpubr`, `gridExtra`, `patchwork` |
| **Specialized Charts** | `waffle`, `ggmosaic`, `fmsb` (radar charts), `viridis`, `hrbrthemes` |
| **3D / Interactive** | `plotly` |
| **Statistics** | Chi-Square tests, ANOVA + Tukey HSD, Pearson correlation (`corrplot`, `PerformanceAnalytics`) |
| **Model Diagnostics** | `broom`, `AICcmodavg` |

---

## Project Structure

```
asthma-risk-factor-analysis/
│
├── docs/
│   └── images/                       # Key result charts referenced in this README
│       ├── diagnosis_distribution.png
│       ├── full_hypothesis_funnel.png
│       ├── ethnicity_filter_funnel.png
│       ├── pollen_filter_funnel.png
│       ├── family_history_funnel.png
│       ├── radar_chart_team_summary.png
│       ├── lung_function_vs_ethnicity.png
│       └── pet_allergy_vs_family_history.png
│
├── data/
│   └── Asthma_dataset.csv            # Raw dataset (11,072 records)
│
├── scripts/
│   ├── 01_data_cleaning.R            # Import, missing-value handling, type conversion
│   ├── 02_hypothesis_filtering.R     # Sequential filtering by hypothesis variables
│   ├── 03_statistical_tests.R        # Chi-Square, ANOVA, correlation analysis
│   ├── 04_visualizations.R           # All ggplot2 / plotly chart generation
│   └── 05_revised_analysis.R         # Full-dataset distribution check & revised hypothesis
│
├── report/
│   └── Group_18_assignment_document.pdf   # Full written report with all 96 figures
│
└── README.md
```

> **Note:** This repository structure reflects how the project's R scripts and report are organized. If you're cloning this for the first time, place the dataset CSV in `data/` and the chart images in `docs/images/` to match the paths referenced above.

---

## Dataset

- **Source:** Patient-level asthma dataset, 11,072 records, 29 columns
- **Key variables used:** Age, Gender, Ethnicity, BMI, Smoking, Physical Activity, Diet Quality, Sleep Quality, Pollution/Pollen/Dust Exposure, Pet Allergy, Family History of Asthma, History of Allergies, Eczema, Hay Fever, Gastroesophageal Reflux, Lung Function (FEV1, FVC), Wheezing, Shortness of Breath, Chest Tightness, Coughing, Nighttime Symptoms, Exercise-Induced Symptoms, Diagnosis
- **Cleaning approach:** Missing values were imputed using column mode (categorical) or mean (continuous), followed by rounding to preserve original data types

---

## How to Reproduce

1. Clone this repository
2. Place `Asthma_dataset.csv` in the `data/` folder
3. Open R or RStudio and install required packages:

```r
install.packages(c(
  "dplyr", "tidyr", "ggplot2", "GGally", "ggpubr", "gridExtra",
  "waffle", "ggmosaic", "fmsb", "viridis", "hrbrthemes",
  "plotly", "corrplot", "PerformanceAnalytics", "broom", "AICcmodavg",
  "janitor", "plotrix", "psych"
))
```

4. Run the scripts in `scripts/` in numbered order (01 → 05)

---

## Limitations

| Limitation | Detail |
|---|---|
| Correlational, not causal | All findings describe statistical association, not proven causation |
| Single dataset | Results are specific to this dataset and may not generalize to other populations |
| Threshold sensitivity | Final hypothesis thresholds (e.g. FVC > 3, pollen > 2) were chosen based on this dataset's distribution and would need re-validation on new data |
| No predictive model | This project is exploratory/descriptive — it does not build or evaluate a classification model |

---

## References

- Bevans, R. (2020). *ANOVA in R: A Complete Step-by-Step Guide with Examples.* Scribbr.
- DataFlair Team. (2018). *Chi-Square Test in R.* DataFlair.
- Holtz, Y. *3D — The R Graph Gallery.* r-graph-gallery.com
- LiquidBrain Bioinformatics. (2021). *How to Plot a 3D Graph — Plotly Tutorial in RStudio.* YouTube.

---

<p align="center">
  <em>A Programming for Data Analysis (072024-MHJ) group assignment — Asia Pacific University of Technology & Innovation, 2024</em>
</p>
