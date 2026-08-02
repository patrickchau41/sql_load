WITH company_year (company, years, total_laid_off) AS (
    SELECT company, EXTRACT(YEAR FROM date) AS years, SUM(total_laid_off)
    FROM layoffs_staging2
    WHERE total_laid_off IS NOT NULL
    GROUP BY company, EXTRACT(YEAR FROM date)
), company_years_rank AS (
    SELECT *,
        DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
    FROM company_year
    WHERE years IS NOT NULL
)
SELECT *
FROM company_years_rank
WHERE ranking <= 5;