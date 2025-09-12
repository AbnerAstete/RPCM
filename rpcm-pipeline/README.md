#  🚀 Kaggle metadata entities Transformation into RPCM entities Pipeline

This pipeline automates the evaluation of data quality, extraction, and transformation of metadata from Kaggle projects into entities of the Research Processes Curation Metamodel (RPCM), ready to be ingested and explored in Apache Atlas.

## 📌 Pipeline Workflow

The pipeline is organized into four main steps. The first three steps are integrated into the Pipeline notebook. In addition, they are available separately in the Data Quality Step and Extraction and Transformation Step folders in the repository to facilitate their execution and independent analysis.

![workflow](/assets/steps.jpg)


**Step 1 – Data Quality Analysis:** Evaluate the reliability of the Kaggle user who created the datasets used in the project, as well as the condition and quality of the data. This includes detection of missing values, duplicates, and other integrity metrics.

**Step 2 – Metadata Extraction:**
Extract metadata from the Kaggle project and structure it according to our Kaggle metamodel.

![kaggle-representation](/assets/kaggle-representation.jpg)  
*Kaggle Metamodel.*

**Step 3 – Transformation to RPCM Entities:** Applies a series of transformation rules to convert the Kaggle metamodel entities obtained in the previous step into RPCM entities, generating a set of project entities ready to be ingested into Apache Atlas.

![metamodel-atlas](/assets/metamodel-atlas.png)
*RPCM adapted to Atlas.*

**Step 4 – Integration and Validation:** The entities generated in the previous step are imported into Atlas and the content is explored. Once the RPCM entities and instances have been ingested into Apache Atlas, you can explore them through queries.


**List projects and their creators:**
```SQL
FROM Project SELECT createdBy
```

## Outputs Pipeline

The pipeline generates several files, reports, and visualizations that allow users to understand the quality of the data, the extracted metadata, and the generated RPCM entities.

- Quality reports: datasets_analysis.json,  dataset_reliability_report.json  

- Extracted metadata: kernel-metadata.json, insights-notebook.json, log_analysis.json  

- RPCM entities: entities-bulk-atlas.json

- Visualizations: histograms, boxplots.


## ⚡ Quick Start

Set your Kaggle credentials:

```
os.environ['KAGGLE_USERNAME'] = "your_username"
os.environ['KAGGLE_KEY'] = "your_api_key"
```

Select the Project:
```
kernel_refs = [
    "kaggle-user/project-name/",
]
```

### 📁 Project Structure

When you have finished executing all the cells, you will have generated a folder structure similar to this:

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


### 🛠️ Dependencias
Since the pipeline is implemented on a notebook, you can import it into Google Colab if you wish, so you won't have any problems with dependencies. But if you want to run it locally, the dependencies used were: 

- Standard Python: os, re, zipfile, json, subprocess, datetime, uuid, hashlib, base64, math, collections, pathlib

- Pandas: pandas
- NumPy: numpy
- Matplotlib: matplotlib
- Seaborn: seaborn
- Scikit-learn: scikit-learn (for SimpleImputer)
- Chardet: chardet (encoding detection)
- Nbformat: nbformat (for handling notebooks)
- Kaggle API: kaggle (KaggleApi)

### 💡 Tips
- Adjust WEIGHTS dictionary to prioritize scoring dimensions
- Modify ALERT_THRESHOLD for stricter quality control
- Customize quantile parameters for outlier handling
- Extend metadata mapping for enterprise-specific governance


## Step-by-step guide to the pipeline

For those who want to see the internal logic in detail.

![architecture](/assets/architecture.png)


