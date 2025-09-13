# Thesis Project Overview - Research Processes Curation Metamodel (RPCM)

RPCM is a metamodel that provides concepts to represent both the technical artifacts (data, code, models, results) and the organizational elements (users, roles, decisions, consensus) involved in a data-driven research project. With RPCM, users can search, curate, trace, and reproduce research processes.

I developed RPCM in 2025 during my six-month mandatory master’s internship at the LIRIS laboratory.

### Usage Example

The repository includes a pipeline example demonstrating how to extract data from a Kaggle project and transform it into RPCM concepts. In this example, a Kaggle project is assumed to implicitly and explicitly contain all the elements of a typical data-driven research project:

- Hypothesis definition
- Experimentation as code
- Artifacts (datasets, models, etc.)
- Users

Given a target Kaggle project, the example pipeline automatically extracts the project’s metadata and transforms it into RPCM entities to trace the experimental cycle.






![pipeline](/assets/pipeline.png)
*Pipeline Workflow.*



## Demo

If you would like to explore the pipeline implemented, you can access the Streamlit app here: https://rpcm-demo-pipeline.streamlit.app/

## How to execute

### ⚙️ Environment Setup

The environment is built with **Docker** using an **Apache Atlas** container.  
The folder [rpcm-atlas](./rpcm-atlas) includes an `atlas.yml` file that defines the Atlas image and mounts volumes with three JSON files:  

- `Entitydefs.json`: Json that contains RPCM entities definitions ready for ingestion into Atlas.  
- `graffiti_project.json`: A JSON file containing RPCM instances of entities derived from the real use case.
- `entities-bulk-atlas.json`: The output of the pipeline that consists of Kaggle metadta represented in RPCM.

### Start Atlas

Go to the atlas folder

```bash
cd rpcm-atlas
```

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


