# heart-disease-ml-analysis
Comparative analysis of machine learning models for heart disease prediction using the UCI Heart Disease dataset.

# Visual Analytics and Comparative Evaluation of Machine Learning Models for Heart Disease Prediction ❤️📊

## Overview
This project presents a comprehensive comparative evaluation of classical machine learning models for predicting heart disease using the UCI Heart Disease dataset. The study integrates data preprocessing, exploratory data analysis, visual analytics, and predictive modeling to balance predictive performance with model interpretability in a healthcare context.

## Objectives
- Preprocess and clean the UCI Heart Disease dataset
- Perform exploratory data analysis (EDA) to understand feature relationships
- Compare multiple machine learning classifiers
- Evaluate models using standard performance metrics
- Use visualization techniques to improve interpretability and clinical relevance

## Dataset
- **Source:** UCI Machine Learning Repository – Heart Disease Dataset  
- **Records:** 900+ patient records (combined datasets)
- **Features include:**
  - Demographics: age, sex
  - Clinical indicators: chest pain type, cholesterol, blood pressure
  - Exercise-related features: maximum heart rate, exercise-induced angina
  - ECG and diagnostic features
- **Target Variable:** Presence or absence of heart disease (binary classification)

Dataset link:  
https://archive.ics.uci.edu/ml/datasets/heart+disease

## Tools & Technologies
- **Programming Language:** R
- **Environment:** RStudio
- **Libraries Used:**
  - `caret` – model training and cross-validation
  - `randomForest` – Random Forest classifier
  - `e1071` – Support Vector Machine
  - `ggplot2` – visualization
  - `pROC` – ROC-AUC analysis
  - `corrplot` – correlation heatmaps
  - `dplyr` – data manipulation

## Project Structure
heart-disease-ml-analysis/
│
├── data/
│   ├── raw/
│   │   └── heart_disease_uci.csv
│   └── processed/
│       └── heart_disease_cleaned.csv
│
├── scripts/
│   ├── 01_data_preprocessing.R
│   ├── 02_exploratory_data_analysis.R
│   ├── 03_model_training.R
│   └── 04_model_evaluation_visuals.R
│
├── outputs/
│   └── plots/
│       ├── correlation_heatmap.png
│       ├── roc_curves.png
│       └── model_accuracy_comparison.png
│
├── report/
│   └── Visual_Analytics_and_ML_Models_for_Heart_Disease_Prediction_Report.pdf
│
├── README.md
├── .gitignore
└── LICENSE
## Models Implemented
- Logistic Regression (LR)
- Decision Tree (DT)
- Random Forest (RF)
- Support Vector Machine (SVM – RBF Kernel)

All models were trained using **10-fold cross-validation** to ensure robustness and prevent overfitting.

## Evaluation Metrics
- Accuracy
- Precision
- Recall (Sensitivity)
- F1-score
- ROC-AUC

## Key Findings
- **Random Forest** achieved the best overall performance with the highest accuracy and ROC-AUC
- **Logistic Regression** provided strong interpretability, making it suitable for clinical settings
- **SVM** balanced accuracy and generalization effectively
- **Decision Tree** was more prone to overfitting but useful for interpretability and education
- Feature importance analysis highlighted chest pain type, cholesterol, and ST depression as key predictors

## Visual Analytics
The project uses multiple visualization techniques to enhance model transparency:
- Correlation heatmaps
- Confusion matrices
- ROC curves
- Bar charts for comparative performance
- Feature importance plots (Random Forest)

## How to Run the Project
1. Clone this repository:git clone https://github.com/yourusername/heart-disease-ml-analysis.git
2. 2. Open the project in **RStudio**
3. Run the scripts in order:
- `01_data_preprocessing.R`
- `02_exploratory_data_analysis.R`
- `03_model_training.R`
- `04_model_evaluation_visuals.R`

## Project Report
The final project report is available in the `report/` directory.  
It documents the full methodology, experiments, results, visual analytics, and conclusions.

## Authors
- **Sadikuzzaman Rakib**  
- Mostak Ahmed Sadik  
- Tawkir Islam  
- Provakar Sagor  

Department of Computer Science  
American International University-Bangladesh (AIUB)

## License
This project is licensed under the MIT License.
