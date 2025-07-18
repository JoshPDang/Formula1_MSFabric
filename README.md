# 1.Overview

In this project, I will develop an end-to-end analytic dashboard using the Formula 1 dataset, leveraging Microsoft Fabric to manage and process data efficiently. The solution will incorporate key components of Microsoft Fabric, including Lakehouse, Warehouse, Data Pipeline, Dataflow and PowerBI, to facilitate a seamless data engineering and analytics workflow.

The project will follow the Medallion Architecture, which organizes data into three distinct layers:

- Bronze Layer: Raw, unprocessed data will be ingested and stored in the Lakehouse. This layer serves as the single source of truth for all raw data collected.
- Silver Layer: The data will undergo cleaning, transformation, and validation to produce refined datasets. These intermediate datasets will be stored in the Data Warehouse for further processing and analysis.
- Gold Layer: Aggregated and enriched datasets, optimized for reporting and analytics, will also be stored in the Data Warehouse. This layer serves as the foundation for the final analytical outputs and visualizations.

By implementing this architecture, I aim to ensure data quality, scalability, and performance while creating an interactive analytic dashboard to uncover insights from the Formula 1 dataset. The dashboard will provide meaningful visualizations, enabling users to explore trends, patterns, and key metrics in Formula 1 racing.

- Project Architecture:

![Project Architecture](Images/Formula1.png)

- Dashboard Example:

![Dashboard](Images/PowerBi/report_6.png)


# 2.Dataset:

The dataset used in this project is related to **Formula 1** and has been sourced from [Kaggle](https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020). This dataset is a compilation of historical Formula 1 data, originally obtained from the **[Ergast API](http://ergast.com/mrd/)**, a well-known resource for accessing Formula 1 race results, driver standings, lap times, and other relevant racing statistics.

The original dataset consists of **14 CSV files**, each representing different entities and aspects of Formula 1 racing (e.g., races, results, drivers, constructors, circuits, and lap times). However, to **demonstrate versatility in data ingestion methods** and showcase the handling of **different file formats**, I have converted some of the original CSV files into **JSON format**. This allows me to highlight multiple ingestion techniques while working with diverse file types, ensuring the project aligns with real-world data engineering scenarios.

By introducing a mix of **CSV and JSON files**, the project demonstrates the capability to ingest, process, and transform heterogeneous data formats seamlessly using modern tools and architectures.


```
.
└── Data/
    ├── lap_times/
    │   ├── lap_times_1.csv
    │   ├── lap_times_2.csv
    │   ├── lap_times_3.csv
    │   ├── lap_times_4.csv
    │   ├── lap_times_5.csv
    │   ├── lap_times_6.csv
    │   ├── lap_times_7.csv
    │   ├── lap_times_8.csv
    │   ├── lap_times_9.csv
    │   ├── lap_times_10.csv
    │   ├── lap_times_11.csv
    │   └── lap_times_12.csv
    ├── qualifying/
    │   ├── qualifying_1.json
    │   └── qualifying_2.json
    ├── circuits.csv
    ├── constructor_results.csv
    ├── constructor_standings.csv
    ├── constructors.json
    ├── driver_standings.csv
    ├── drivers.json
    ├── pit_stops.json
    ├── results.json
    ├── status.csv
    ├── races.csv
    ├── seasons.csv
    └── sprint_results.csv
```

# 3. Implementation:

## 3.1 Setup

- Create a new workspace:

![Setup workspace](Images/Setup/setup_workspace.png)

- In the newly generated Workspace, create a new data lakehouse and a data warehouse.

![Create lakehouse](Images/Setup/setup_lakehouse_1.png)
![Create lakehouse](Images/Setup/setup_lakehouse_2.png)


## 3.2 Data Ingestion:
- In the lakehouse, create subfolders with the hierachy as below:

![Create subfolders](Images/DataIngestion/create_subfolders.png)

- Upload raw data into each sub-folders:

![Upload raw data](Images/DataIngestion/upload_raw_data.png)

- Create a new data warehouse to store ingested data:

![Create data warehouse](Images/DataIngestion/create_data_warehouse.png)

- In workspace, create a new folder to store data pipelines:

![Create new folder for data pipelines](Images/DataIngestion/create_folder_for_pipelines.png)

### 3.2.1 Ingest circuits data:

- In the pipeline folder, create a new pipeline to ingest circuits data:

![Ingest circuits](Images/DataIngestion/circuits/ingest_circuits_1.png)

- Name the pipeline as "pl_ingest_circuits", then add "Copy Data" activity into the pipeline canva:

![Ingest circuits](Images/DataIngestion/circuits/ingest_circuits_2.png)

- Select data source as the circuits.csv file in the lakehouse:

![Ingest circuits](Images/DataIngestion/circuits/ingest_circuits_3.png)

- Also choose destination as data lakehouse and create a new table called "bronze_circuits":

![Ingest circuits](Images/DataIngestion/circuits/ingest_circuits_4.png)


- In "Mapping" tab, click on "Import schema". I'll remove "url" column since I won't need it in the future.

![Ingest circuits](Images/DataIngestion/circuits/ingest_circuits_5.png)

- Add "Delete data" activity to delete the source file after being copied:

![Ingest circuits](Images/DataIngestion/circuits/ingest_circuits_6.png)
![Ingest circuits](Images/DataIngestion/circuits/ingest_circuits_7.png)

- Use wildcard file path to make sure all circuits file will be deleted:

![Ingest circuits](Images/DataIngestion/circuits/ingest_circuits_8.png)

- For the purpose of this lab, I won't save logging data. However, you can save logging data into a ADLS2 by setting up connection in Logging Settings tab:

![Ingest circuits](Images/DataIngestion/circuits/ingest_circuits_9.png)


- Validate then run the pipeline:

![Ingest circuits](Images/DataIngestion/circuits/ingest_circuits_10.png)


- When your pipeline has run successfully, go to lakehouse to see if a table brone_circuits has been created under Tables and circuits.csv was deleted from circuit folder.

![Ingest circuits](Images/DataIngestion/circuits/ingest_circuits_11.png)


### 3.2.2 Ingest Constructors data:
In the data pipeline folder, create a new pipeline to ingest constructors data:

![Ingest constructors pipeline](Images/DataIngestion/constructors/ingest_constructors_1.png)

![Ingest constructors pipeline](Images/DataIngestion/constructors/ingest_constructors_2.png)

![Ingest constructors pipeline](Images/DataIngestion/constructors/ingest_constructors_3.png)

![Ingest constructors pipeline](Images/DataIngestion/constructors/ingest_constructors_4.png)

- Add "Delete data" activity:

![Ingest constructors pipeline](Images/DataIngestion/constructors/ingest_constructors_5.png)

### 3.2.3 Ingest rivers, pit stops, results and status data:

- Repeat these above to ingest drivers, pit stops and results data into data lakehouse.

![Ingest drivers, pitstops, results](Images/DataIngestion/drivers_pitstop_result/ingest_drivers_pitstops_results.png)

### 3.2.4 Ingest races data:

- To ingest races data, let's try another method. First, create a new notebook or use the notebook available in this repo:

![Ingest races](Images/DataIngestion/races/ingest_races_1.png)

- Create a new pipeline and add "Notebook" Activity into pipeline canva:

![Ingest races](Images/DataIngestion/races/ingest_races_2.png)

- In the Settings tab, look for the notebook we have created:

![Ingest races](Images/DataIngestion/races/ingest_races_2.png)

1.5 Ingest lap times data:

- Repeat 1.4 to ingest lap times data:

![Ingest lap times](Images/DataIngestion/lap_times/ingest_lap_times.png)

1.6 Ingest qualifying data:

- How to ingest qualifying data is pretty the same as others. However, since there are multiple qualifying files, we need to use "Wildcard file path" instead of File path:

![Ingest qualifying](Images/DataIngestion/qualifying/ingest_qualifying.png)

## 3.3 Data Transformation:

### 3.3.1 Process circuits data:

- Create a new Dataflow Gen2

![Processed Circuits ](Images/ProcessedData/circuits/process_circuits_1.png)

- Rename the dataflow

![Processed Circuits ](Images/ProcessedData/circuits/process_circuits_2.png)

- Import circuits data from data warehouse:

![Processed Circuits ](Images/ProcessedData/circuits/process_circuits_3.png)

- Search for Lakehouse:

![Processed Circuits ](Images/ProcessedData/circuits/process_circuits_4.png)

- Select circuits table from the warehouse:

![Processed Circuits ](Images/ProcessedData/circuits/process_circuits_5.png)

- Now we can transform circuits data. Basically, I'll standardize column names, make them meaningful and remove unecessary columns:

- Firstly, let's replace all "\N" values by "null". Select all columns, then click on Transform tab --> Replace values:

![Processed Circuits ](Images/ProcessedData/circuits/process_circuits_6.png)
![Processed Circuits ](Images/ProcessedData/circuits/process_circuits_7.png)

- Rename column headers and change data types (please refer to data types table):

![Processed Circuits ](Images/ProcessedData/circuits/process_circuits_8.png)

- After finish transforming, next step is to add data destination:

![Processed Circuits ](Images/ProcessedData/circuits/process_circuits_9.png)
![Processed Circuits ](Images/ProcessedData/circuits/process_circuits_10.png)
![Processed Circuits ](Images/ProcessedData/circuits/process_circuits_11.png)
![Processed Circuits ](Images/ProcessedData/circuits/process_circuits_12.png)

- Click on Publish to run the dataflows.

![Processed Circuits ](Images/ProcessedData/circuits/process_circuits_13.png)

- In warehouse, you'll see a new table silver_circuits created under dbo schema. Since Fabric does not give us permission to select a new schema yet, later we'll change all the newly created tables into silver schema.

![Processed Circuits ](Images/ProcessedData/circuits/process_circuits_14.png)

### 3.3.2 Transform races data:

- Repeat the same steps to process races data. The transformation is pretty the same which is to rename some columns and remove unecessary ones.

- Replace all "\N" values by null:


![Processed Races ](Images/ProcessedData/races/process_races_1.png)

- Rename, change data type, and remove columns:

![Processed Races ](Images/ProcessedData/races/process_races_2.png)

### 3.3.3: Transform constructors data:

- Rename column headers

![Processed Constructors ](Images/ProcessedData/constructors/process_constructors_1.png)

### 3.3.4: Transform drivers data:

- Besides changing column names, we need to join forename and surename of drivers into a new column called name. In the Add Column tab, select Custom Column:

![Processed Drivers ](Images/ProcessedData/drivers/process_drivers_1.png)
![Processed Drivers ](Images/ProcessedData/drivers/process_drivers_2.png)

- Rename, change data types and remove columns:

![Processed Drivers ](Images/ProcessedData/drivers/process_drivers_3.png)


### 3.3.5: Transform lap times data:

- With lap times, I'll try another method which is using SQL query. In data warehouse, create a new SQL query:

![Processed Lap Times ](Images/ProcessedData/lap_times/process_lap_times_1.png)

- Create a transformation procedure for later use:

![Processed Lap Times ](Images/ProcessedData/lap_times/process_lap_times_2.png)

### 3.3.6: Transform results data:
- Remove duplicate values in both result_id and race_id

![Processed Results ](Images/ProcessedData/results/process_results_1.png)

- Rename columns:

![Processed Results ](Images/ProcessedData/results/process_results_2.png)

### 3.3.7: Transform pit stops data:

![Processed pit stops ](Images/ProcessedData/pit_stops/process_pit_stops_1.png)

### 3.3.8: Transform status data:

![Processed status ](Images/ProcessedData/status/process_status.png)


## 3.4 Data Presentation:
### 3.1 Race result summary table:

- In workspace, create a new dataflows, then name it df_pres_race_results:

![Presentation Race Results ](Images/Presentation/race_results/pres_race_results_1.png)

- This time, import data from data warehouse, select all silver tables:

![Presentation Race Results ](Images/Presentation/race_results/pres_race_results_2.png)

- Change mode to diagram view:

![Presentation Race Results ](Images/Presentation/race_results/pres_race_results_3.png)

- First we need to merge results table and races table. Click on the 3-dot option on results table, then Merge Queries. Merge those 2 tables by race_id column.

![Presentation Race Results ](Images/Presentation/race_results/pres_race_results_4.png)
![Presentation Race Results ](Images/Presentation/race_results/pres_race_results_5.png)

- In the races table, select the following columns:

![Presentation Race Results ](Images/Presentation/race_results/pres_race_results_6.png)


- From this merged table, we will merge with circuits table. Click on the 3-dot option, then Merge Queries. Select the merge column as circuit_id:

![Presentation Race Results ](Images/Presentation/race_results/pres_race_results_7.png)

- Repeat the above steps to merge with drivers, constructors and status tables:
    - Constructor

    ![Presentation Race Results ](Images/Presentation/race_results/pres_race_results_8.png)

    - Drivers:

    ![Presentation Race Results ](Images/Presentation/race_results/pres_race_results_9.png)

    - Status:

    ![Presentation Race Results ](Images/Presentation/race_results/pres_race_results_11.png)



- Select all the needed columns and remove the rest:

![Presentation Race Results ](Images/Presentation/race_results/pres_race_results_11.png)

- Save to a new table in data warehouse:

![Presentation Race Results ](Images/Presentation/race_results/pres_race_results_13.png)
![Presentation Race Results ](Images/Presentation/race_results/pres_race_results_14.png)

### 3.2 Race count measure table:

- In this step, I'll try to create a mesaure table using SQL. In data warehouse, create a new SQL query:

![Presentation Race Results ](Images/Presentation/race_results/pres_race_results_15.png)

- Create a procedure:

![Presentation Race Results ](Images/Presentation/race_results/pres_race_results_16.png)

## 4. Power Bi Report:

- In the data warehouse, click on tab Reporting then create a New report:

![Power BI report ](Images/PowerBi/report_1.png)

- You can select all the processed table or only the table in the gold layer. In this lab, I'll select only the gold tables:

![Power BI report ](Images/PowerBi/report_2.png)
![Power BI report ](Images/PowerBi/report_3.png)

- In the Model Layouts mode, connect 2 gold tables by race_year:

![Power BI report ](Images/PowerBi/report_4.png)
![Power BI report ](Images/PowerBi/report_5.png)


- Now you are ready for your report. Below is an example which is replicated the report here [https://community.fabric.microsoft.com/t5/Data-Stories-Gallery/F1-Dashboard/m-p/2273936]


![Power BI report ](Images/PowerBi/report_6.png)


## 5. Add final pipeline:

5.1 Connect ingestion pipelines with transformation dataflows:

- Create a new pipeline then add "Invoke Pipeline" activity to the canva:

![Final Pipeline ](Images/FinalPipeline/final_pl_1.png)
![Final Pipeline ](Images/FinalPipeline/final_pl_2.png)

- Add "Dataflow" activity to pipeline canva:

![Final Pipeline ](Images/FinalPipeline/final_pl_3.png)
![Final Pipeline ](Images/FinalPipeline/final_pl_4.png)

- Repeat the above steps for other ingestion and transformation pipelines:


- For laptime transformation, we have created a procedure before. So we connect the ingestion pipeline to a procedure instead of Dataflow:


![Final Pipeline ](Images/FinalPipeline/final_pl_5.png)
![Final Pipeline ](Images/FinalPipeline/final_pl_6.png)


- Presentation Race Results Pipeline: create a new dataflow activity and connect with other activities:

![Final Pipeline ](Images/FinalPipeline/final_pl_7.png)

