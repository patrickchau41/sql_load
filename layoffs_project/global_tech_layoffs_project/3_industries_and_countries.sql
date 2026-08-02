SELECT country, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL
GROUP BY country
ORDER BY 2 DESC;

SELECT industry, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL
GROUP BY industry
ORDER BY 2 DESC;