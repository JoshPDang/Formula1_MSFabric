CREATE TABLE gold_races_count AS
SELECT 
    COUNT(DISTINCTrace_id) AS race_count, 
    race_year
FROM silver_races
GROUP BY race_year;
GO

