# 📊 Kaggle Data Quality & RPCM Pipeline

An integrated toolkit for data quality assessment and automated research pipeline extraction from Kaggle projects. This framework not only evaluates and cleans datasets but also transforms Kaggle notebooks into RPCM-compatible entities ready for Apache Atlas ingestion.

## 🎯 Overview

This project brings together two main components:

1. Data Quality Assessment & Cleaning Tool

A Python module for evaluating and improving dataset quality from Kaggle, featuring automatic reliability assessment, scoring, and intelligent cleaning.

2. Kaggle to RPCM Pipeline

An automated pipeline that extracts full ML project lifecycles from Kaggle notebooks and generates structured metadata for governance and reproducibility.

Together, these modules ensure high-quality data inputs and research-ready structured outputs, supporting enterprise-level data governance.

## ⚡ Quick Start

Set your Kaggle credentials:

```
os.environ['KAGGLE_USERNAME'] = "your_username"
os.environ['KAGGLE_KEY'] = "your_api_key"
```

Select the Project:
```
kernel_refs = [
    "your-project/notebook-name/",
]
```

## 📈 Data Quality Scoring System

Weighted Metrics:

- Completeness (45%) → Missing data percentage

- Uniqueness (25%) → Duplicate rows

- Outliers (30%) → Extreme numeric values

- Threshold: 75 points → datasets below this are auto-cleaned.

## 🔍 Pipeline Components

Data Quality:

- Reliability scoring (author, license, community adoption, versioning)
- Missing value handling (median imputation / row removal)
- Duplicate removal
- Outlier clipping (5th–95th percentiles)

## Kaggle to RPCM

- Call Kaggle API → Metadata, notebooks, datasets, logs

- Extract Metadata → Models, datasets, metrics, visualizations

- Entity Generation → entities-kaggle.json (project structure)

- entities-bulk-atlas.json (Atlas import format)

## 📁 Project Structure

```
project/
├── Data_Quality.py
├── kaggle_notebooks/
│   ├── project-name-analysis/
│   │   ├── kernel-metadata.json
│   │   ├── notebook.ipynb
│   │   ├── insights-notebook.json
│   │   ├── datasets/
│   │   │   ├── *.csv
│   │   │   └── cleaned/
│   │   │       └── clean_*.csv
│   │   ├── reports/
│   │   │   ├── dataset_reliability_*.json
│   │   │   ├── datasets_analysis.json
│   │   │   ├── datasets_analysis_clean.json
│   │   │   └── pipeline_execution_report.json
│   │   ├── outputs/
│   │   │   ├── *.log
│   │   │   └── log_analysis.json
│   │   ├── visualizations/
│   │   │   └── *.png
│   │   └── entities/
│   │       ├── entities-kaggle.json
│   │       └── entities-bulk-atlas.json

```

## 🧩 Atlas Integration
- Bulk Import Ready: JSON format compatible with Apache Atlas
- Entity Mapping: Users, projects, datasets, models, metrics
- Governance Standards: Ensures reproducibility and compliance
- Execution Report: The pipeline_execution_report.json provides a traceable summary of the generated entities and extra insights on the transformation process, ensuring transparency and auditability.

## 📊 Visualizations
- Histograms with statistical annotations
- Boxplots with outlier detection counts

## 🛠️ Dependencies
- python
- kaggle
- pandas, numpy
- matplotlib, seaborn
- scikit-learn
- pathlib

## 💡 Tips

- Adjust WEIGHTS dictionary to prioritize scoring dimensions
- Modify ALERT_THRESHOLD for stricter quality control
- Customize quantile parameters for outlier handling
- Extend metadata mapping for enterprise-specific governance