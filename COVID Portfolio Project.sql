/*
Covid 19 Data Exploration 

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/

select * from CovidProject..CovidDeaths
order by 3,4

select * from CovidProject..CovidVaccinations
order by 3,4

select  total_deaths 
from CovidDeaths


SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CovidDeaths' AND COLUMN_NAME IN ('total_cases', 'population')

ALTER TABLE CovidDeaths 
ALTER COLUMN total_cases FLOAT;

ALTER TABLE CovidDeaths 
ALTER COLUMN population FLOAT;



update CovidDeaths
      set total_deaths = Null 
	  where total_deaths = 0 OR total_deaths = ''

update CovidDeaths
      set total_cases = Null 
	  where total_cases = 0 OR total_cases = ''

update CovidDeaths
      set continent = Null 
	  where continent = ''

	
-- Select Data that we are going to be starting with
	
select location,date,total_cases,new_cases,total_deaths,population
from CovidDeaths
order by 1,2

	
-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
	
SELECT location,date,total_cases,total_deaths,
    CASE 
        WHEN CAST(total_cases AS FLOAT) = 0 THEN NULL
        ELSE (CAST(total_deaths AS FLOAT) / CAST(total_cases AS FLOAT)) * 100
    END AS DeathsPercentage
FROM CovidDeaths
where location like '%egy%'
ORDER BY  4 desc

	

-- Total Cases vs Population
-- Shows what percentage of population infected with Covid
	
select location,date,population,total_cases,
    CASE 
        WHEN CAST(total_cases AS FLOAT) = 0 THEN NULL  
        ELSE (CAST(total_cases AS FLOAT) / CAST(population AS FLOAT))*100
    END AS [PopulationInfectedIn%]
FROM CovidDeaths
WHERE location LIKE '%egy%'
ORDER BY YEAR(date) ASC, MONTH(date) ASC, DAY(date) ASC;



-- Countries with Highest Infection Rate compared to Population

SELECT location,population,MAX(total_cases) AS HighestInfectionCountry, MAX((total_cases / NULLIF(population, 0)) * 100) AS [PopulationInfectedIn%]
FROM CovidDeaths
GROUP BY location, population
ORDER BY [PopulationInfectedIn%] desc


	
-- Countries with Highest Death Count per Population
	
SELECT location, Max(cast(total_deaths as int)) as TotalDeathcount
FROM CovidDeaths
where continent is not null
GROUP BY location
ORDER BY TotalDeathcount desc


	
-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population 
	
SELECT continent, Max(cast(total_deaths as int)) as TotalDeathcount
FROM CovidDeaths
where continent is not null
GROUP BY continent
ORDER BY TotalDeathcount desc


	
--Global Numbers
	
SELECT  SUM(new_cases) as total_cases, SUM(CAST(new_deaths AS INT)) as total_deaths, SUM(CAST(new_deaths AS INT)) / NULLIF(SUM(new_cases), 0) * 100 AS [Death%]
FROM CovidDeaths
WHERE continent IS NOT NULL


	
-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine	
	
UPDATE CovidVaccinations
      SET new_vaccinations = NULL
	  WHERE new_vaccinations = ''

SELECT CD.continent,CD.location,CD.DATE,CD.population,CV.new_vaccinations
,SUM(CONVERT(INT, CV.new_vaccinations))
OVER (PARTITION BY CD.LOCATION ORDER BY CD.LOCATION,CD.DATE) AS RollingPeopleVaccinated
FROM CovidDeaths CD JOIN CovidVaccinations CV
ON CD.location=CV.location AND CD.date=CV.date
WHERE CD.continent IS NOT NULL
ORDER BY 2,3


	
-- Using CTE to perform Calculation on Partition By in previous query
	
WITH POPVSVAC(CONTINENT,LOCATION,DATE,POPULATION,New_Vaccinations,RollingPeopleVaccinated)
AS
(
SELECT CD.continent,CD.location,CD.DATE,CD.population,CV.new_vaccinations
,SUM(CONVERT(INT, CV.new_vaccinations))
OVER (PARTITION BY CD.LOCATION ORDER BY CD.LOCATION,CD.DATE) AS RollingPeopleVaccinated
FROM CovidDeaths CD JOIN CovidVaccinations CV
ON CD.location=CV.location AND CD.date=CV.date
WHERE CD.continent IS NOT NULL
)
	
SELECT *,(RollingPeopleVaccinated/POPULATION)*100
FROM POPVSVAC



	
-- Using Temp Table to perform Calculation on Partition By in previous query
	
DROP TABLE IF EXISTS [#PopulationVaccinatedin%]
create TABLE [#PopulationVaccinatedin%]
(
Continent nvarchar(50),
Location nvarchar(50),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)


INSERT INTO [#PopulationVaccinatedin%]
SELECT CD.continent,CD.location,CD.DATE,CD.population,CV.new_vaccinations
,SUM(CONVERT(INT, CV.new_vaccinations))
OVER (PARTITION BY CD.LOCATION ORDER BY CD.LOCATION,CD.DATE) AS RollingPeopleVaccinated
FROM CovidDeaths CD JOIN CovidVaccinations CV
ON CD.location=CV.location AND CD.date=CV.date


SELECT *,(RollingPeopleVaccinated/POPULATION)*100
FROM [#PopulationVaccinatedin%]



	
-- Using Temp Table to perform Calculation on Partition By in previous query

Create View [PopulationVaccinatedin%] as
SELECT CD.continent,CD.location,CD.DATE,CD.population,CV.new_vaccinations
,SUM(CONVERT(INT, CV.new_vaccinations))
OVER (PARTITION BY CD.LOCATION ORDER BY CD.LOCATION,CD.DATE) AS RollingPeopleVaccinated
FROM CovidDeaths CD JOIN CovidVaccinations CV
ON CD.location=CV.location AND CD.date=CV.date
WHERE CD.continent IS NOT NULL

Select * 
from [PopulationVaccinatedin%]
