use [portfolio  project]
Select*
From dbo.CovidDeath

Select*
From  dbo.CovidVaccinations
Order by 3,4

Select Location,date,total_cases,new_cases,total_deaths , Population
From dbo.CovidDeath
Order by 1,2

-- looking at total cases vs  total deaths 

Select Location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as PercenatgeDeaths
From dbo.CovidDeath
Order by 1,2

--- Loooking at total cases vs total population

Select Location,date,population ,total_cases,(Population/total_cases)*100 as PercenatgePopulation
From dbo.CovidDeath
Where location like '%South Africa%'
Order by 1,2

--Looking at countries with Highest infection rate compared to population

Select Location,population ,Max(total_cases) as HighestInfectionCount,Max((Population/total_cases))*100 as PercentagePopulationInfected
From dbo.CovidDeath
--Where location like '%South Africa%'
Group by Location, population
Order by PercentagePopulationInfected desc

--- This will show people with the Highest Death Count per Population

Select Location ,Max(cast(Total_deaths as int)) as TotalDeathCount
From dbo.CovidDeath
--Where location like '%South Africa%'
Where Continent is  null
Group by Location
Order by TotalDeathCount desc

--Global Numbers



Use [portfolio  project]
Select*
From  dbo.CovidDeath
Order by 3,4

Select*
From  dbo.CovidVaccinations
Order by 3,4

Select Location,date,total_cases,new_cases,total_deaths , Population
From dbo.CovidDeath
Order by 1,2

-- looking at total cases vs  total deaths 

Select Location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as PercenatgeDeaths
From dbo.CovidDeath
Order by 1,2

--- Loooking at total cases vs total population

Select Location,date,population ,total_cases,(Population/total_cases)*100 as PercenatgePopulation
From dbo.CovidDeath
Where location like '%South Africa%'
Order by 1,2

--Looking at countries with Highest infection rate compared to population

Select Location,population ,Max(total_cases) as HighestInfectionCount,Max((Population/total_cases))*100 as PercentagePopulationInfected
From dbo.CovidDeath
--Where location like '%South Africa%'
Group by Location, population
Order by PercentagePopulationInfected desc

--- This will show people with the Highest Death Count per Population

Select Location ,Max(cast(Total_deaths as int)) as TotalDeathCount
From dbo.CovidDeath
--Where location like '%South Africa%'
Where Continent is  null
Group by Location
Order by TotalDeathCount desc

--Global Numbers

Select Location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
From dbo.CovidDeath
--Where Location like '%South Africa%'
Where continent is not null
Group
order by 1,2

--- Looking at Total Population Vs  Vaccinations

Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
,SUM(CONVERT(int,vac.new_vaccinations )) Over (Partition by  dea.location order by dea.date) as RollingPeopleVaccinated
From dbo.CovidDeath dea
 Join dbo.CovidVaccinations vac
     On dea.Location = vac.location
	 and dea.date = vac.date
Where dea.continent is not null
Order by 2,3