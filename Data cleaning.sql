SELECT *
FROM ds_jobs;

-- REMOVE DUPLICATES

SELECT *
FROM (
	SELECT id, ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
	FROM ds_jobs
	) AS duplicates
WHERE row_num > 1;

-- Salary_Estimate


-- Standardize Rating to 1 decimal places
SELECT Rating, ROUND(Rating,2)
FROM ds_jobs;

UPDATE ds_jobs
SET Rating = ROUND(Rating,2);
	
SELECT *
FROM ds_jobs;


SELECT Salary_Estimate,
SUBSTRING(Salary_Estimate, -1,13) Salary
FROM ds_jobs;
-- TESTING THE SEPARATE QUERY BEFORE INPUT IT INTO THE TABLE
SELECT SUBSTRING(Salary_Estimate,1,5) AS MIN, s.Salary_Estimate
FROM ( SELECT Salary_Estimate,
SUBSTRING(Salary_Estimate, -1,13) AS Salary_Sub
FROM ds_jobs) AS s;

SELECT SUBSTRING(Salary_Estimate,7,6) AS MAX, s.Salary_Estimate
FROM ( SELECT Salary_Estimate,
SUBSTRING(Salary_Estimate, -1,13) AS Sal_Sub
FROM ds_jobs) AS s;

-- ADD A COLUMN TO SEPARATE SALARY INTO MIN & MAX
ALTER TABLE ds_jobs
ADD Max_sal varchar(50);

ALTER TABLE ds_jobs
ADD Min_sal varchar(50);

SELECT *
FROM ds_jobs;

UPDATE ds_jobs
SET Max_Sal = SUBSTRING(Salary_Estimate,7,5);

UPDATE ds_jobs
SET Min_sal = SUBSTRING(Salary_Estimate,1,5);

ALTER TABLE ds_jobs
DROP COLUMN Salary_Estimate;

ALTER TABLE ds_jobs
ADD job_state varchar(50);

-- GET THE ABbREVIATION IN THE COLUMN TO ANOTHER NEW COLUMN
SELECT Location, RIGHT(Location,2)
FROM ds_jobs;

UPDATE ds_jobs
SET job_state = RIGHT(Location,2);

-- REMOVE THE RATINGS IN THE COLUMN
SELECT Company_Name, RIGHT(Company_Name, 3)
FROM ds_jobs;

SELECT Company_Name, REPLACE(Company_Name, RIGHT(Company_Name, 3),' ')
FROM ds_jobs
WHERE LEN(Company_Name) >= 3;


UPDATE ds_jobs 
SET Company_Name = REPLACE(Company_Name, RIGHT(Company_Name, 3),' ')
WHERE LEN(Company_Name) >= 3;


--STANDARDIZE REVENUE
UPDATE ds_jobs
SET Revenue = NULL
WHERE Revenue = 'Unknown / Non-Applicable';

UPDATE ds_jobs
SET REVENUE = REPLACE(Revenue, RIGHT(Revenue, 5),' ')
WHERE LEN(Revenue) >= 5;

SELECT Revenue, REPLACE(Revenue, RIGHT(Revenue, 5),' ')
FROM ds_jobs
WHERE LEN(Revenue) >= 5;

-- DROP JOB DESC COLUMN
ALTER TABLE ds_jobs
DROP COLUMN Job_Description;

SELECT *
FROM ds_jobs;

-- TRIM OPTHER FOR EXTRA SPACES
SELECT Job_Title, TRIM(Job_Title)
FROM ds_jobs;

SELECT Industry, TRIM(Industry)
FROM ds_jobs;

SELECT Sector, TRIM(Sector)
FROM ds_jobs;