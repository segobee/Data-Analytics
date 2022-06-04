
# QUERY QUESTIONS AND STEPS OVERVIEWS 

# Quetion 1
# Find;
# 	- overall total cases for each day of the week 
#	- overall total deaths for each day of the week
# 	- percentage of the total cases/total deaths for each day of the week 
# 	- Do the analysis by country, continent, and world


# Overall total cases

# Country 
WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_cases,
				   			location
					FROM coviddeath
				    WHERE location NOT IN ('Africa',
				       				'South America',
				       				'North America',
				       				'Oceania',
				     				'Asia',
				       				'Europe',
					  			    'World',
					  				'International',
					   				'European Union',
					   				'Low income',
					   				'Lower middle income',
					   				'Upper middle income',
					   				'High income')),
		dow_table2 AS (SELECT location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_cases
								FROM dow_table)
SELECT location,
		day_of_the_week,
		SUM(new_cases) dow_total_cases
FROM dow_table2
GROUP BY 1,2
ORDER BY 1,
		CASE WHEN day_of_the_week = 'Sunday' THEN 1
			 WHEN day_of_the_week = 'Monday' THEN 2
			 WHEN day_of_the_week = 'Tuesday' THEN 3
			 WHEN day_of_the_week = 'Wednesday' THEN 4
			 WHEN day_of_the_week = 'Thursday' THEN 5
			 WHEN day_of_the_week = 'Friday' THEN 6
			 WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
		3

# Continent

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_cases,
				   			location
					FROM coviddeath
				    WHERE location IN ('Africa',
				       					'South America',
				       					'North America',
				       					'Oceania',
				     					'Asia',
				       					'Europe')),
		dow_table2 AS (SELECT location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_cases
								FROM dow_table)
SELECT location,
		day_of_the_week,
		SUM(new_cases) dow_total_cases
FROM dow_table2
GROUP BY 1,2
ORDER BY 1,
		CASE WHEN day_of_the_week = 'Sunday' THEN 1
			 WHEN day_of_the_week = 'Monday' THEN 2
			 WHEN day_of_the_week = 'Tuesday' THEN 3
			 WHEN day_of_the_week = 'Wednesday' THEN 4
			 WHEN day_of_the_week = 'Thursday' THEN 5
			 WHEN day_of_the_week = 'Friday' THEN 6
			 WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
		3

# For World

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_cases,
				   			location
					FROM coviddeath
				    WHERE location IN ('World')),
		dow_table2 AS (SELECT location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_cases
								FROM dow_table)
SELECT location,
		day_of_the_week,
		SUM(new_cases) dow_total_cases
FROM dow_table2
GROUP BY 1,2
ORDER BY 1,
		CASE WHEN day_of_the_week = 'Sunday' THEN 1
			 WHEN day_of_the_week = 'Monday' THEN 2
			 WHEN day_of_the_week = 'Tuesday' THEN 3
			 WHEN day_of_the_week = 'Wednesday' THEN 4
			 WHEN day_of_the_week = 'Thursday' THEN 5
			 WHEN day_of_the_week = 'Friday' THEN 6
			 WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
		3

# Percentage of total cases

# Country 

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_cases,
				   			continent,
				   			location,
				   			total_cases
					FROM coviddeath
				    WHERE location NOT IN ('Africa',
				       				'South America',
				       				'North America',
				       				'Oceania',
				     				'Asia',
				       				'Europe',
					  			    'World',
					  				'International',
					   				'European Union',
					   				'Low income',
					   				'Lower middle income',
					   				'Upper middle income',
					   				'High income')),
		dow_table2 AS (SELECT 	continent,
					   			location,
					   			total_cases,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_cases
								FROM dow_table),
		dow_table3 AS (SELECT 	continent,
					   			location,
								day_of_the_week,
								SUM(new_cases) dow_total_cases 
						FROM dow_table2
						GROUP BY 1,2,3
						ORDER BY 1,
					   			 2,
								CASE WHEN day_of_the_week = 'Sunday' THEN 1
									 WHEN day_of_the_week = 'Monday' THEN 2
									 WHEN day_of_the_week = 'Tuesday' THEN 3
									 WHEN day_of_the_week = 'Wednesday' THEN 4
									 WHEN day_of_the_week = 'Thursday' THEN 5
									 WHEN day_of_the_week = 'Friday' THEN 6
							 		WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
								 4),
		dow_table4 AS (SELECT 	continent,
					   			location,
								day_of_the_week,
								dow_total_cases,
								SUM(dow_total_cases) OVER(PARTITION BY location ORDER BY location) total_cases
						FROM dow_table3)
SELECT 	continent,
		location,
		day_of_the_week,
		dow_total_cases,
		round(((dow_total_cases/total_cases) * 100), 2) Percent_of_total_cases
FROM dow_table4

# Continent

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_cases,
				   			location,
				   			total_cases
					FROM coviddeath
				    WHERE location IN ('Africa',
				       				'South America',
				       				'North America',
				       				'Oceania',
				     				'Asia',
				       				'Europe')),
		dow_table2 AS (SELECT location,
					   			total_cases,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_cases
								FROM dow_table),
		dow_table3 AS (SELECT location,
								day_of_the_week,
								SUM(new_cases) dow_total_cases 
						FROM dow_table2
						GROUP BY 1,2
						ORDER BY 1,
								CASE WHEN day_of_the_week = 'Sunday' THEN 1
									 WHEN day_of_the_week = 'Monday' THEN 2
									 WHEN day_of_the_week = 'Tuesday' THEN 3
									 WHEN day_of_the_week = 'Wednesday' THEN 4
									 WHEN day_of_the_week = 'Thursday' THEN 5
									 WHEN day_of_the_week = 'Friday' THEN 6
							 		WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
								 3),
		dow_table4 AS (SELECT location,
								day_of_the_week,
								dow_total_cases,
								SUM(dow_total_cases) OVER(PARTITION BY location ORDER BY location) total_cases
						FROM dow_table3)
SELECT location,
		day_of_the_week,
		dow_total_cases,
		round(((dow_total_cases/total_cases) * 100), 2) Percent_of_total_cases
FROM dow_table4

# World

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_cases,
				   			location,
				   			total_cases
					FROM coviddeath
				    WHERE location IN ('World')),
		dow_table2 AS (SELECT location,
					   			total_cases,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_cases
								FROM dow_table),
		dow_table3 AS (SELECT location,
								day_of_the_week,
								SUM(new_cases) dow_total_cases 
						FROM dow_table2
						GROUP BY 1,2
						ORDER BY 1,
								CASE WHEN day_of_the_week = 'Sunday' THEN 1
									 WHEN day_of_the_week = 'Monday' THEN 2
									 WHEN day_of_the_week = 'Tuesday' THEN 3
									 WHEN day_of_the_week = 'Wednesday' THEN 4
									 WHEN day_of_the_week = 'Thursday' THEN 5
									 WHEN day_of_the_week = 'Friday' THEN 6
							 		WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
								 3),
		dow_table4 AS (SELECT location,
								day_of_the_week,
								dow_total_cases,
								SUM(dow_total_cases) OVER(PARTITION BY location ORDER BY location) total_cases
						FROM dow_table3)
SELECT location,
		day_of_the_week,
		dow_total_cases,
		round(((dow_total_cases/total_cases) * 100), 2) Percent_of_total_cases
FROM dow_table4


# Overall total deaths

# Country 

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_deaths,
				   			location
					FROM coviddeath
				    WHERE location NOT IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe',
					  			           'World',
					  				       'International',
					   				       'European Union',
					   				       'Low income',
					   				       'Lower middle income',
					   				       'Upper middle income',
					   				       'High income')),
		dow_table2 AS (SELECT location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_deaths
								FROM dow_table)
SELECT location,
		day_of_the_week,
		SUM(new_deaths) dow_total_deaths
FROM dow_table2
GROUP BY 1,2
ORDER BY 1,
		CASE WHEN day_of_the_week = 'Sunday' THEN 1
			 WHEN day_of_the_week = 'Monday' THEN 2
			 WHEN day_of_the_week = 'Tuesday' THEN 3
			 WHEN day_of_the_week = 'Wednesday' THEN 4
			 WHEN day_of_the_week = 'Thursday' THEN 5
			 WHEN day_of_the_week = 'Friday' THEN 6
			 WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
		3

# Continent

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_deaths,
				   			location
					FROM coviddeath
				    WHERE location IN ('Africa',
				       					'South America',
				       					'North America',
				       					'Oceania',
				     					'Asia',
				       					'Europe')),
		dow_table2 AS (SELECT location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_deaths
								FROM dow_table)
SELECT location,
		day_of_the_week,
		SUM(new_deaths) dow_total_deaths
FROM dow_table2
GROUP BY 1,2
ORDER BY 1,
		CASE WHEN day_of_the_week = 'Sunday' THEN 1
			 WHEN day_of_the_week = 'Monday' THEN 2
			 WHEN day_of_the_week = 'Tuesday' THEN 3
			 WHEN day_of_the_week = 'Wednesday' THEN 4
			 WHEN day_of_the_week = 'Thursday' THEN 5
			 WHEN day_of_the_week = 'Friday' THEN 6
			 WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
		3

# World

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_deaths,
				   			location
					FROM coviddeath
				    WHERE location IN ('World')),
		dow_table2 AS (SELECT location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_deaths
								FROM dow_table)
SELECT location,
		day_of_the_week,
		SUM(new_deaths) dow_total_deaths
FROM dow_table2
GROUP BY 1,2
ORDER BY 1,
		CASE WHEN day_of_the_week = 'Sunday' THEN 1
			 WHEN day_of_the_week = 'Monday' THEN 2
			 WHEN day_of_the_week = 'Tuesday' THEN 3
			 WHEN day_of_the_week = 'Wednesday' THEN 4
			 WHEN day_of_the_week = 'Thursday' THEN 5
			 WHEN day_of_the_week = 'Friday' THEN 6
			 WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
		3

# Percentage of total death

# Country 

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_deaths,
				   			continent,
				   			location
					FROM coviddeath
				    WHERE location NOT IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe',
					  			           'World',
					  				       'International',
					   				       'European Union',
					   				       'Low income',
					   				       'Lower middle income',
					   				       'Upper middle income',
					   				       'High income')),
		dow_table2 AS (SELECT 	continent,
					   			location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_deaths
								FROM dow_table),
		dow_table3 AS (SELECT 	continent,
					   			location,
								day_of_the_week,
								SUM(new_deaths) dow_total_deaths
						FROM dow_table2
						GROUP BY 1,2,3
						ORDER BY 1,
					   			 2,
								CASE WHEN day_of_the_week = 'Sunday' THEN 1
					   				 WHEN day_of_the_week = 'Monday' THEN 2
					 				 WHEN day_of_the_week = 'Tuesday' THEN 3
					 				 WHEN day_of_the_week = 'Wednesday' THEN 4
									 WHEN day_of_the_week = 'Thursday' THEN 5
									 WHEN day_of_the_week = 'Friday' THEN 6
									 WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
								4),
		dow_table4 AS (SELECT 	continent,
					   			location,
								day_of_the_week,
								dow_total_deaths,
								SUM(dow_total_deaths) OVER(PARTITION BY location ORDER BY location) total_deaths
						FROM dow_table3)
SELECT 	continent,
		location,
		day_of_the_week,
		dow_total_deaths,
		round(((dow_total_deaths/total_deaths) * 100), 2) Percent_of_total_deaths
FROM dow_table4

# Continent

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_deaths,
				   			location
					FROM coviddeath
				    WHERE location IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe')),
		dow_table2 AS (SELECT location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_deaths
								FROM dow_table),
		dow_table3 AS (SELECT location,
								day_of_the_week,
								SUM(new_deaths) dow_total_deaths
						FROM dow_table2
						GROUP BY 1,2
						ORDER BY 1,
								CASE WHEN day_of_the_week = 'Sunday' THEN 1
					   				 WHEN day_of_the_week = 'Monday' THEN 2
					 				 WHEN day_of_the_week = 'Tuesday' THEN 3
					 				 WHEN day_of_the_week = 'Wednesday' THEN 4
									 WHEN day_of_the_week = 'Thursday' THEN 5
									 WHEN day_of_the_week = 'Friday' THEN 6
									 WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
								3),
		dow_table4 AS (SELECT location,
								day_of_the_week,
								dow_total_deaths,
								SUM(dow_total_deaths) OVER(PARTITION BY location ORDER BY location) total_deaths
						FROM dow_table3)
SELECT location,
		day_of_the_week,
		dow_total_deaths,
		round(((dow_total_deaths/total_deaths) * 100), 2) Percent_of_total_deaths
FROM dow_table4

# World

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_deaths,
				   			location
					FROM coviddeath
				    WHERE location IN ('World')),
		dow_table2 AS (SELECT location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_deaths
								FROM dow_table),
		dow_table3 AS (SELECT location,
								day_of_the_week,
								SUM(new_deaths) dow_total_deaths
						FROM dow_table2
						GROUP BY 1,2
						ORDER BY 1,
								CASE WHEN day_of_the_week = 'Sunday' THEN 1
					   				 WHEN day_of_the_week = 'Monday' THEN 2
					 				 WHEN day_of_the_week = 'Tuesday' THEN 3
					 				 WHEN day_of_the_week = 'Wednesday' THEN 4
									 WHEN day_of_the_week = 'Thursday' THEN 5
									 WHEN day_of_the_week = 'Friday' THEN 6
									 WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
								3),
		dow_table4 AS (SELECT location,
								day_of_the_week,
								dow_total_deaths,
								SUM(dow_total_deaths) OVER(PARTITION BY location ORDER BY location) total_deaths
						FROM dow_table3)
SELECT location,
		day_of_the_week,
		dow_total_deaths,
		round(((dow_total_deaths/total_deaths) * 100), 2) Percent_of_total_deaths
FROM dow_table4

-- Steps Overview 
-- We solved this question with 3 tables (2 tempos and 1 final).
-- We extracted a new column (day of the week) from date column
-- Transforming the day column values from numeric to text representation
-- Summing new_cases/new_deaths column by day of the week
-- Percentage of total cases/deaths per each of the week 
-- Granularized it by World, Continent, and Country



# Question 2
# On which day of the week did we have the highest number of;
# - Death
# - Covid cases
# - Do the analysis by country, continent, and world
# - Hint: Balance the data before analyzing

# Query Solution

# Death

# Country


WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_deaths,
				   			continent,
				   			location
					FROM coviddeath
				    WHERE location NOT IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe',
					  			           'World',
					  				       'International',
					   				       'European Union',
					   				       'Low income',
					   				       'Lower middle income',
					   				       'Upper middle income',
					   				       'High income')),
		dow_table2 AS (SELECT 	continent,
					   			location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_deaths
								FROM dow_table),
		dow_table3 AS (SELECT 	continent,
					   			location,
								day_of_the_week,
								SUM(new_deaths) dow_total_deaths
						FROM dow_table2
						GROUP BY 1,2,3
						ORDER BY 1,
					   			 2,
								 CASE WHEN day_of_the_week = 'Sunday' THEN 1
									  WHEN day_of_the_week = 'Monday' THEN 2
									  WHEN day_of_the_week = 'Tuesday' THEN 3
									  WHEN day_of_the_week = 'Wednesday' THEN 4
									  WHEN day_of_the_week = 'Thursday' THEN 5
									  WHEN day_of_the_week = 'Friday' THEN 6
									  WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
																4),
			max_deaths_table AS (SELECT continent,
								 		location,
										MAX(dow_total_deaths) day_with_highest_deaths
									FROM dow_table3 
									GROUP BY 1,2
									ORDER BY 1,2)
SELECT distinct (md.continent),
		md.location,
		dt.day_of_the_week,
		md.day_with_highest_deaths
FROM dow_table3 dt
JOIN max_deaths_table md
ON md.location = dt.location
AND md.day_with_highest_deaths = dt.dow_total_deaths
ORDER BY 1,2


# Deaths

# Continent 


WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_deaths,
				   			location
					FROM coviddeath
				    WHERE location IN ('Africa',
				       					'South America',
				       					'North America',
				       					'Oceania',
				     					'Asia',
				       					'Europe')),
		dow_table2 AS (SELECT location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_deaths
								FROM dow_table),
		dow_table3 AS (SELECT location,
								day_of_the_week,
								SUM(new_deaths) dow_total_deaths
						FROM dow_table2
						GROUP BY 1,2
						ORDER BY 1,
								 CASE WHEN day_of_the_week = 'Sunday' THEN 1
									  WHEN day_of_the_week = 'Monday' THEN 2
									  WHEN day_of_the_week = 'Tuesday' THEN 3
									  WHEN day_of_the_week = 'Wednesday' THEN 4
									  WHEN day_of_the_week = 'Thursday' THEN 5
									  WHEN day_of_the_week = 'Friday' THEN 6
									  WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
																3),
			max_deaths_table AS (SELECT location,
										MAX(dow_total_deaths) day_with_highest_deaths
									FROM dow_table3 
									GROUP BY 1
									ORDER BY 1)
SELECT distinct (md.location),
		dt.day_of_the_week,
		md.day_with_highest_deaths
FROM dow_table3 dt
JOIN max_deaths_table md
ON md.location = dt.location
AND md.day_with_highest_deaths = dt.dow_total_deaths
ORDER BY 1


# Deaths

# World

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_deaths,
				   			location
					FROM coviddeath
				    WHERE location IN ('World')),
		dow_table2 AS (SELECT location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_deaths
								FROM dow_table),
		dow_table3 AS (SELECT location,
								day_of_the_week,
								SUM(new_deaths) dow_total_deaths
						FROM dow_table2
						GROUP BY 1,2
						ORDER BY 1,
								 CASE WHEN day_of_the_week = 'Sunday' THEN 1
									  WHEN day_of_the_week = 'Monday' THEN 2
									  WHEN day_of_the_week = 'Tuesday' THEN 3
									  WHEN day_of_the_week = 'Wednesday' THEN 4
									  WHEN day_of_the_week = 'Thursday' THEN 5
									  WHEN day_of_the_week = 'Friday' THEN 6
									  WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
																3)
SELECT location,
		day_of_the_week,
		dow_total_deaths
FROM dow_table3
ORDER BY 3 DESC
LIMIT 1

# Cases

# Country

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_cases,
				   			continent,
				   			location
					FROM coviddeath
				    WHERE location NOT IN ('Africa',
				       				'South America',
				       				'North America',
				       				'Oceania',
				     				'Asia',
				       				'Europe',
					  			    'World',
					  				'International',
					   				'European Union',
					   				'Low income',
					   				'Lower middle income',
					   				'Upper middle income',
					   				'High income')),
		dow_table2 AS (SELECT 	continent,
					   			location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_cases
								FROM dow_table),
		dow_table3 AS (SELECT 	continent,
					   			location,
								day_of_the_week,
								SUM(new_cases) dow_total_cases
						FROM dow_table2
						GROUP BY 1,2,3
						ORDER BY 1,
					   			 2,
								 CASE WHEN day_of_the_week = 'Sunday' THEN 1
									  WHEN day_of_the_week = 'Monday' THEN 2
									  WHEN day_of_the_week = 'Tuesday' THEN 3
									  WHEN day_of_the_week = 'Wednesday' THEN 4
									  WHEN day_of_the_week = 'Thursday' THEN 5
									  WHEN day_of_the_week = 'Friday' THEN 6
									  WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
																4),
			max_cases_table AS (SELECT continent,
										location,
										MAX(dow_total_cases) day_with_highest_cases
									FROM dow_table3 
									GROUP BY 1,2
									ORDER BY 1,2)
SELECT distinct (md.continent),
		md.location,
		dt.day_of_the_week,
		md.day_with_highest_cases
FROM dow_table3 dt
JOIN max_cases_table md
ON md.location = dt.location
AND md.day_with_highest_cases = dt.dow_total_cases
ORDER BY 1

# Cases

# Continent

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_cases,
				   			location
					FROM coviddeath
				    WHERE location IN ('Africa',
				       					'South America',
				       					'North America',
				       					'Oceania',
				     					'Asia',
				       					'Europe')),
		dow_table2 AS (SELECT location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_cases
								FROM dow_table),
		dow_table3 AS (SELECT location,
								day_of_the_week,
								SUM(new_cases) dow_total_cases
						FROM dow_table2
						GROUP BY 1,2
						ORDER BY 1,
								 CASE WHEN day_of_the_week = 'Sunday' THEN 1
									  WHEN day_of_the_week = 'Monday' THEN 2
									  WHEN day_of_the_week = 'Tuesday' THEN 3
									  WHEN day_of_the_week = 'Wednesday' THEN 4
									  WHEN day_of_the_week = 'Thursday' THEN 5
									  WHEN day_of_the_week = 'Friday' THEN 6
									  WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
																3),
			max_cases_table AS (SELECT location,
										MAX(dow_total_cases) day_with_highest_cases
									FROM dow_table3 
									GROUP BY 1
									ORDER BY 1)
SELECT distinct (md.location),
		dt.day_of_the_week,
		md.day_with_highest_cases
FROM dow_table3 dt
JOIN max_cases_table md
ON md.location = dt.location
AND md.day_with_highest_cases = dt.dow_total_cases
ORDER BY 1

# Cases 

# World

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_cases,
				   			location
					FROM coviddeath
				    WHERE location IN ('World')),
		dow_table2 AS (SELECT location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_cases
								FROM dow_table),
		dow_table3 AS (SELECT location,
								day_of_the_week,
								SUM(new_cases) dow_total_cases
						FROM dow_table2
						GROUP BY 1,2
						ORDER BY 1,
								CASE WHEN day_of_the_week = 'Sunday' THEN 1
					 				 WHEN day_of_the_week = 'Monday' THEN 2
									 WHEN day_of_the_week = 'Tuesday' THEN 3
									 WHEN day_of_the_week = 'Wednesday' THEN 4
									 WHEN day_of_the_week = 'Thursday' THEN 5
									 WHEN day_of_the_week = 'Friday' THEN 6
									 WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
									3)
SELECT location,
		day_of_the_week,
		dow_total_cases
FROM dow_table3
ORDER BY 3 DESC
LIMIT 1

-- Steps Overview 
-- We solved this question with 5 tables (4 tempos and 1 final) aside World with 4 tables.
-- We extracted a new column (day of the week) from date column
-- Transforming the day column values from numeric to text representation
-- Summing new_cases/new_deaths column by day of the week
-- Extracting highest total deaths by day of the week 
-- Granularized it by World, Continent, and Country


# Question 3
# On which day of the week did we have the least number of;
# - Deaths
# - Covid cases
# - Do the analysis by country, continent, and world
# - Hint: Balance the data before analyzing

# Query Solution

# Deaths

# Country

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_deaths,
				   			continent,
				   			location
					FROM coviddeath
				    WHERE location NOT IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe',
					  			           'World',
					  				       'International',
					   				       'European Union',
					   				       'Low income',
					   				       'Lower middle income',
					   				       'Upper middle income',
					   				       'High income')),
		dow_table2 AS (SELECT 	continent,
					   			location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_deaths
								FROM dow_table),
		dow_table3 AS (SELECT 	continent,
					   			location,
								day_of_the_week,
								SUM(new_deaths) dow_total_deaths
						FROM dow_table2
						GROUP BY 1,2,3
						ORDER BY 1,
					   			 2,
								 CASE WHEN day_of_the_week = 'Sunday' THEN 1
									  WHEN day_of_the_week = 'Monday' THEN 2
									  WHEN day_of_the_week = 'Tuesday' THEN 3
									  WHEN day_of_the_week = 'Wednesday' THEN 4
									  WHEN day_of_the_week = 'Thursday' THEN 5
									  WHEN day_of_the_week = 'Friday' THEN 6
									  WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
																4),
			max_deaths_table AS (SELECT continent,
								 		location,
										MIN(dow_total_deaths) day_with_lowest_deaths
									FROM dow_table3 
									GROUP BY 1,2
									ORDER BY 1,2)
SELECT distinct (md.continent),
		md.location,
		dt.day_of_the_week,
		md.day_with_lowest_deaths
FROM dow_table3 dt
JOIN max_deaths_table md
ON md.location = dt.location
AND md.day_with_lowest_deaths = dt.dow_total_deaths
ORDER BY 1


# Death 

# Continent

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_deaths,
				   			location
					FROM coviddeath
				    WHERE location IN ('Africa',
				       					'South America',
				       					'North America',
				       					'Oceania',
				     					'Asia',
				       					'Europe')),
		dow_table2 AS (SELECT location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_deaths
								FROM dow_table),
		dow_table3 AS (SELECT location,
								day_of_the_week,
								SUM(new_deaths) dow_total_deaths
						FROM dow_table2
						GROUP BY 1,2
						ORDER BY 1,
								 CASE WHEN day_of_the_week = 'Sunday' THEN 1
									  WHEN day_of_the_week = 'Monday' THEN 2
									  WHEN day_of_the_week = 'Tuesday' THEN 3
									  WHEN day_of_the_week = 'Wednesday' THEN 4
									  WHEN day_of_the_week = 'Thursday' THEN 5
									  WHEN day_of_the_week = 'Friday' THEN 6
									  WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
																3),
			max_deaths_table AS (SELECT location,
										MIN(dow_total_deaths) day_with_lowest_deaths
									FROM dow_table3 
									GROUP BY 1
									ORDER BY 1)
SELECT distinct (md.location),
		dt.day_of_the_week,
		md.day_with_lowest_deaths
FROM dow_table3 dt
JOIN max_deaths_table md
ON md.location = dt.location
AND md.day_with_lowest_deaths = dt.dow_total_deaths
ORDER BY 1

# Death

# World

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_deaths,
				   			location
					FROM coviddeath
				    WHERE location IN ('World')),
		dow_table2 AS (SELECT location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_deaths
								FROM dow_table),
		dow_table3 AS (SELECT location,
								day_of_the_week,
								SUM(new_deaths) dow_total_deaths
						FROM dow_table2
						GROUP BY 1,2
						ORDER BY 1,
								 CASE WHEN day_of_the_week = 'Sunday' THEN 1
									  WHEN day_of_the_week = 'Monday' THEN 2
									  WHEN day_of_the_week = 'Tuesday' THEN 3
									  WHEN day_of_the_week = 'Wednesday' THEN 4
									  WHEN day_of_the_week = 'Thursday' THEN 5
									  WHEN day_of_the_week = 'Friday' THEN 6
									  WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
																3)
SELECT location,
		day_of_the_week,
		dow_total_deaths
FROM dow_table3
ORDER BY 3
LIMIT 1

# Cases

# Country

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_cases,
				   			continent,
				   			location
					FROM coviddeath
				    WHERE location NOT IN ('Africa',
				       				'South America',
				       				'North America',
				       				'Oceania',
				     				'Asia',
				       				'Europe',
					  			    'World',
					  				'International',
					   				'European Union',
					   				'Low income',
					   				'Lower middle income',
					   				'Upper middle income',
					   				'High income')),
		dow_table2 AS (SELECT 	continent,
					   			location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_cases
								FROM dow_table),
		dow_table3 AS (SELECT 	continent,
					   			location,
								day_of_the_week,
								SUM(new_cases) dow_total_cases
						FROM dow_table2
						GROUP BY 1,2,3
						ORDER BY 1,
					   			 2,
								 CASE WHEN day_of_the_week = 'Sunday' THEN 1
									  WHEN day_of_the_week = 'Monday' THEN 2
									  WHEN day_of_the_week = 'Tuesday' THEN 3
									  WHEN day_of_the_week = 'Wednesday' THEN 4
									  WHEN day_of_the_week = 'Thursday' THEN 5
									  WHEN day_of_the_week = 'Friday' THEN 6
									  WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
																4),
			max_cases_table AS (SELECT continent,
										location,
										MIN(dow_total_cases) day_with_lowest_cases
									FROM dow_table3 
									GROUP BY 1,2
									ORDER BY 1,2)
SELECT distinct (md.continent),
		md.location,
		dt.day_of_the_week,
		md.day_with_lowest_cases
FROM dow_table3 dt
JOIN max_cases_table md
ON md.location = dt.location
AND md.day_with_lowest_cases = dt.dow_total_cases
ORDER BY 1

# Cases 

# Continent

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_cases,
				   			location
					FROM coviddeath
				    WHERE location IN ('Africa',
				       					'South America',
				       					'North America',
				       					'Oceania',
				     					'Asia',
				       					'Europe')),
		dow_table2 AS (SELECT location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_cases
								FROM dow_table),
		dow_table3 AS (SELECT location,
								day_of_the_week,
								SUM(new_cases) dow_total_cases
						FROM dow_table2
						GROUP BY 1,2
						ORDER BY 1,
								 CASE WHEN day_of_the_week = 'Sunday' THEN 1
									  WHEN day_of_the_week = 'Monday' THEN 2
									  WHEN day_of_the_week = 'Tuesday' THEN 3
									  WHEN day_of_the_week = 'Wednesday' THEN 4
									  WHEN day_of_the_week = 'Thursday' THEN 5
									  WHEN day_of_the_week = 'Friday' THEN 6
									  WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
																3),
			max_cases_table AS (SELECT location,
										MIN(dow_total_cases) day_with_lowest_cases
									FROM dow_table3 
									GROUP BY 1
									ORDER BY 1)
SELECT distinct (md.location),
		dt.day_of_the_week,
		md.day_with_lowest_cases
FROM dow_table3 dt
JOIN max_cases_table md
ON md.location = dt.location
AND md.day_with_lowest_cases = dt.dow_total_cases
ORDER BY 1

# Cases

# World

WITH dow_table AS (SELECT DATE_PART('isodow', date) - 1 AS day,
							new_cases,
				   			location
					FROM coviddeath
				    WHERE location IN ('World')),
		dow_table2 AS (SELECT location,
								CASE WHEN day = 0 THEN 'Sunday'
									WHEN day = 1 THEN 'Monday'
									WHEN day = 2 THEN 'Tuesday'
									WHEN day = 3 THEN 'Wednesday'
									WHEN day = 4 THEN 'Thursday'
									WHEN day = 5 THEN 'Friday'
									WHEN day = 6 THEN 'Saturday' END day_of_the_week,
									new_cases
								FROM dow_table),
		dow_table3 AS (SELECT location,
								day_of_the_week,
								SUM(new_cases) dow_total_cases
						FROM dow_table2
						GROUP BY 1,2
						ORDER BY 1,
								CASE WHEN day_of_the_week = 'Sunday' THEN 1
					 				 WHEN day_of_the_week = 'Monday' THEN 2
									 WHEN day_of_the_week = 'Tuesday' THEN 3
									 WHEN day_of_the_week = 'Wednesday' THEN 4
									 WHEN day_of_the_week = 'Thursday' THEN 5
									 WHEN day_of_the_week = 'Friday' THEN 6
									 WHEN day_of_the_week = 'Saturday' THEN 7 END ASC,
									3)
SELECT location,
		day_of_the_week,
		dow_total_cases
FROM dow_table3
ORDER BY 3 
LIMIT 1

-- Steps Overview 
-- We solved this question with 5 tables (4 tempos and 1 final) aside World with 4 tables.
-- We extracted a new column (day of the week) from date column
-- Transforming the day column values from numeric to text representation
-- Summing new_cases/new_deaths column by day of the week
-- Extracting lowest total deaths by day of the week 
-- Granularized it by World, Continent, and Country


# Question 4
# Find;
# 	- overall total cases for each month of the year  
# 	- overall total deaths for each month of the year
# 	- percentage of the total cases/total deaths for each month of the year 
# 	- Do the analysis by country, continent, and world

# Cases 

# Country

WITH moy_table AS (SELECT 	continent,
				   			location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_cases,
				   			CASE WHEN new_cases IS NULL THEN 0
				   				 WHEN new_cases IS NOT NULL THEN new_cases END new_cases_updated
					FROM coviddeath
				    WHERE location NOT IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe',
					  			           'World',
					  				       'International',
					   				       'European Union',
					   				       'Low income',
					   				       'Lower middle income',
					   				       'Upper middle income',
					   				       'High income') AND date BETWEEN '2020-03-01' AND '2022-02-28')
SELECT 	continent,
		location,
		month,
		SUM(new_cases_updated) moy_total_cases
FROM moy_table
GROUP BY 1,2,3
ORDER BY 1,2,
		 CASE WHEN month = 'January' THEN 1
			  WHEN month = 'February' THEN 2
			  WHEN month = 'March' THEN 3
			  WHEN month = 'April' THEN 4
			  WHEN month = 'May' THEN 5
			  WHEN month = 'June' THEN 6
			  WHEN month = 'July' THEN 7
			  WHEN month = 'August' THEN 8
			  WHEN month = 'September' THEN 9
			  WHEN month = 'October' THEN 10
			  WHEN month = 'November' THEN 11
			  WHEN month = 'December' THEN 12 END ASC

# Continent

WITH moy_table AS (SELECT 	location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_cases,
				   			CASE WHEN new_cases IS NULL THEN 0
				   				 WHEN new_cases IS NOT NULL THEN new_cases END new_cases_updated
					FROM coviddeath
				    WHERE location IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe') AND date BETWEEN '2020-03-01' AND '2022-02-28')
SELECT location,
		month,
		SUM(new_cases_updated) moy_total_cases
FROM moy_table
GROUP BY 1,2
ORDER BY 1,
		 CASE WHEN month = 'January' THEN 1
			  WHEN month = 'February' THEN 2
			  WHEN month = 'March' THEN 3
			  WHEN month = 'April' THEN 4
			  WHEN month = 'May' THEN 5
			  WHEN month = 'June' THEN 6
			  WHEN month = 'July' THEN 7
			  WHEN month = 'August' THEN 8
			  WHEN month = 'September' THEN 9
			  WHEN month = 'October' THEN 10
			  WHEN month = 'November' THEN 11
			  WHEN month = 'December' THEN 12 END ASC

# World

WITH moy_table AS (SELECT 	location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_cases,
				   			CASE WHEN new_cases IS NULL THEN 0
				   				 WHEN new_cases IS NOT NULL THEN new_cases END new_cases_updated
					FROM coviddeath
				    WHERE location IN ('World') AND date BETWEEN '2020-03-01' AND '2022-02-28')
SELECT location,
		month,
		SUM(new_cases_updated) moy_total_cases
FROM moy_table
GROUP BY 1,2
ORDER BY 1,
		 CASE WHEN month = 'January' THEN 1
			  WHEN month = 'February' THEN 2
			  WHEN month = 'March' THEN 3
			  WHEN month = 'April' THEN 4
			  WHEN month = 'May' THEN 5
			  WHEN month = 'June' THEN 6
			  WHEN month = 'July' THEN 7
			  WHEN month = 'August' THEN 8
			  WHEN month = 'September' THEN 9
			  WHEN month = 'October' THEN 10
			  WHEN month = 'November' THEN 11
			  WHEN month = 'December' THEN 12 END ASC

# Percentage of total cases 

# Country 

WITH moy_table AS (SELECT 	continent,
				   			location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_cases,
				   			CASE WHEN new_cases IS NULL THEN 0
				   				 WHEN new_cases IS NOT NULL THEN new_cases END new_cases_updated
					FROM coviddeath
				    WHERE location NOT IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe',
					  			           'World',
					  				       'International',
					   				       'European Union',
					   				       'Low income',
					   				       'Lower middle income',
					   				       'Upper middle income',
					   				       'High income') AND date BETWEEN '2020-03-01' AND '2022-02-28'),
		moy_table2 AS (SELECT continent,
					   			location,
								month,
								SUM(new_cases_updated) moy_total_cases
						FROM moy_table
						GROUP BY 1,2,3
						ORDER BY 1,
					   			 2,
				 				CASE WHEN month = 'January' THEN 1
					  				 WHEN month = 'February' THEN 2
					  				 WHEN month = 'March' THEN 3
					  				 WHEN month = 'April' THEN 4
					  				 WHEN month = 'May' THEN 5
					 				 WHEN month = 'June' THEN 6
								     WHEN month = 'July' THEN 7
					 				 WHEN month = 'August' THEN 8
					 				 WHEN month = 'September' THEN 9
					 				 WHEN month = 'October' THEN 10
					 				 WHEN month = 'November' THEN 11
					  			  	 WHEN month = 'December' THEN 12 END ASC),
		moy_table3 AS (SELECT 	continent,
					   			location,
								month,
								moy_total_cases,
								SUM(moy_total_cases) OVER(PARTITION BY location ORDER BY location) total_cases
						FROM moy_table2)
SELECT 	continent,
		location,
		month,
		moy_total_cases,
		round(((moy_total_cases/total_cases) * 100), 2) Percent_of_total_cases
FROM moy_table3
WHERE moy_total_cases != 0 AND total_cases != 0



# For Continent

WITH moy_table AS (SELECT 	location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_cases,
				   			CASE WHEN new_cases IS NULL THEN 0
				   				 WHEN new_cases IS NOT NULL THEN new_cases END new_cases_updated
					FROM coviddeath
				    WHERE location IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe',
					  			           'World') AND date BETWEEN '2020-03-01' AND '2022-02-28'),
		moy_table2 AS (SELECT location,
								month,
								SUM(new_cases_updated) moy_total_cases
						FROM moy_table
						GROUP BY 1,2
						ORDER BY 1,
				 				CASE WHEN month = 'January' THEN 1
					  				 WHEN month = 'February' THEN 2
					  				 WHEN month = 'March' THEN 3
					  				 WHEN month = 'April' THEN 4
					  				 WHEN month = 'May' THEN 5
					 				 WHEN month = 'June' THEN 6
								     WHEN month = 'July' THEN 7
					 				 WHEN month = 'August' THEN 8
					 				 WHEN month = 'September' THEN 9
					 				 WHEN month = 'October' THEN 10
					 				 WHEN month = 'November' THEN 11
					  			  	 WHEN month = 'December' THEN 12 END ASC),
		moy_table3 AS (SELECT location,
								month,
								moy_total_cases,
								SUM(moy_total_cases) OVER(PARTITION BY location ORDER BY location) total_cases
						FROM moy_table2)
SELECT location,
		month,
		moy_total_cases,
		round(((moy_total_cases/total_cases) * 100), 2) Percent_of_total_cases
FROM moy_table3
WHERE moy_total_cases != 0 AND total_cases != 0

# For World

WITH moy_table AS (SELECT 	location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_cases,
				   			CASE WHEN new_cases IS NULL THEN 0
				   				 WHEN new_cases IS NOT NULL THEN new_cases END new_cases_updated
					FROM coviddeath
				    WHERE location IN ('World') AND date BETWEEN '2020-03-01' AND '2022-02-28'),
		moy_table2 AS (SELECT location,
								month,
								SUM(new_cases_updated) moy_total_cases
						FROM moy_table
						GROUP BY 1,2
						ORDER BY 1,
				 				CASE WHEN month = 'January' THEN 1
					  				 WHEN month = 'February' THEN 2
					  				 WHEN month = 'March' THEN 3
					  				 WHEN month = 'April' THEN 4
					  				 WHEN month = 'May' THEN 5
					 				 WHEN month = 'June' THEN 6
								     WHEN month = 'July' THEN 7
					 				 WHEN month = 'August' THEN 8
					 				 WHEN month = 'September' THEN 9
					 				 WHEN month = 'October' THEN 10
					 				 WHEN month = 'November' THEN 11
					  			  	 WHEN month = 'December' THEN 12 END ASC),
		moy_table3 AS (SELECT location,
								month,
								moy_total_cases,
								SUM(moy_total_cases) OVER(PARTITION BY location ORDER BY location) total_cases
						FROM moy_table2)
SELECT location,
		month,
		moy_total_cases,
		round(((moy_total_cases/total_cases) * 100), 2) Percent_of_total_cases
FROM moy_table3
WHERE moy_total_cases != 0 AND total_cases != 0

# Deaths

# Country

WITH moy_table AS (SELECT 	continent,
				   			location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_deaths,
				   			CASE WHEN new_deaths IS NULL THEN 0
				   				 WHEN new_deaths IS NOT NULL THEN new_deaths END new_deaths_updated
					FROM coviddeath
				    WHERE location NOT IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe',
					  			           'World',
					  				       'International',
					   				       'European Union',
					   				       'Low income',
					   				       'Lower middle income',
					   				       'Upper middle income',
					   				       'High income') AND date BETWEEN '2020-03-01' AND '2022-02-28')
SELECT continent,
		location,
		month,
		SUM(new_deaths_updated) moy_total_deaths
FROM moy_table
GROUP BY 1,2,3
ORDER BY 1,2,
		CASE WHEN month = 'January' THEN 1
			 WHEN month = 'February' THEN 2
			 WHEN month = 'March' THEN 3
			 WHEN month = 'April' THEN 4
			 WHEN month = 'May' THEN 5
			 WHEN month = 'June' THEN 6
			 WHEN month = 'July' THEN 7
			 WHEN month = 'August' THEN 8
			 WHEN month = 'September' THEN 9
			 WHEN month = 'October' THEN 10
			 WHEN month = 'November' THEN 11
			 WHEN month = 'December' THEN 12 END ASC

# Continent

WITH moy_table AS (SELECT 	location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_deaths,
				   			CASE WHEN new_deaths IS NULL THEN 0
				   				 WHEN new_deaths IS NOT NULL THEN new_deaths END new_deaths_updated
					FROM coviddeath
				    WHERE location IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe') AND date BETWEEN '2020-03-01' AND '2022-02-28')
SELECT location,
		month,
		SUM(new_deaths_updated) moy_total_deaths
FROM moy_table
GROUP BY 1,2
ORDER BY 1,
		CASE WHEN month = 'January' THEN 1
			 WHEN month = 'February' THEN 2
			 WHEN month = 'March' THEN 3
			 WHEN month = 'April' THEN 4
			 WHEN month = 'May' THEN 5
			 WHEN month = 'June' THEN 6
			 WHEN month = 'July' THEN 7
			 WHEN month = 'August' THEN 8
			 WHEN month = 'September' THEN 9
			 WHEN month = 'October' THEN 10
			 WHEN month = 'November' THEN 11
			 WHEN month = 'December' THEN 12 END ASC

# World

WITH moy_table AS (SELECT 	location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_deaths,
				   			CASE WHEN new_deaths IS NULL THEN 0
				   				 WHEN new_deaths IS NOT NULL THEN new_deaths END new_deaths_updated
					FROM coviddeath
				    WHERE location IN ('World') AND date BETWEEN '2020-03-01' AND '2022-02-28')
SELECT location,
		month,
		SUM(new_deaths_updated) moy_total_deaths
FROM moy_table
GROUP BY 1,2
ORDER BY 1,
		CASE WHEN month = 'January' THEN 1
			 WHEN month = 'February' THEN 2
			 WHEN month = 'March' THEN 3
			 WHEN month = 'April' THEN 4
			 WHEN month = 'May' THEN 5
			 WHEN month = 'June' THEN 6
			 WHEN month = 'July' THEN 7
			 WHEN month = 'August' THEN 8
			 WHEN month = 'September' THEN 9
			 WHEN month = 'October' THEN 10
			 WHEN month = 'November' THEN 11
			 WHEN month = 'December' THEN 12 END ASC

# Percentage of total deaths 

# Country 

WITH moy_table AS (SELECT 	continent,
				   			location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_deaths,
				   			CASE WHEN new_deaths IS NULL THEN 0
				   				 WHEN new_deaths IS NOT NULL THEN new_deaths END new_deaths_updated
					FROM coviddeath
				    WHERE location NOT IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe',
					  			           'World',
					  				       'International',
					   				       'European Union',
					   				       'Low income',
					   				       'Lower middle income',
					   				       'Upper middle income',
					   				       'High income') AND date BETWEEN '2020-03-01' AND '2022-02-28'),
		moy_table2 AS (SELECT 	continent,
					   			location,
								month,
								SUM(new_deaths_updated) moy_total_deaths
						FROM moy_table
						GROUP BY 1,2,3
						ORDER BY 1,
					   			 2,
								CASE WHEN month = 'January' THEN 1
									 WHEN month = 'February' THEN 2
									 WHEN month = 'March' THEN 3
									 WHEN month = 'April' THEN 4
									 WHEN month = 'May' THEN 5
									 WHEN month = 'June' THEN 6
									 WHEN month = 'July' THEN 7
									 WHEN month = 'August' THEN 8
									 WHEN month = 'September' THEN 9
									 WHEN month = 'October' THEN 10
									 WHEN month = 'November' THEN 11
									 WHEN month = 'December' THEN 12 END ASC),
		moy_table3 AS (SELECT 	continent,
					   			location,
								month,
								moy_total_deaths,
								SUM(moy_total_deaths) OVER(PARTITION BY location ORDER BY location) total_deaths
						FROM moy_table2)
SELECT 	continent,
		location,
		month,
		moy_total_deaths,
		round(((moy_total_deaths/total_deaths) * 100), 2) Percent_of_total_deaths
FROM moy_table3
WHERE moy_total_deaths != 0 AND total_deaths != 0


# Continent

WITH moy_table AS (SELECT 	location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_deaths,
				   			CASE WHEN new_deaths IS NULL THEN 0
				   				 WHEN new_deaths IS NOT NULL THEN new_deaths END new_deaths_updated
					FROM coviddeath
				    WHERE location IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe') AND date BETWEEN '2020-03-01' AND '2022-02-28'),
		moy_table2 AS (SELECT location,
								month,
								SUM(new_deaths_updated) moy_total_deaths
						FROM moy_table
						GROUP BY 1,2
						ORDER BY 1,
								CASE WHEN month = 'January' THEN 1
									 WHEN month = 'February' THEN 2
									 WHEN month = 'March' THEN 3
									 WHEN month = 'April' THEN 4
									 WHEN month = 'May' THEN 5
									 WHEN month = 'June' THEN 6
									 WHEN month = 'July' THEN 7
									 WHEN month = 'August' THEN 8
									 WHEN month = 'September' THEN 9
									 WHEN month = 'October' THEN 10
									 WHEN month = 'November' THEN 11
									 WHEN month = 'December' THEN 12 END ASC),
		moy_table3 AS (SELECT location,
								month,
								moy_total_deaths,
								SUM(moy_total_deaths) OVER(PARTITION BY location ORDER BY location) total_deaths
						FROM moy_table2)
SELECT location,
		month,
		moy_total_deaths,
		round(((moy_total_deaths/total_deaths) * 100), 2) Percent_of_total_deaths
FROM moy_table3
WHERE moy_total_deaths != 0 AND total_deaths != 0

# World

WITH moy_table AS (SELECT 	location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_deaths,
				   			CASE WHEN new_deaths IS NULL THEN 0
				   				 WHEN new_deaths IS NOT NULL THEN new_deaths END new_deaths_updated
					FROM coviddeath
				    WHERE location IN ('World') AND date BETWEEN '2020-03-01' AND '2022-02-28'),
		moy_table2 AS (SELECT location,
								month,
								SUM(new_deaths_updated) moy_total_deaths
						FROM moy_table
						GROUP BY 1,2
						ORDER BY 1,
								CASE WHEN month = 'January' THEN 1
									 WHEN month = 'February' THEN 2
									 WHEN month = 'March' THEN 3
									 WHEN month = 'April' THEN 4
									 WHEN month = 'May' THEN 5
									 WHEN month = 'June' THEN 6
									 WHEN month = 'July' THEN 7
									 WHEN month = 'August' THEN 8
									 WHEN month = 'September' THEN 9
									 WHEN month = 'October' THEN 10
									 WHEN month = 'November' THEN 11
									 WHEN month = 'December' THEN 12 END ASC),
		moy_table3 AS (SELECT location,
								month,
								moy_total_deaths,
								SUM(moy_total_deaths) OVER(PARTITION BY location ORDER BY location) total_deaths
						FROM moy_table2)
SELECT location,
		month,
		moy_total_deaths,
		round(((moy_total_deaths/total_deaths) * 100), 2) Percent_of_total_deaths
FROM moy_table3
WHERE moy_total_deaths != 0 AND total_deaths != 0

-- Steps Overview 
-- We solved this question with 5 tables (4 tempos and 1 final) aside World with 4 tables.
-- We extracted a new column (month of the year) from date column
-- Transforming the day column values from numeric to text representation
-- Summing new_cases/new_deaths column by month of the year
-- Percentage of total cases/deaths per each of the week 
-- Granularized it by World, Continent, and Country


# Question 5
# In which month of the year did we have the highest number of;
# - Death
# - Covid cases
# - Do the analysis by country, continent, and world
# - Hint: Balance the data before analyzing

# Query Solution

# Deaths

# Country 

WITH moy_table AS (SELECT 	continent,
				   			location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_deaths,
				   			CASE WHEN new_deaths IS NULL THEN 0
				   				 WHEN new_deaths IS NOT NULL THEN new_deaths END new_deaths_updated
					FROM coviddeath
				    WHERE location NOT IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe',
					  			           'World',
					  				       'International',
					   				       'European Union',
					   				       'Low income',
					   				       'Lower middle income',
					   				       'Upper middle income',
					   				       'High income') AND date BETWEEN '2020-03-01' AND '2022-02-28'),
			moy_table2 AS(SELECT continent,
						  		location,
								month,
								SUM(new_deaths_updated) moy_total_deaths
						FROM moy_table
						GROUP BY 1,2,3
						ORDER BY 1,2,
								 CASE WHEN month = 'January' THEN 1
									  WHEN month = 'February' THEN 2
									  WHEN month = 'March' THEN 3
									  WHEN month = 'April' THEN 4
									  WHEN month = 'May' THEN 5
									  WHEN month = 'June' THEN 6
									  WHEN month = 'July' THEN 7
						 			  WHEN month = 'August' THEN 8
						 			  WHEN month = 'September' THEN 9
						 			  WHEN month = 'October' THEN 10
						 			  WHEN month = 'November' THEN 11
						 			  WHEN month = 'December' THEN 12 END ASC),
			max_deaths_table AS (SELECT continent,
								 		location,
									MAX(moy_total_deaths) mon_with_highest_deaths
							FROM moy_table2
							GROUP BY 1,2
							ORDER BY 1,2)
SELECT distinct (md.continent),
		md.location,
		mt.month,
		md.mon_with_highest_deaths
FROM moy_table2 mt
JOIN max_deaths_table md
ON md.location = mt.location
AND md.mon_with_highest_deaths = mt.moy_total_deaths
ORDER BY 1

# Death

# Continent 

WITH moy_table AS (SELECT 	location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_deaths,
				   			CASE WHEN new_deaths IS NULL THEN 0
				   				 WHEN new_deaths IS NOT NULL THEN new_deaths END new_deaths_updated
					FROM coviddeath
				    WHERE location IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe') AND date BETWEEN '2020-03-01' AND '2022-02-28'),
			moy_table2 AS(SELECT location,
								month,
								SUM(new_deaths_updated) moy_total_deaths
						FROM moy_table
						GROUP BY 1,2
						ORDER BY 1,
								 CASE WHEN month = 'January' THEN 1
									  WHEN month = 'February' THEN 2
									  WHEN month = 'March' THEN 3
									  WHEN month = 'April' THEN 4
									  WHEN month = 'May' THEN 5
									  WHEN month = 'June' THEN 6
									  WHEN month = 'July' THEN 7
						 			  WHEN month = 'August' THEN 8
						 			  WHEN month = 'September' THEN 9
						 			  WHEN month = 'October' THEN 10
						 			  WHEN month = 'November' THEN 11
						 			  WHEN month = 'December' THEN 12 END ASC),
			max_deaths_table AS (SELECT location,
									MAX(moy_total_deaths) mon_with_highest_deaths
							FROM moy_table2
							GROUP BY 1
							ORDER BY 1)
SELECT distinct (md.location),
		mt.month,
		md.mon_with_highest_deaths
FROM moy_table2 mt
JOIN max_deaths_table md
ON md.location = mt.location
AND md.mon_with_highest_deaths = mt.moy_total_deaths
ORDER BY 1

# Death 

# World 

WITH moy_table AS (SELECT 	location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_deaths,
				   			CASE WHEN new_deaths IS NULL THEN 0
				   				 WHEN new_deaths IS NOT NULL THEN new_deaths END new_deaths_updated
					FROM coviddeath
				    WHERE location IN ('World') AND date BETWEEN '2020-03-01' AND '2022-02-28'),
			moy_table2 AS(SELECT location,
								month,
								SUM(new_deaths_updated) moy_total_deaths
						FROM moy_table
						GROUP BY 1,2
						ORDER BY 1,
								 CASE WHEN month = 'January' THEN 1
									  WHEN month = 'February' THEN 2
									  WHEN month = 'March' THEN 3
									  WHEN month = 'April' THEN 4
									  WHEN month = 'May' THEN 5
									  WHEN month = 'June' THEN 6
									  WHEN month = 'July' THEN 7
						 			  WHEN month = 'August' THEN 8
						 			  WHEN month = 'September' THEN 9
						 			  WHEN month = 'October' THEN 10
						 			  WHEN month = 'November' THEN 11
						 			  WHEN month = 'December' THEN 12 END ASC),
			max_deaths_table AS (SELECT location,
									MAX(moy_total_deaths) mon_with_highest_deaths
							FROM moy_table2
							GROUP BY 1
							ORDER BY 1)
SELECT distinct (md.location),
		mt.month,
		md.mon_with_highest_deaths
FROM moy_table2 mt
JOIN max_deaths_table md
ON md.location = mt.location
AND md.mon_with_highest_deaths = mt.moy_total_deaths
ORDER BY 1

# New Cases 

# Country 

WITH moy_table AS (SELECT 	continent,
				   			location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_cases,
				   			CASE WHEN new_cases IS NULL THEN 0
				   				 WHEN new_cases IS NOT NULL THEN new_cases END new_cases_updated
					FROM coviddeath
				    WHERE location NOT IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe',
					  			           'World',
					  				       'International',
					   				       'European Union',
					   				       'Low income',
					   				       'Lower middle income',
					   				       'Upper middle income',
					   				       'High income') AND date BETWEEN '2020-03-01' AND '2022-02-28'),
			moy_table2 AS(SELECT continent,
						  		location,
								month,
								SUM(new_cases_updated) moy_total_cases
						FROM moy_table
						GROUP BY 1,2,3
						ORDER BY 1,2,
								 CASE WHEN month = 'January' THEN 1
									  WHEN month = 'February' THEN 2
									  WHEN month = 'March' THEN 3
									  WHEN month = 'April' THEN 4
									  WHEN month = 'May' THEN 5
									  WHEN month = 'June' THEN 6
									  WHEN month = 'July' THEN 7
						 			  WHEN month = 'August' THEN 8
						 			  WHEN month = 'September' THEN 9
						 			  WHEN month = 'October' THEN 10
						 			  WHEN month = 'November' THEN 11
						 			  WHEN month = 'December' THEN 12 END ASC),
			max_cases_table AS (SELECT continent, 
									location,
									MAX(moy_total_cases) mon_with_highest_cases
							FROM moy_table2
							GROUP BY 1,2
							ORDER BY 1,2)
SELECT distinct (md.continent),
		md.location,
		mt.month,
		md.mon_with_highest_cases
FROM moy_table2 mt
JOIN max_cases_table md
ON md.location = mt.location
AND md.mon_with_highest_cases = mt.moy_total_cases
ORDER BY 1

# New Cases 

# Continent

WITH moy_table AS (SELECT 	location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_cases,
				   			CASE WHEN new_cases IS NULL THEN 0
				   				 WHEN new_cases IS NOT NULL THEN new_cases END new_cases_updated
					FROM coviddeath
				    WHERE location IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe') AND date BETWEEN '2020-03-01' AND '2022-02-28'),
			moy_table2 AS(SELECT location,
								month,
								SUM(new_cases_updated) moy_total_cases
						FROM moy_table
						GROUP BY 1,2
						ORDER BY 1,
								 CASE WHEN month = 'January' THEN 1
									  WHEN month = 'February' THEN 2
									  WHEN month = 'March' THEN 3
									  WHEN month = 'April' THEN 4
									  WHEN month = 'May' THEN 5
									  WHEN month = 'June' THEN 6
									  WHEN month = 'July' THEN 7
						 			  WHEN month = 'August' THEN 8
						 			  WHEN month = 'September' THEN 9
						 			  WHEN month = 'October' THEN 10
						 			  WHEN month = 'November' THEN 11
						 			  WHEN month = 'December' THEN 12 END ASC),
			max_cases_table AS (SELECT location,
									MAX(moy_total_cases) mon_with_highest_cases
							FROM moy_table2
							GROUP BY 1
							ORDER BY 1)
SELECT distinct (md.location),
		mt.month,
		md.mon_with_highest_cases
FROM moy_table2 mt
JOIN max_cases_table md
ON md.location = mt.location
AND md.mon_with_highest_cases = mt.moy_total_cases
ORDER BY 1

# New Cases 

# World

WITH moy_table AS (SELECT 	location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_cases,
				   			CASE WHEN new_cases IS NULL THEN 0
				   				 WHEN new_cases IS NOT NULL THEN new_cases END new_cases_updated
					FROM coviddeath
				    WHERE location IN ('World') AND date BETWEEN '2020-03-01' AND '2022-02-28'),
			moy_table2 AS(SELECT location,
								month,
								SUM(new_cases_updated) moy_total_cases
						FROM moy_table
						GROUP BY 1,2
						ORDER BY 1,
								 CASE WHEN month = 'January' THEN 1
									  WHEN month = 'February' THEN 2
									  WHEN month = 'March' THEN 3
									  WHEN month = 'April' THEN 4
									  WHEN month = 'May' THEN 5
									  WHEN month = 'June' THEN 6
									  WHEN month = 'July' THEN 7
						 			  WHEN month = 'August' THEN 8
						 			  WHEN month = 'September' THEN 9
						 			  WHEN month = 'October' THEN 10
						 			  WHEN month = 'November' THEN 11
						 			  WHEN month = 'December' THEN 12 END ASC),
			max_cases_table AS (SELECT location,
									MAX(moy_total_cases) mon_with_highest_cases
							FROM moy_table2
							GROUP BY 1
							ORDER BY 1)
SELECT distinct (md.location),
		mt.month,
		md.mon_with_highest_cases
FROM moy_table2 mt
JOIN max_cases_table md
ON md.location = mt.location
AND md.mon_with_highest_cases = mt.moy_total_cases
ORDER BY 1

-- Steps Overview 
-- We solved this question with 4 tables (3 tempos and 1 final)
-- We extracted a new column (month of the year) from date column
-- Summing new_deaths/new_cases column by month of the year
-- Extracting the month with the highest total cases/deaths 
-- Granularized it by World, Continent, and Country




# Question 6
# In which month of the year did we have the least number of;
# - Death
# - Covid cases
# - Do the analysis by country, continent, and world
# - Hint: Balance the data before analyzing

# Deaths 

# Country 

WITH moy_table AS (SELECT 	continent,
				   			location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_deaths,
				   			CASE WHEN new_deaths IS NULL THEN 0
				   				 WHEN new_deaths IS NOT NULL THEN new_deaths END new_deaths_updated
					FROM coviddeath
				    WHERE location NOT IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe',
					  			           'World',
					  				       'International',
					   				       'European Union',
					   				       'Low income',
					   				       'Lower middle income',
					   				       'Upper middle income',
					   				       'High income') AND date BETWEEN '2020-03-01' AND '2022-02-28'),
			moy_table2 AS(SELECT continent,
						  		location,
								month,
								SUM(new_deaths_updated) moy_total_deaths
						FROM moy_table
						GROUP BY 1,2,3
						ORDER BY 1,2,
								 CASE WHEN month = 'January' THEN 1
									  WHEN month = 'February' THEN 2
									  WHEN month = 'March' THEN 3
									  WHEN month = 'April' THEN 4
									  WHEN month = 'May' THEN 5
									  WHEN month = 'June' THEN 6
									  WHEN month = 'July' THEN 7
						 			  WHEN month = 'August' THEN 8
						 			  WHEN month = 'September' THEN 9
						 			  WHEN month = 'October' THEN 10
						 			  WHEN month = 'November' THEN 11
						 			  WHEN month = 'December' THEN 12 END ASC),
			max_deaths_table AS (SELECT continent,
								 		location,
										MIN(moy_total_deaths) mon_with_lowest_deaths
							FROM moy_table2
							GROUP BY 1,2
							ORDER BY 1,2)
SELECT distinct (md.continent),
		md.location,
		mt.month,
		md.mon_with_lowest_deaths
FROM moy_table2 mt
JOIN max_deaths_table md
ON md.location = mt.location
AND md.mon_with_lowest_deaths = mt.moy_total_deaths
ORDER BY 1

# Deaths 

# Continent


WITH moy_table AS (SELECT 	location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_deaths,
				   			CASE WHEN new_deaths IS NULL THEN 0
				   				 WHEN new_deaths IS NOT NULL THEN new_deaths END new_deaths_updated
					FROM coviddeath
				    WHERE location IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe') AND date BETWEEN '2020-03-01' AND '2022-02-28'),
			moy_table2 AS(SELECT location,
								month,
								SUM(new_deaths_updated) moy_total_deaths
						FROM moy_table
						GROUP BY 1,2
						ORDER BY 1,
								 CASE WHEN month = 'January' THEN 1
									  WHEN month = 'February' THEN 2
									  WHEN month = 'March' THEN 3
									  WHEN month = 'April' THEN 4
									  WHEN month = 'May' THEN 5
									  WHEN month = 'June' THEN 6
									  WHEN month = 'July' THEN 7
						 			  WHEN month = 'August' THEN 8
						 			  WHEN month = 'September' THEN 9
						 			  WHEN month = 'October' THEN 10
						 			  WHEN month = 'November' THEN 11
						 			  WHEN month = 'December' THEN 12 END ASC),
			max_deaths_table AS (SELECT location,
									MIN(moy_total_deaths) mon_with_lowest_deaths
							FROM moy_table2
							GROUP BY 1
							ORDER BY 1)
SELECT distinct (md.location),
		mt.month,
		md.mon_with_lowest_deaths
FROM moy_table2 mt
JOIN max_deaths_table md
ON md.location = mt.location
AND md.mon_with_lowest_deaths = mt.moy_total_deaths
ORDER BY 1

# Death 

# World

WITH moy_table AS (SELECT 	location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_deaths,
				   			CASE WHEN new_deaths IS NULL THEN 0
				   				 WHEN new_deaths IS NOT NULL THEN new_deaths END new_deaths_updated
					FROM coviddeath
				    WHERE location IN ('World') AND date BETWEEN '2020-03-01' AND '2022-02-28'),
			moy_table2 AS(SELECT location,
								month,
								SUM(new_deaths_updated) moy_total_deaths
						FROM moy_table
						GROUP BY 1,2
						ORDER BY 1,
								 CASE WHEN month = 'January' THEN 1
									  WHEN month = 'February' THEN 2
									  WHEN month = 'March' THEN 3
									  WHEN month = 'April' THEN 4
									  WHEN month = 'May' THEN 5
									  WHEN month = 'June' THEN 6
									  WHEN month = 'July' THEN 7
						 			  WHEN month = 'August' THEN 8
						 			  WHEN month = 'September' THEN 9
						 			  WHEN month = 'October' THEN 10
						 			  WHEN month = 'November' THEN 11
						 			  WHEN month = 'December' THEN 12 END ASC),
			max_deaths_table AS (SELECT location,
									MIN(moy_total_deaths) mon_with_lowest_deaths
							FROM moy_table2
							GROUP BY 1
							ORDER BY 1)
SELECT distinct (md.location),
		mt.month,
		md.mon_with_lowest_deaths
FROM moy_table2 mt
JOIN max_deaths_table md
ON md.location = mt.location
AND md.mon_with_lowest_deaths = mt.moy_total_deaths
ORDER BY 1


# New Cases

# Country 

WITH moy_table AS (SELECT 	continent,
				   			location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_cases,
				   			CASE WHEN new_cases IS NULL THEN 0
				   				 WHEN new_cases IS NOT NULL THEN new_cases END new_cases_updated
					FROM coviddeath
				    WHERE location NOT IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe',
									 	   'World',
					  				       'International',
					   				       'European Union',
					   				       'Low income',
					   				       'Lower middle income',
					   				       'Upper middle income',
					   				       'High income') AND date BETWEEN '2020-03-01' AND '2022-02-28'),
			moy_table2 AS(SELECT continent,
						  		location,
								month,
								SUM(new_cases_updated) moy_total_cases
						FROM moy_table
						GROUP BY 1,2,3
						ORDER BY 1,2,
								 CASE WHEN month = 'January' THEN 1
									  WHEN month = 'February' THEN 2
									  WHEN month = 'March' THEN 3
									  WHEN month = 'April' THEN 4
									  WHEN month = 'May' THEN 5
									  WHEN month = 'June' THEN 6
									  WHEN month = 'July' THEN 7
						 			  WHEN month = 'August' THEN 8
						 			  WHEN month = 'September' THEN 9
						 			  WHEN month = 'October' THEN 10
						 			  WHEN month = 'November' THEN 11
						 			  WHEN month = 'December' THEN 12 END ASC),
			max_cases_table AS (SELECT 	continent,
										location,
										MIN(moy_total_cases) mon_with_lowest_cases
							FROM moy_table2
							GROUP BY 1,2
							ORDER BY 1,2)
SELECT distinct (md.continent),
		md.location,
		mt.month,
		md.mon_with_lowest_cases
FROM moy_table2 mt
JOIN max_cases_table md
ON md.location = mt.location
AND md.mon_with_lowest_cases = mt.moy_total_cases
ORDER BY 1

# New Cases

# Continent

WITH moy_table AS (SELECT 	location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_cases,
				   			CASE WHEN new_cases IS NULL THEN 0
				   				 WHEN new_cases IS NOT NULL THEN new_cases END new_cases_updated
					FROM coviddeath
				    WHERE location IN ('Africa',
				       					   'South America',
				       				       'North America',
				       				       'Oceania',
				     				       'Asia',
				       				       'Europe') AND date BETWEEN '2020-03-01' AND '2022-02-28'),
			moy_table2 AS(SELECT location,
								month,
								SUM(new_cases_updated) moy_total_cases
						FROM moy_table
						GROUP BY 1,2
						ORDER BY 1,
								 CASE WHEN month = 'January' THEN 1
									  WHEN month = 'February' THEN 2
									  WHEN month = 'March' THEN 3
									  WHEN month = 'April' THEN 4
									  WHEN month = 'May' THEN 5
									  WHEN month = 'June' THEN 6
									  WHEN month = 'July' THEN 7
						 			  WHEN month = 'August' THEN 8
						 			  WHEN month = 'September' THEN 9
						 			  WHEN month = 'October' THEN 10
						 			  WHEN month = 'November' THEN 11
						 			  WHEN month = 'December' THEN 12 END ASC),
			max_cases_table AS (SELECT location,
									MIN(moy_total_cases) mon_with_lowest_cases
							FROM moy_table2
							GROUP BY 1
							ORDER BY 1)
SELECT distinct (md.location),
		mt.month,
		md.mon_with_lowest_cases
FROM moy_table2 mt
JOIN max_cases_table md
ON md.location = mt.location
AND md.mon_with_lowest_cases = mt.moy_total_cases
ORDER BY 1

# New Cases 

# World

WITH moy_table AS (SELECT 	location,
				   			TO_CHAR(date, 'month') AS month,
				   			new_cases,
				   			CASE WHEN new_cases IS NULL THEN 0
				   				 WHEN new_cases IS NOT NULL THEN new_cases END new_cases_updated
					FROM coviddeath
				    WHERE location IN ('World') AND date BETWEEN '2020-03-01' AND '2022-02-28'),
			moy_table2 AS(SELECT location,
								month,
								SUM(new_cases_updated) moy_total_cases
						FROM moy_table
						GROUP BY 1,2
						ORDER BY 1,
								 CASE WHEN month = 'January' THEN 1
									  WHEN month = 'February' THEN 2
									  WHEN month = 'March' THEN 3
									  WHEN month = 'April' THEN 4
									  WHEN month = 'May' THEN 5
									  WHEN month = 'June' THEN 6
									  WHEN month = 'July' THEN 7
						 			  WHEN month = 'August' THEN 8
						 			  WHEN month = 'September' THEN 9
						 			  WHEN month = 'October' THEN 10
						 			  WHEN month = 'November' THEN 11
						 			  WHEN month = 'December' THEN 12 END ASC),
			max_cases_table AS (SELECT location,
									MIN(moy_total_cases) mon_with_lowest_cases
							FROM moy_table2
							GROUP BY 1
							ORDER BY 1)
SELECT distinct (md.location),
		mt.month,
		md.mon_with_lowest_cases
FROM moy_table2 mt
JOIN max_cases_table md
ON md.location = mt.location
AND md.mon_with_lowest_cases = mt.moy_total_cases
ORDER BY 1


-- Steps Overview 
-- We solved this question with 4 tables (3 tempos and 1 final)
-- We extracted a new column (month of the year) from date column
-- Summing new_deaths/new_cases column by month of the year
-- Extracting the month with the lowest total cases/deaths 
-- Granularized it by World, Continent, and Country




