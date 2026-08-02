SELECT EXTRACT(YEAR FROM date) AS year, country, SUM(total_laid_off)
FROM layoffs_staging2
WHERE country = 'United States'
GROUP BY EXTRACT(YEAR FROM date), country
ORDER BY 1 DESC;

SELECT TO_CHAR(date, 'YYYY-MM') AS monthyear, SUM(total_laid_off)
FROM layoffs_staging2
WHERE date IS NOT NULL
GROUP BY monthyear
ORDER BY monthyear ASC;

WITH rolling_total AS (
    SELECT TO_CHAR(date, 'YYYY-MM') AS monthyear, SUM(total_laid_off) AS total_off
    FROM layoffs_staging2
    WHERE date IS NOT NULL
    GROUP BY monthyear
)
SELECT monthyear, total_off, SUM(total_off) OVER (ORDER BY monthyear) AS rolling_total
FROM rolling_total;