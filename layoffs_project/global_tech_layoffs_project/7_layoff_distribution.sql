SELECT 
  CASE
    WHEN percentage_laid_off = 1 THEN '100%'
    WHEN percentage_laid_off >= 0.5 THEN '50–99%'
    WHEN percentage_laid_off >= 0.25 THEN '25–49%'
    ELSE '<25%'
  END AS layoff_severity,
  COUNT(*) AS events
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL
GROUP BY layoff_severity
ORDER BY events DESC;