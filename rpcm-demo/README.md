# Streamlit Demo

This project contains a demo of the implemented pipeline, this demo was built with [Streamlit](https://streamlit.io/), which can be run locally.  


##  ⚡️ How to run the demo locally

### Run Apache Atlas

1. **Go to the demo folder**  
   ```bash
   cd rpcm-demo/atlas
    ```
2. **Up the container**
    ```
    docker-compose up -d
    ```

Once the container is up and running, you can check it by going to: http://localhost:8502⁠.

The credentials are:

- Username: admin
- Password: admin

### Run Streamlit
1. **Go to the demo folder**  
   ```bash
   cd rpcm-demo
    ```
2. **Create a virtual environment with venv**
    ```
    python -m venv venv
    ```
3. **Activate the virtual environment**

- On Linux / MacOS:
    ```
    source venv/bin/activate
    ```
- On Windows (PowerShell):
    ```
    venv\Scripts\Activate
    ```
4. **Install the requirements**
    ```
    pip install -r requirements.txt
    ```
5. **Run the app with Streamlit**
    ```
    streamlit run app.py
    ```
