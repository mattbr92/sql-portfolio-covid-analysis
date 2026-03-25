SELECT
  country_region,
  ROUND(SUM(deaths) / 1000000,2) AS Total_deaths
  --## numbers in millions.
FROM
  bigquery-public-data.covid19_open_data.compatibility_view
GROUP BY
  country_region
ORDER BY
  Total_deaths DESC
LIMIT 10;
---------------------------------------------------------------------------
SELECT
  province_state,
  ROUND(SUM(confirmed) / 1000000,2) AS Total_confirmed,
  ROUND(SUM(deaths) / 1000000,2) AS Total_deaths,
  ROUND((SUM(deaths) / SUM(confirmed)) * 100,2) AS Mortality_rate
  --## numbers in millions.
FROM
  bigquery-public-data.covid19_open_data.compatibility_view
WHERE
  country_region = 'Colombia'
GROUP BY
  province_state
ORDER BY
  province_state ASC;
----------------------------------------------------------------------------
SELECT
  country_region,
  ROUND(MAX(confirmed)/1000000,2) AS peak_cases --## numbers in millions
FROM bigquery-public-data.covid19_open_data.compatibility_view
WHERE
  country_region IN ('Colombia', 'Brazil', 'Argentina', 'Mexico', 'Peru')
GROUP BY
  country_region
  ORDER BY peak_cases DESC;
----------------------------------------------------------------------------
WITH mexico_summary AS
  (
      SELECT
        province_state,
        ROUND(SUM(confirmed)/1000000,2) AS total_confirmed,
        ROUND(SUM(deaths)/1000000,2) AS total_deaths
      FROM bigquery-public-data.covid19_open_data.compatibility_view
      WHERE
        country_region = 'Mexico'
      GROUP BY
        province_state
  )      
SELECT
  *
FROM mexico_summary
WHERE
  mexico_summary.total_deaths > 0.05
ORDER BY 
  mexico_summary.total_deaths DESC;
