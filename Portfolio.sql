
SELECT 
      [location],[date],[total_cases],[new_cases],[total_deaths],population
  FROM [PorfolioProject]..[CovidDeaths]
  order by 1,2

  --Looking at the Total cases vs Total Deaths

  SELECT 
      location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentag
  FROM PorfolioProject..CovidDeaths
  Where location like '%kingdom%'
  --And total_cases is null
  order by 1,2

  -- Shows what percentage of population got Covid
  SELECT 
      location,date,population,total_cases,population,(total_cases/population)*100 as percentPopulationInfected
  FROM PorfolioProject..CovidDeaths
 -- Where location like '%kingdom%'
  order by 1,2

  -- Looking at countries with highest infection rate compared to population

  SELECT 
      location,population,MAX(total_cases) as HighestInfectioncount,Max(total_cases/population)*100 as percentPopulationInfected
  FROM PorfolioProject..CovidDeaths
 -- Where location like '%kingdom%'
 Group by Location,Population
  order by percentPopulationInfected DESC

  -- Showing countries with the highest Death count per Population
  SELECT 
  location,Max(Cast(total_deaths as int)) as TotalDeathCount
  FROM PorfolioProject..CovidDeaths
 -- Where location like '%kingdom%'
 Where continent is null
 Group by location
  order by TotalDeathCount DESC
  

  -- Continent Breakdown

  SELECT 
  Continent,Max(Cast(total_deaths as int)) as TotalDeathCount
  FROM PorfolioProject..CovidDeaths
 -- Where location like '%kingdom%'
 Where continent is not null
 Group by continent
  order by TotalDeathCount DESC


  --Global number

   SELECT date,SUM(new_cases) as Total_cases,SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))
   /SUM(new_Cases)*100 as DeathPercentage
  FROM PorfolioProject..CovidDeaths
 -- Where location like '%kingdom%'
 Where continent is not null
 Group by date
  order by 1,2

  --Overall Total Cases

  SELECT SUM(new_cases) as Total_cases,SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))
   /SUM(new_Cases)*100 as DeathPercentage
  FROM PorfolioProject..CovidDeaths
 -- Where location like '%kingdom%'
 Where continent is not null
 --Group by date
  order by 1,2

  -- Total population vs Vaccination

  Select * FROM  PorfolioProject..CovidDeaths D
  Join PorfolioProject..Covidvaccination V
  On D.location = V.location
  And D.Date=V.Date 