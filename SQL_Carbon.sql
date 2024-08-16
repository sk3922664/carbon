
SELECT * 
FROM Carbon_Emission

SELECT * 
FROM Carbon_Emission
WHERE CO2_emission_estimates IS NULL

SELECT * 
FROM Carbon_Emission
WHERE Year IS NULL

SELECT * 
FROM Carbon_Emission
WHERE Series IS NULL

SELECT * 
FROM Carbon_Emission
WHERE Value IS NULL



SELECT DISTINCT Series
FROM Carbon_Emission

SELECT MIN(Year), MAX(Year)
FROM Carbon_Emission

SELECT MIN(Value), MAX(Value)
FROM Carbon_Emission
WHERE Series = 'Emissions (thousand metric tons of carbon dioxide)'

SELECT MIN(Value), MAX(Value)
FROM Carbon_Emission
WHERE Series = 'Emissions per capita (metric tons of carbon dioxide)'



CREATE TABLE emissions
(Country nvarchar(50),
Year int, 
Series nvarchar(100), 
Value float)


INSERT INTO emissions
SELECT * FROM Carbon_Emission
WHERE Series = 'Emissions (thousand metric tons of carbon dioxide)'

SELECT * 
FROM emissions

CREATE TABLE perCapital
(Country nvarchar(50),
Year int, 
Series nvarchar(100), 
Value float)


INSERT INTO perCapital
SELECT * FROM Carbon_Emission
WHERE Series = 'Emissions per capita (metric tons of carbon dioxide)'


SELECT * 
FROM perCapital



SELECT DISTINCT Country
FROM perCapital
WHERE COUNTRY LIKE 'U%'

SELECT MIN(Value) as min_value, MAX(Value) as Max_value 
FROM perCapital
WHERE Country = 'United States of America'


SELECT Year
FROM perCapital
WHERE Country = 'United States of America'
AND Value IN (20.168, 14.606)

;WITH value1975 AS 
(SELECT Country, Value as old_value
FROM perCapital
WHERE Year = 1975), 
value2017 AS 
(SELECT Country, Value as new_value 
FROM perCapital
WHERE Year = 2017)

SELECT DISTINCT perCapital.Country, ROUND((value2017.new_value - value1975.old_value)/value1975.old_value,2) AS changes 
FROM 
value1975
INNER JOIN value2017 ON value1975.Country = value2017.Country
INNER JOIN perCapital ON value1975.Country = perCapital.Country
ORDER BY changes DESC
 


SELECT * 
FROM emissions



SELECT * 
FROM emissions
WHERE Country = 'United States of America'

SELECT MAX(Value), Min(Value)
FROM emissions
WHERE Country = 'United States of America'

SELECT * 
FROM emissions
WHERE Value = 5703220.175 
OR Value = 4355839.181 



SELECT TOP 5 Country, Sum(Value) as sum_value
FROM emissions
GROUP BY Country
ORDER BY sum_value DESC
