SELECT company, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;