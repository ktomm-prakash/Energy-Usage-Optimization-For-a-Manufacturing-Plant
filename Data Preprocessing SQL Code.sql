use dup;
select * from glass_manufacturing;

###########################################################################################################################

# Typecasting

# Date
select cast(Date as datetime) as date_format 
from glass_manufacturing;


# Shift
SELECT CAST(Shift AS CHAR(100)) AS Shift_format
FROM glass_manufacturing;

# Furnace_ID
SELECT CAST(Furnace_ID AS CHAR(100)) AS Furnace_ID_format
FROM glass_manufacturing;

# Furnace_Type
SELECT CAST(Furnace_Type AS CHAR(100)) AS Furnace_Type_format
FROM glass_manufacturing;

# Batch_Type
SELECT CAST(Batch_Type AS CHAR(100)) AS Batch_Type_format
FROM glass_manufacturing;

# Production_Output (tons)
SELECT CAST(`Production_Output (tons)` AS DECIMAL(10,2)) AS `Production_Output (tons)_format`
FROM glass_manufacturing;

# Energy_Consumption (kWh)
SELECT CAST(`Energy_Consumption (kWh)` AS DECIMAL(10,2)) AS `Energy_Consumption (kWh)_format`
FROM glass_manufacturing;

# Furnace_Temperature (Â°C)
SELECT CAST(`Furnace_Temperature (°C)` AS DECIMAL(6,2)) AS `Furnace_Temperature (°C)_format`
FROM glass_manufacturing;

# Annealing_Time (hrs)
SELECT CAST(`Annealing_Time (hrs)` AS DECIMAL(6,2)) AS `Annealing_Time (hrs)_format`
FROM glass_manufacturing;

# Downtime (hrs)
SELECT CAST(`Downtime (hrs)` AS DECIMAL(6,2)) AS `Downtime (hrs)_format`
FROM glass_manufacturing;

# Ambient_Temperature (Â°C)
SELECT CAST(`Ambient_Temperature (°C)` AS DECIMAL(5,2)) AS `Ambient_Temperature (°C)_format`
FROM glass_manufacturing;

# Recycled_Content (%)
SELECT CAST(`Recycled_Content (%)` AS DECIMAL(5,2)) AS `Recycled_Content (%)_format`
FROM glass_manufacturing;

# Energy_Rating
SELECT CAST(`Energy_Rating` AS CHAR(1)) AS `Energy_Rating_format`
FROM glass_manufacturing;

# Maintenance_Flag
SELECT CAST(`Maintenance_Flag` AS CHAR(3)) AS `Maintenance_Flag_format`
FROM glass_manufacturing;

# Fuel_Type
SELECT CAST(`Fuel_Type` AS CHAR(50)) AS `Fuel_Type_format`
FROM glass_manufacturing;

# Glass_Thickness (mm)
SELECT CAST(`Glass_Thickness (mm)` AS DECIMAL(5,2)) AS `Glass_Thickness (mm)_format`
FROM glass_manufacturing;

# Production_Target (tons)
SELECT CAST(`Production_Target (tons)` AS DECIMAL(10,2)) AS `Production_Target (tons)_format`
FROM glass_manufacturing;

# Defects_Percentage (%)
SELECT CAST(`Defects_Percentage (%)` AS DECIMAL(5,2)) AS `Defects_Percentage (%)`
FROM glass_manufacturing;

# Melting_Time (hrs)
SELECT CAST(`Melting_Time (hrs)` AS DECIMAL(5,2)) AS `Melting_Time (hrs)`
FROM glass_manufacturing;

# Cooling_Energy (kWh)
SELECT CAST(`Cooling_Energy (kWh)` AS DECIMAL(10,2)) AS `Cooling_Energy (kWh)`
FROM glass_manufacturing;



############################################################################################################################

# Handlling Duplicates

SELECT 
    Date,
    Shift,
    Furnace_ID,
    Furnace_Type,
    Batch_Type,
    `Production_Output (tons)`,
    `Energy_Consumption (kWh)`,
    `Furnace_Temperature (°C)`,
    `Annealing_Time (hrs)`,
    `Downtime (hrs)`,
    `Ambient_Temperature (°C)`,
    `Recycled_Content (%)`,
    `Energy_Rating`,
    `Maintenance_Flag`,
    `Fuel_Type`,
    `Glass_Thickness (mm)`,
    `Production_Target (tons)`,
    `Defects_Percentage (%)`,
    `Melting_Time (hrs)`,
    `Cooling_Energy (kWh)`,
    COUNT(*) as duplicate_count
FROM glass_manufacturing
GROUP BY 
    Date, Shift, Furnace_ID, Furnace_Type, Batch_Type, 
    `Production_Output (tons)`, `Energy_Consumption (kWh)`,
    `Furnace_Temperature (°C)`, `Annealing_Time (hrs)`, 
    `Downtime (hrs)`, `Ambient_Temperature (°C)`, 
    `Recycled_Content (%)`, `Energy_Rating`, `Maintenance_Flag`,
    `Fuel_Type`, `Glass_Thickness (mm)`, `Production_Target (tons)`, 
    `Defects_Percentage (%)`, `Melting_Time (hrs)`, `Cooling_Energy (kWh)`
HAVING COUNT(*) > 1;


#################################################################################################################################

# Outlier Tretment

# Production_Output
UPDATE glass_manufacturing AS e
JOIN (
    SELECT 
        `Production_Output (tons)`,
        NTILE(4) OVER (ORDER BY `Production_Output (tons)`) AS quartile
    FROM glass_manufacturing
) AS subquery 
ON e.`Production_Output (tons)` = subquery.`Production_Output (tons)`
SET e.`Production_Output (tons)` = (
    SELECT AVG(temp.`Production_Output (tons)`)
    FROM (
        SELECT 
            `Production_Output (tons)`,
            NTILE(4) OVER (ORDER BY `Production_Output (tons)`) AS quartile
        FROM glass_manufacturing
    ) AS temp
    WHERE temp.quartile = subquery.quartile
)
WHERE subquery.quartile IN (1, 4);


select * from glass_manufacturing;


# Energy_Consumption (kWh)
UPDATE glass_manufacturing AS e
JOIN (
    SELECT 
        `Energy_Consumption (kWh)`,
        NTILE(4) OVER (ORDER BY `Energy_Consumption (kWh)`) AS quartile
    FROM glass_manufacturing
) AS subquery 
ON e.`Energy_Consumption (kWh)` = subquery.`Energy_Consumption (kWh)`
SET e.`Energy_Consumption (kWh)` = (
    SELECT AVG(temp.`Energy_Consumption (kWh)`)
    FROM (
        SELECT 
            `Energy_Consumption (kWh)`,
            NTILE(4) OVER (ORDER BY `Energy_Consumption (kWh)`) AS quartile
        FROM glass_manufacturing
    ) AS temp
    WHERE temp.quartile = subquery.quartile
)
WHERE subquery.quartile IN (1, 4);

select * from glass_manufacturing;


# Furnace_Temperature (°C)
UPDATE glass_manufacturing AS e
JOIN (
    SELECT 
        `Furnace_Temperature (°C)`,
        NTILE(4) OVER (ORDER BY `Furnace_Temperature (°C)`) AS quartile
    FROM glass_manufacturing
) AS subquery 
ON e.`Furnace_Temperature (°C)` = subquery.`Furnace_Temperature (°C)`
SET e.`Furnace_Temperature (°C)` = (
    SELECT AVG(temp.`Furnace_Temperature (°C)`)
    FROM (
        SELECT 
            `Furnace_Temperature (°C)`,
            NTILE(4) OVER (ORDER BY `Furnace_Temperature (°C)`) AS quartile
        FROM glass_manufacturing
    ) AS temp
    WHERE temp.quartile = subquery.quartile
)
WHERE subquery.quartile IN (1, 4);

select * from glass_manufacturing;


# Annealing_Time (hrs)
UPDATE glass_manufacturing AS e
JOIN (
    SELECT 
        `Annealing_Time (hrs)`,
        NTILE(4) OVER (ORDER BY `Annealing_Time (hrs)`) AS quartile
    FROM glass_manufacturing
) AS subquery 
ON e.`Annealing_Time (hrs)` = subquery.`Annealing_Time (hrs)`
SET e.`Annealing_Time (hrs)` = (
    SELECT AVG(temp.`Annealing_Time (hrs)`)
    FROM (
        SELECT 
            `Annealing_Time (hrs)`,
            NTILE(4) OVER (ORDER BY `Annealing_Time (hrs)`) AS quartile
        FROM glass_manufacturing
    ) AS temp
    WHERE temp.quartile = subquery.quartile
)
WHERE subquery.quartile IN (1, 4);

select * from glass_manufacturing;


# Downtime (hrs)
UPDATE glass_manufacturing AS e
JOIN (
    SELECT 
        `Downtime (hrs)`,
        NTILE(4) OVER (ORDER BY `Downtime (hrs)`) AS quartile
    FROM glass_manufacturing
) AS subquery 
ON e.`Downtime (hrs)` = subquery.`Downtime (hrs)`
SET e.`Downtime (hrs)` = (
    SELECT AVG(temp.`Downtime (hrs)`)
    FROM (
        SELECT 
            `Downtime (hrs)`,
            NTILE(4) OVER (ORDER BY `Downtime (hrs)`) AS quartile
        FROM glass_manufacturing
    ) AS temp
    WHERE temp.quartile = subquery.quartile
)
WHERE subquery.quartile IN (1, 4);

select * from glass_manufacturing;


# Ambient_Temperature (°C)
UPDATE glass_manufacturing AS e
JOIN (
    SELECT 
        `Ambient_Temperature (°C)`,
        NTILE(4) OVER (ORDER BY `Ambient_Temperature (°C)`) AS quartile
    FROM glass_manufacturing
) AS subquery 
ON e.`Ambient_Temperature (°C)` = subquery.`Ambient_Temperature (°C)`
SET e.`Ambient_Temperature (°C)` = (
    SELECT AVG(temp.`Ambient_Temperature (°C)`)
    FROM (
        SELECT 
            `Ambient_Temperature (°C)`,
            NTILE(4) OVER (ORDER BY `Ambient_Temperature (°C)`) AS quartile
        FROM glass_manufacturing
    ) AS temp
    WHERE temp.quartile = subquery.quartile
)
WHERE subquery.quartile IN (1, 4);

select * from glass_manufacturing;


# Recycled_Content (%)
UPDATE glass_manufacturing AS e
JOIN (
    SELECT 
        `Recycled_Content (%)`,
        NTILE(4) OVER (ORDER BY `Recycled_Content (%)`) AS quartile
    FROM glass_manufacturing
) AS subquery 
ON e.`Recycled_Content (%)` = subquery.`Recycled_Content (%)`
SET e.`Recycled_Content (%)` = (
    SELECT AVG(temp.`Recycled_Content (%)`)
    FROM (
        SELECT 
            `Recycled_Content (%)`,
            NTILE(4) OVER (ORDER BY `Recycled_Content (%)`) AS quartile
        FROM glass_manufacturing
    ) AS temp
    WHERE temp.quartile = subquery.quartile
)
WHERE subquery.quartile IN (1, 4);

select * from glass_manufacturing;


# Glass_Thickness (mm)
UPDATE glass_manufacturing AS e
JOIN (
    SELECT 
        `Glass_Thickness (mm)`,
        NTILE(4) OVER (ORDER BY `Glass_Thickness (mm)`) AS quartile
    FROM glass_manufacturing
) AS subquery 
ON e.`Glass_Thickness (mm)` = subquery.`Glass_Thickness (mm)`
SET e.`Glass_Thickness (mm)` = (
    SELECT AVG(temp.`Glass_Thickness (mm)`)
    FROM (
        SELECT 
            `Glass_Thickness (mm)`,
            NTILE(4) OVER (ORDER BY `Glass_Thickness (mm)`) AS quartile
        FROM glass_manufacturing
    ) AS temp
    WHERE temp.quartile = subquery.quartile
)
WHERE subquery.quartile IN (1, 4);

select * from glass_manufacturing;


# Production_Target (tons)
UPDATE glass_manufacturing AS e
JOIN (
    SELECT 
        `Production_Target (tons)`,
        NTILE(4) OVER (ORDER BY `Production_Target (tons)`) AS quartile
    FROM glass_manufacturing
) AS subquery 
ON e.`Production_Target (tons)` = subquery.`Production_Target (tons)`
SET e.`Production_Target (tons)` = (
    SELECT AVG(temp.`Production_Target (tons)`)
    FROM (
        SELECT 
            `Production_Target (tons)`,
            NTILE(4) OVER (ORDER BY `Production_Target (tons)`) AS quartile
        FROM glass_manufacturing
    ) AS temp
    WHERE temp.quartile = subquery.quartile
)
WHERE subquery.quartile IN (1, 4);

select * from glass_manufacturing;


# Defects_Percentage (%)
UPDATE glass_manufacturing AS e
JOIN (
    SELECT 
        `Defects_Percentage (%)`,
        NTILE(4) OVER (ORDER BY `Defects_Percentage (%)`) AS quartile
    FROM glass_manufacturing
) AS subquery 
ON e.`Defects_Percentage (%)` = subquery.`Defects_Percentage (%)`
SET e.`Defects_Percentage (%)` = (
    SELECT AVG(temp.`Defects_Percentage (%)`)
    FROM (
        SELECT 
            `Defects_Percentage (%)`,
            NTILE(4) OVER (ORDER BY `Defects_Percentage (%)`) AS quartile
        FROM glass_manufacturing
    ) AS temp
    WHERE temp.quartile = subquery.quartile
)
WHERE subquery.quartile IN (1, 4);

select * from glass_manufacturing;


# Melting_Time (hrs)
UPDATE glass_manufacturing AS e
JOIN (
    SELECT 
        `Melting_Time (hrs)`,
        NTILE(4) OVER (ORDER BY `Melting_Time (hrs)`) AS quartile
    FROM glass_manufacturing
) AS subquery 
ON e.`Melting_Time (hrs)` = subquery.`Melting_Time (hrs)`
SET e.`Melting_Time (hrs)` = (
    SELECT AVG(temp.`Melting_Time (hrs)`)
    FROM (
        SELECT 
            `Melting_Time (hrs)`,
            NTILE(4) OVER (ORDER BY `Melting_Time (hrs)`) AS quartile
        FROM glass_manufacturing
    ) AS temp
    WHERE temp.quartile = subquery.quartile
)
WHERE subquery.quartile IN (1, 4);

select * from glass_manufacturing;


# Cooling_Energy (kWh)
UPDATE glass_manufacturing AS e
JOIN (
    SELECT 
        `Cooling_Energy (kWh)`,
        NTILE(4) OVER (ORDER BY `Cooling_Energy (kWh)`) AS quartile
    FROM glass_manufacturing
) AS subquery 
ON e.`Cooling_Energy (kWh)` = subquery.`Cooling_Energy (kWh)`
SET e.`Cooling_Energy (kWh)` = (
    SELECT AVG(temp.`Cooling_Energy (kWh)`)
    FROM (
        SELECT 
            `Cooling_Energy (kWh)`,
            NTILE(4) OVER (ORDER BY `Cooling_Energy (kWh)`) AS quartile
        FROM glass_manufacturing
    ) AS temp
    WHERE temp.quartile = subquery.quartile
)
WHERE subquery.quartile IN (1, 4);

select * from glass_manufacturing;


######################################################################################################################

# Zero and Near Zero Variance Features

SELECT
    VARIANCE(`Production_Output (tons)`) AS `Production_Output_tons_variance`,
    VARIANCE(`Energy_Consumption (kWh)`) AS `Energy_Consumption_kWh_variance`,
    VARIANCE(`Furnace_Temperature (°C)`) AS `Furnace_Temperature_C_variance`,
    VARIANCE(`Annealing_Time (hrs)`) AS `Annealing_Time_hrs_variance`,
    VARIANCE(`Downtime (hrs)`) AS `Downtime_hrs_variance`,
    VARIANCE(`Ambient_Temperature (°C)`) AS `Ambient_Temperature_C_variance`,
    VARIANCE(`Recycled_Content (%)`) AS `Recycled_Content_percent_variance`,
    VARIANCE(`Glass_Thickness (mm)`) AS `Glass_Thickness_mm_variance`,
    VARIANCE(`Production_Target (tons)`) AS `Production_Target_tons_variance`,
    VARIANCE(`Defects_Percentage (%)`) AS `Defects_Percentage_percent_variance`,
    VARIANCE(`Melting_Time (hrs)`) AS `Melting_Time_hrs_variance`,
    VARIANCE(`Cooling_Energy (kWh)`) AS `Cooling_Energy_kWh_variance`
FROM glass_manufacturing;


#######################################################################################################################

# Missing Values

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS Date_missing,
    SUM(CASE WHEN Shift IS NULL THEN 1 ELSE 0 END) AS Shift_missing,
    SUM(CASE WHEN Furnace_ID IS NULL THEN 1 ELSE 0 END) AS Furnace_ID_missing,
    SUM(CASE WHEN Furnace_Type IS NULL THEN 1 ELSE 0 END) AS Furnace_Type_missing,
    SUM(CASE WHEN Batch_Type IS NULL THEN 1 ELSE 0 END) AS Batch_Type_missing,
    SUM(CASE WHEN `Production_Output (tons)` IS NULL THEN 1 ELSE 0 END) AS `Production_Output_tons_missing`,
    SUM(CASE WHEN `Energy_Consumption (kWh)` IS NULL THEN 1 ELSE 0 END) AS `Energy_Consumption_kWh_missing`,
    SUM(CASE WHEN `Furnace_Temperature (°C)` IS NULL THEN 1 ELSE 0 END) AS `Furnace_Temperature_C_missing`,
    SUM(CASE WHEN `Annealing_Time (hrs)` IS NULL THEN 1 ELSE 0 END) AS `Annealing_Time_hrs_missing`,
    SUM(CASE WHEN `Downtime (hrs)` IS NULL THEN 1 ELSE 0 END) AS `Downtime_hrs_missing`,
    SUM(CASE WHEN `Ambient_Temperature (°C)` IS NULL THEN 1 ELSE 0 END) AS `Ambient_Temperature_C_missing`,
    SUM(CASE WHEN `Recycled_Content (%)` IS NULL THEN 1 ELSE 0 END) AS `Recycled_Content_percent_missing`,
    SUM(CASE WHEN Energy_Rating IS NULL THEN 1 ELSE 0 END) AS Energy_Rating_missing,
    SUM(CASE WHEN Maintenance_Flag IS NULL THEN 1 ELSE 0 END) AS Maintenance_Flag_missing,
    SUM(CASE WHEN Fuel_Type IS NULL THEN 1 ELSE 0 END) AS Fuel_Type_missing,
    SUM(CASE WHEN `Glass_Thickness (mm)` IS NULL THEN 1 ELSE 0 END) AS `Glass_Thickness_mm_missing`,
    SUM(CASE WHEN `Production_Target (tons)` IS NULL THEN 1 ELSE 0 END) AS `Production_Target_tons_missing`,
    SUM(CASE WHEN `Defects_Percentage (%)` IS NULL THEN 1 ELSE 0 END) AS `Defects_Percentage_percent_missing`,
    SUM(CASE WHEN `Melting_Time (hrs)` IS NULL THEN 1 ELSE 0 END) AS `Melting_Time_hrs_missing`,
    SUM(CASE WHEN `Cooling_Energy (kWh)` IS NULL THEN 1 ELSE 0 END) AS `Cooling_Energy_kWh_missing`
FROM glass_manufacturing;

select * from glass_manufacturing;


# Replace null values 


# Production_Output (tons)
UPDATE glass_manufacturing
SET `Production_Output (tons)` = (
    SELECT avg_value
    FROM (SELECT AVG(`Production_Output (tons)`) AS avg_value FROM glass_manufacturing) AS subquery
)
WHERE `Production_Output (tons)` IS NULL;


# Energy_Consumption (kWh)
UPDATE glass_manufacturing
SET `Energy_Consumption (kWh)` = (
    SELECT avg_value
    FROM (SELECT AVG(`Energy_Consumption (kWh)`) AS avg_value FROM glass_manufacturing) AS subquery
)
WHERE `Energy_Consumption (kWh)` IS NULL;


# Furnace_Temperature (°C)
UPDATE glass_manufacturing
SET `Furnace_Temperature (°C)` = (
    SELECT avg_value
    FROM (SELECT AVG(`Furnace_Temperature (°C)`) AS avg_value FROM glass_manufacturing) AS subquery
)
WHERE `Furnace_Temperature (°C)` IS NULL;


# Annealing_Time (hrs)  
UPDATE glass_manufacturing
SET `Annealing_Time (hrs)` = (
    SELECT avg_value
    FROM (SELECT AVG(`Annealing_Time (hrs)`) AS avg_value FROM glass_manufacturing) AS subquery
)
WHERE `Annealing_Time (hrs)` IS NULL;


# Downtime (hrs)  
UPDATE glass_manufacturing
SET `Downtime (hrs)` = (
    SELECT avg_value
    FROM (SELECT AVG(`Downtime (hrs)`) AS avg_value FROM glass_manufacturing) AS subquery
)
WHERE `Downtime (hrs)` IS NULL;


# Ambient_Temperature (°C)
UPDATE glass_manufacturing
SET `Ambient_Temperature (°C)` = (
    SELECT avg_value
    FROM (SELECT AVG(`Ambient_Temperature (°C)`) AS avg_value FROM glass_manufacturing) AS subquery
)
WHERE `Ambient_Temperature (°C)` IS NULL;


# Recycled_Content (%)
UPDATE glass_manufacturing
SET `Recycled_Content (%)` = (
    SELECT avg_value
    FROM (SELECT AVG(`Recycled_Content (%)`) AS avg_value FROM glass_manufacturing) AS subquery
)
WHERE `Recycled_Content (%)` IS NULL;


# Glass_Thickness (mm)
UPDATE glass_manufacturing
SET `Glass_Thickness (mm)` = (
    SELECT avg_value
    FROM (SELECT AVG(`Glass_Thickness (mm)`) AS avg_value FROM glass_manufacturing) AS subquery
)
WHERE `Glass_Thickness (mm)` IS NULL;


# Production_Target (tons)
UPDATE glass_manufacturing
SET `Production_Target (tons)` = (
    SELECT avg_value
    FROM (SELECT AVG(`Production_Target (tons)`) AS avg_value FROM glass_manufacturing) AS subquery
)
WHERE `Production_Target (tons)` IS NULL;


# Defects_Percentage (%)
UPDATE glass_manufacturing
SET `Defects_Percentage (%)` = (
    SELECT avg_value
    FROM (SELECT AVG(`Defects_Percentage (%)`) AS avg_value FROM glass_manufacturing) AS subquery
)
WHERE `Defects_Percentage (%)` IS NULL;


# Melting_Time (hrs)
UPDATE glass_manufacturing
SET `Melting_Time (hrs)` = (
    SELECT avg_value
    FROM (SELECT AVG(`Melting_Time (hrs)`) AS avg_value FROM glass_manufacturing) AS subquery
)
WHERE `Melting_Time (hrs)` IS NULL;


# Cooling_Energy (kWh)
UPDATE glass_manufacturing
SET `Cooling_Energy (kWh)` = (
    SELECT avg_value
    FROM (SELECT AVG(`Cooling_Energy (kWh)`) AS avg_value FROM glass_manufacturing) AS subquery
)
WHERE `Cooling_Energy (kWh)` IS NULL;

select * from glass_manufacturing;


##########################################################################################################################################

# Discretization

SELECT
  'Production_Output (tons)',
  'Energy_Consumption (kWh)',
  'Furnace_Temperature (°C)',
  'Annealing_Time (hrs)',
  'Downtime (hrs)',
  'Ambient_Temperature (°C)',
  'Recycled_Content (%)',
  'Glass_Thickness (mm)',
  'Production_Target (tons)',
  'Defects_Percentage (%)',
  'Melting_Time (hrs)',
  'Cooling_Energy (kWh)',
  CASE
WHEN 'Recycled_Content (%)' < 50000 THEN 'Low'
WHEN 'Recycled_Content (%)' >= 50000 AND 'Recycled_Content (%)' < 100000 THEN 'Medium'
WHEN 'Recycled_Content (%)' >= 100000 THEN 'High'
ELSE 'Unknown'
END AS Column5_group
FROM glass_manufacturing;


###################################################################################################################

# Transformation

select 
  Date,
  Shift,
  Furnace_ID,
  Furnace_Type,
  Batch_Type,
  'Production_Output (tons)',
  'Energy_Consumption (kWh)',
  'Furnace_Temperature (°C)',
  'Annealing_Time (hrs)',
  'Downtime (hrs)',
  'Ambient_Temperature (°C)',
  'Recycled_Content (%)',
  Energy_Rating,
  Maintenance_Flag,
  Fuel_Type,
  'Glass_Thickness (mm)',
  'Production_Target (tons)',
  'Defects_Percentage (%)',
  'Melting_Time (hrs)',
  'Cooling_Energy (kWh)',
  LOG('Production_Output (tons)') AS 'Production_Output (tons)_log',
  SQRT('Production_Output (tons)') AS 'Production_Output (tons)_sqrt',
  LOG('Energy_Consumption (kWh)') AS 'Energy_Consumption (kWh)_log',
  SQRT('Energy_Consumption (kWh)') AS 'Energy_Consumption (kWh)_sqrt',
  LOG('Furnace_Temperature (°C)') AS 'Furnace_Temperature (°C)_log',
  SQRT('Furnace_Temperature (°C)') AS 'Furnace_Temperature (°C)_sqrt',
  LOG('Annealing_Time (hrs)') AS 'Annealing_Time (hrs)_log',
  SQRT('Annealing_Time (hrs)') AS 'Annealing_Time (hrs)_sqrt',
  LOG('Downtime (hrs)') AS 'Downtime (hrs)_log',
  SQRT('Downtime (hrs)') AS 'Downtime (hrs)_sqrt',
  LOG('Ambient_Temperature (°C)') AS 'Ambient_Temperature (°C)_log',
  SQRT('Ambient_Temperature (°C)') AS 'Ambient_Temperature (°C)_sqrt',
  LOG('Recycled_Content (%)') AS 'Recycled_Content (%)_log',
  SQRT('Recycled_Content (%)') AS 'Recycled_Content (%)_sqrt',
  LOG('Glass_Thickness (mm)') AS 'Glass_Thickness (mm)_log',
  SQRT('Glass_Thickness (mm)') AS 'Glass_Thickness (mm)_sqrt',
  LOG('Production_Target (tons)') AS 'Production_Target (tons)_log',
  SQRT('Production_Target (tons)') AS 'Production_Target (tons)_sqrt',
  LOG('Defects_Percentage (%)') AS 'Defects_Percentage (%)_log',
  SQRT('Defects_Percentage (%)') AS 'Defects_Percentage (%)_sqrt',
  LOG('Melting_Time (hrs)') AS 'Melting_Time (hrs)_log',
  SQRT('Melting_Time (hrs)') AS 'Melting_Time (hrs)_sqrt',
  LOG('Cooling_Energy (kWh)') AS 'Cooling_Energy (kWh)_log',
  SQRT('Cooling_Energy (kWh)') AS 'Cooling_Energy (kWh)_sqrt'
FROM Glass_Manufacturing;


###########################################################################################################################################

# Dummy Variable Creation

SELECT * 
FROM glass_manufacturing;

# Shift
SELECT
    Shift,
    CASE WHEN Shift = 'Morning' THEN 1 ELSE 0 END AS is_morning,
    CASE WHEN Shift = 'Afternoon' THEN 1 ELSE 0 END AS is_afternoon,
    CASE WHEN Shift = 'Night' THEN 1 ELSE 0 END AS is_night
FROM glass_manufacturing;


# Furnace_Type
SELECT
    Furnace_Type,
    CASE WHEN Furnace_Type = 'Electric' THEN 1 ELSE 0 END AS is_Electric,
    CASE WHEN Furnace_Type = 'Hybrid' THEN 1 ELSE 0 END AS is_Hybrid,
    CASE WHEN Furnace_Type = 'Gas' THEN 1 ELSE 0 END AS is_Gas
FROM glass_manufacturing;


# Batch_Type
SELECT
    Batch_Type,
    CASE WHEN Batch_Type = 'Borosilicate' THEN 1 ELSE 0 END AS is_Borosilicate,
    CASE WHEN Batch_Type = 'Soda-lime' THEN 1 ELSE 0 END AS is_Soda_lime,
    CASE WHEN Batch_Type = 'Lead' THEN 1 ELSE 0 END AS is_Lead
FROM glass_manufacturing;


# Energy_Rating
SELECT
    Energy_Rating,
    CASE WHEN Energy_Rating = 'A' THEN 1 ELSE 0 END AS is_A,
    CASE WHEN Energy_Rating = 'B' THEN 1 ELSE 0 END AS is_B,
    CASE WHEN Energy_Rating = 'C' THEN 1 ELSE 0 END AS is_C
FROM glass_manufacturing;


# Maintenance_Flag
SELECT
    Maintenance_Flag,
    CASE WHEN Maintenance_Flag = 'Yes' THEN 1 ELSE 0 END AS is_Yes,
    CASE WHEN Maintenance_Flag = 'No' THEN 1 ELSE 0 END AS is_No
FROM glass_manufacturing;


# Fuel_Type
SELECT
    Fuel_Type,
    CASE WHEN Fuel_Type = 'Natural Gas' THEN 1 ELSE 0 END AS is_Natural_Gas,
    CASE WHEN Fuel_Type = 'Electricity' THEN 1 ELSE 0 END AS is_Electricity
FROM glass_manufacturing;


select * from glass_manufacturing;


#####################################################################################################################
