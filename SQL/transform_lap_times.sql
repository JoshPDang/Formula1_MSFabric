SELECT 
    raceId AS race_id,
    driverId AS driver_id,
    lap,
    position,
    time,
    milliseconds
INTO [dbo].[silver_lap_times]
FROM [Formula1_lakehouse].[dbo].[bronze_lap_times];
GO


CREATE PROCEDURE dbo.process_lap_times
AS
    SELECT 
        raceId AS race_id,
        driverId AS driver_id,
        lap,
        position,
        time,
        milliseconds
    INTO [dbo].[silver_lap_times]
    FROM [Formula1_lakehouse].[dbo].[bronze_lap_times];

GO