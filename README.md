# RPCM Pipeline Validation

This repository contains the validation of an experiment implementing the **Research Processes Curation Metamodel (RPCM)** through a **data pipeline**.  

The workflow focuses on assessing a Kaggle dataset, extracting metadata, and transforming it into RPCM entities, which are then integrated and validated within **Apache Atlas**.

## 🎯 Objectives of the Experiment

- Validate the RPCM metamodel  
- Demonstrate the ability to structure research processes  
- Verify the effectiveness of taxonomy queries  
- Establish a replicable framework for future validations 

## 📌 Pipeline Workflow

1. **Data Quality Assessment**  
   - Download the selected dataset from Kaggle.  
   - Evaluate its structure, completeness, and potential quality issues.  

2. **Metadata Extraction**  
   - Extract metadata from Kaggle.  
   - Consolidate the information into a single `metadata.json` file.  
   - This unified file serves as the foundation for the RPCM transformation.  

3. **Transformation to RPCM Entities**  
   - Convert the consolidated JSON into RPCM-compliant entities.  
   - Generate a structured output ready for ingestion into a metadata system.  

4. **Taxonomy Queries**  
   - Validate that RPCM enables a comprehensive exploration of research processes.  

The **first three steps** of the pipeline were implemented using **Google Colab notebooks**, which are also included in this repository along with their respective documentation.


## ⚙️ Environment Setup

The environment is built with **Docker** using an **Apache Atlas** container.  
This repository includes an `atlas.yml` file that defines the Atlas image and mounts volumes with three JSON files:  

- `Entitydefs.json` → RPCM entity definitions ready for ingestion into Atlas.  
- `graffiti_project.json` → Validation of the use case.  
- `entities-bulk-atlas.json` → Result of the validation pipeline (included directly for convenience, but its creation is also documented in the **Extraction and Transformation Step** folder).  


## 🚀 Start Atlas

Pull and start the Atlas container:

```bash
docker-compose -f atlas.yml pull
docker-compose -f atlas.yml up atlas
```
✅ Check that the container is running
```bash
docker ps
```
🔑 Access the container
```bash
docker exec -it <container_id> /bin/bash
apt update && apt install -y curl
```

📥 Ingesting Entities into Atlas
1. RPCM Entity Definitions
```
curl -u admin:admin -X POST -H "Content-Type: application/json" \
-d @/tmp/Entitydefs.json \
http://localhost:21000/api/atlas/v2/types/typedefs
```
2. Use Case Instances (Graffiti Project)
```bash
curl -u admin:admin -X POST -H "Content-Type: application/json" \
-d @/tmp/graffiti_project.json \
http://localhost:21000/api/atlas/v2/entity/bulk
```
3. Pipeline Results (Kaggle Projects)
```bash
curl -u admin:admin -X POST -H "Content-Type: application/json" \
-d @/tmp/entities-bulk-atlas.json \
http://localhost:21000/api/atlas/v2/entity/bulk
```

## 🔍 Pipeline Visualization and Taxonomy Queries

Once the RPCM entities and instances have been ingested into **Apache Atlas**, you can explore and validate the research processes through **taxonomy queries**.  

These queries allow you to navigate and extract structured information directly from the RPCM entities stored in Atlas.  

### Example Query

- **List projects and their creators**
```sql
from Project select createdBy
```

## 🔍 Pipeline Visualization

If you would like to explore the pipeline interactively and see more Taxonomy Queries, you can access the Streamlit app here: https://letitia-app-mk5m8vps4krnqyxhljl9cw.streamlit.app/

