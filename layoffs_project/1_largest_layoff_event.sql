/* find the single largest layoff event by raw headcount */
SELECT *
FROM layoffs_staging2
WHERE total_laid_off = (SELECT MAX(total_laid_off) FROM layoffs_staging2);

/* view every company that laid off 100% of its staff, ordered by funding raised
   to highlight the most well-funded companies that still shut down completely */
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;