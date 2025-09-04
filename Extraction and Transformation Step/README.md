# 🚀 Kaggle to RPCM Pipeline
An automated data science project extraction and metadata pipeline that transforms Kaggle notebooks into research-ready structured data compatible with Apache Atlas and RPCM frameworks.

## 🎯 What It Does
Extracts complete ML project lifecycles from Kaggle notebooks including datasets, models, execution logs, and insights - then structures everything for enterprise data governance and research reproducibility.

## ⚡ Quick Start

Set your Kaggle credentials:
```python
os.environ['KAGGLE_USERNAME'] = "your_username"
os.environ['KAGGLE_KEY'] = "your_api_key"
```
Add your target kernels:
```python
kernel_refs = [
    "your-project/notebook-name/",
]
```

## 🔍 Pipeline Components

1. Call Kaggle API:

- Downloads notebook metadata and source code.
- Pulls all referenced datasets with full schema.
- Captures execution logs.
- Extracts model training results and accuracy scores.

2. Extract Metadata:

- Code Analysis: Identifies models, datasets, visualizations, and metrics.
- Log Mining: Parses execution outputs for performance data and confusion matrices.
- Notebook Insights: Sections, models used, graphs generated, and data dependencies.
- Metadata Enrichment: File sizes, creation dates, encoding detection.

3. Entity Generation

- entities-kaggle.json: Clean project structure with all components
- entities-bulk-atlas.json: Apache Atlas-compatible bulk import format


## 📁 Project Structure
```
kaggle_notebooks/
├── project-name-analysis/              # Individual project folder
│   ├── kernel-metadata.json           # Raw Kaggle metadata
│   ├── notebook.ipynb                 # Downloaded notebook
│   ├── datasets/                      # All referenced datasets
│   │   └── default/
│   │       ├── dataset1.csv
│   │       └── dataset2.csv
│   ├── outputs/                       # Execution analysis
│   │   ├── output.log                # Raw execution log
│   │   └── log_analysis.json         # Parsed performance metrics
│   ├── insights-notebook.json        # Code analysis results
│   └── entities/                      # Generated metadata
│       ├── entities-kaggle.json       # Project structure
│       └── entities-bulk-atlas.json   # Atlas import format

```

## 🏗️ Research Components Mapped

- User: Kaggle contributor profile
- Project: Notebook title and keywords
- Experiment: Purpose of the project
- Stage: Execution Phase
- Iteration: Version or run instance
- Action: Creation of the Notebook
- UsedData: Datasets, models, charts, logs, notebook
- Consensus: Validation and results

## 🧩 Atlas Integration

- Bulk Import Ready: Direct upload to Apache Atlas
- Qualified Names: Unique entity identification
- Relationship Mapping: Input/output dependencies
- Metadata Standards: Enterprise governance compliance