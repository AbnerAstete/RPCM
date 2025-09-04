# 📊 Data Quality Assessment & Cleaning Tool

A comprehensive Python tool for evaluating and improving dataset quality from Kaggle, with automatic reliability assessment, quality scoring, and intelligent data cleaning.

## 🎯 What it does

Downloads datasets from Kaggle automatically
Evaluates dataset reliability (author reputation, community feedback, versions)
Analyzes data quality with weighted scoring system
Cleans datasets that fall below quality thresholds
Visualizes data distributions and outliers

## ⚡ Quick Start

Set your Kaggle credentials:

```python
os.environ['KAGGLE_USERNAME'] = "your_username"
os.environ['KAGGLE_KEY'] = "your_api_key"
```

## Change dataset and run
```python
dataset_name = "kaggle_user/dataset"
```

## 📈 Quality Scoring System

Weighted Components:

- Completeness (45%) - Missing data percentage.
- Uniqueness (25%) - Duplicate rows detection.
- Outliers (30%) - Extreme values in numeric columns.

Threshold: 75 points (datasets below this get auto-cleaned)

## 🔍 Data Analysis Facets

Source Facet:

- Author reputation & activity metrics.
- Dataset popularity (downloads, votes, notebooks).
- Version history and traceability.
- License and documentation quality.

Data Facet Metrics:

- Missing values per column.
- Duplicate row detection.
- Statistical distributions.
- Outlier identification using IQR method.

Automated Cleaning:

- Missing values: Median imputation for numeric, row removal for categorical
- Duplicates: Complete removal
- Outliers: Quantile-based clipping (5th-95th percentiles)

## 📁 Project Structure:
```
project/
├── Data_Quality.py                    # Main analysis script
├── datasets/                          # Downloaded datasets
│   ├── original_file1.csv
│   ├── original_file2.csv
│   └── cleaned/                       # Auto-generated cleaned datasets
│       ├── clean_original_file1.csv
│       └── clean_original_file2.csv
├── dataset_reliability_report.json    # Kaggle metadata & reputation
├── datasets_analysis.json             # Original data quality metrics
└── datasets_analysis_clean.json       # Post-cleaning analysis
```

## 🕵️‍♂️ Source Facet Report

The `dataset_reliability_report.json` provides a complete check to the Kaggle User:
### What's Inside

| Assessment Factor | Possible States | What It Evaluates |
|-------------------|-----------------|-------------------|
| **1. Author Info** | ✅ Available / ❌ Not available | Creator reputation, portfolio size, community impact |
| **2. Publication Date** | ✅ Available / ⚠️ Missing | Temporal transparency, update history |
| **3. License** | ✅ Clear license / ⚠️ Unknown license | Legal usage rights and restrictions |
| **4. External Source** | ✅ Described / ⚠️ No description | Data origin and methodology documentation |
| **5. Traceability** | ✅ Version history / ⚠️ No versions | Change tracking and data lineage |
| **6. Description** | ✅ Complete / ⚠️ Basic | Title, subtitle, and documentation quality |
| **7. Community Feedback** | ✅ High engagement / ⚠️ Low | Downloads, votes, and community adoption |


## 📊 Data Facet Analysis 

The `datasets_analysis.json` provides a complete health check to the CSV files:

### What's Inside
**File Basics**: Size, timestamps, and structure overview  
**Schema Details**: Column names, data types, and dimensions  
**Quality Metrics**: Missing values, duplicates, and completeness scores  
**Statistical Profiles**: Descriptive stats for numeric columns, top values for categorical  
**Sample Data**: Preview of actual values to verify content  

### Key Quality Indicators
- **Completeness Score** (0-100): Percentage of non-missing data
- **Duplicate Detection**: Identical rows that need removal  
- **Column Uniqueness**: How many distinct values per field
- **Data Type Validation**: Proper numeric vs categorical classification

 📊 Visualizations:

- Histograms with mean/median lines and statistical annotations
- Boxplots with outlier detection and counts

# 🛠️ Dependencies

- python
- kaggle 
- pandas
- numpy 
- matplotlib 
- seaborn 
- sklearn 
- pathlib

## 💡 Tips

- Adjust WEIGHTS dictionary to prioritize different quality aspects
- Modify ALERT_THRESHOLD based on your quality requirements
- Customize cleaning parameters (lower_quantile, upper_quantile) for outlier sensitivity