SELECT industry, ROUND(AVG(percentage_laid_off), 2) AS avg_layoff_percentage
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL
GROUP BY industry
ORDER BY avg_layoff_percentage DESC;