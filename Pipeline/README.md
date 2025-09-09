#  🚀 Kaggle metadata entities Transformation into RPCM entities Pipeline

An integrated pipeline for data quality assessment and  metadata extraction from Kaggle projects. This notebook not only evaluates and cleans datasets but also transforms Kaggle Projects into RPCM-compatible entities ready for Apache Atlas ingestion.

## 📌 Pipeline Workflow

1. **Data Quality Assessment**  
   - Evaluate its structure, completeness, and potential quality issues.  

2. **Metadata Extraction**  
   - Extract metadata from Kaggle Project.  
   - Consolidate the information into a single JSON file.  
   - This unified file serves as the foundation for the RPCM transformation.  

3. **Transformation to RPCM Entities**  
   - Convert the consolidated JSON into RPCM-compliant entities.  
   - Generate a structured output ready for ingestion into a metadata system.  


## 📊 Data Quality Assessment

Following the approach proposed in the paper "The Five Facets of Data Quality Assessment" and comparing it with the types of datasets available on Kaggle, We following this adaptation for our case, focused on building a standardized data quality analysis framework:

![Step1 Diagram](/images/step1.svg)

### 🔍 Data Analysis Facets

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

## 🔍 Metadata Extraction 

This step identify models, datasets, visualizations, and metrics used throughout the **Metadata Project**. It conducts **Log Mining** to parse execution outputs for performance data and confusion matrices. The pipeline extracts **Notebook Insights** including sections, models used, graphs generated, and data dependencies. Additionally, it enriches the metadata with technical details such as file sizes, creation dates, and encoding detection.

![Step2 Diagram](/images/step2.png)





## Transformation to RPCM Entities

This step transform a structured input dictionary (extracted metadata from Kaggle) into a collection of entities formatted to be ingested into the ATLAS metadata repository. The output is a **list of dictionaries**, each representing an ATLAS entity with assigned types, GUIDs. This bulk of entities is then ready to be ingested by ATLAS, enabling tracking and governance of workflows with provenance and lineage.

![Step3 Diagram](/images/step3.svg)

### 🏗️ Research Components Mapped
- User: Kaggle contributor profile
- Project: Notebook title and keywords
- Experiment: Purpose of the project
- Stage: Execution Phase
- Iteration: Version or run instance
- Action: Creation of the Notebook
- UsedData: Datasets, models, charts, logs, notebook
- Consensus: Validation and results

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




