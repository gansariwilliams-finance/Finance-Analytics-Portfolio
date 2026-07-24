
-- Exploratory Data Analysis -- 
select *
from layoffs_staging3;

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging3;


select *
from layoffs_staging3
where percentage_laid_off = 1
order by total_laid_off desc;

select *
from layoffs_staging3
where percentage_laid_off = 1
order by funds_raised_millions desc;

select company, sum(total_laid_off)
from layoffs_staging3
group by company
order by 2 desc;

-- note that 2 here means column two 


select min(`date`), max(`date`)
from layoffs_staging3;



select *
from layoffs_staging3;



select industry, sum(total_laid_off)
from layoffs_staging
group by industry 
order by 2 desc
;

select *
from layoffs_staging3;

-- lets look at which country has the highest layoff 
-- exploratory data analysis

select country , sum(total_laid_off)
from layoffs_staging3
group by country
order by  sum(total_laid_off) desc;

-- the above syntax same as
select country , sum(total_laid_off)
from layoffs_staging3
group by country
order by  2 desc;




select year(`date`), sum(total_laid_off)
from layoffs_staging3
group by year(`date`)
order by  1 desc;


select stage, sum(total_laid_off)
from layoffs_staging3
group by stage
order by 2 desc;



select  substring(`date`, 1, 7) as `Month`, sum(total_laid_off)
from layoffs_staging3
where substring(`date`, 1, 7)
group by `Month` 
order by 1 asc;


-- rolling sum of the above 


with Rolling_total AS 
(
select  substring(`date`, 1, 7) as `Month`, sum(total_laid_off) as Total_off
from layoffs_staging3
where substring(`date`, 1, 7)
group by `Month` 
order by 1 asc
)

SELECT `MONTH`, total_off, sum(Total_off) over( order by `month`) as Rolling_total_off
FROM Rolling_total
;



select company, sum(total_laid_off)
from layoffs_staging3 
group by company
order by 2 desc 
;

-- the above will sound like 
-- select company and the sum of those laid off in the company 
-- from the layoffs_staging3 table 
-- group by company , so same companies would be intergarted together into a row 
-- then order the above by column 2 from top to bottom 
-- i.e from the highest total laid off to the lowest
-- 
;


select company, year(`DATE`), sum(total_laid_off)
from layoffs_staging3 
group by company, year(`DATE`)
order by 3 desc;

-- dont forget that you can groupo by more than 1 variable 
;



WITH Company_Year (company, years, total_laid_off) as

(
select company, year(`date`) as Years, sum(total_laid_off)
from layoffs_staging3 
group by company, year(`date`)
),
Company_year_rank as
(
select *, 
dense_rank() over (partition by years order by total_laid_off desc) AS Ranking
from Company_Year
where years is not null
)
SELECT *
FROM COMPANY_YEAR_RANK
WHERE RANKING <= 5
;


select *
from layoffs_staging3;




















































































































