# Introduction
Dive into the data job market! Focusing on data analyst roles, this project explores top-paying jobs, in-demand skills, and where high demand meets high salary in data analytics.

Check out my SQL queries here: [data_analysis_sql_project folder](/data_analysis_sql_project/)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was intended to pinpoint top-paid and in-demand skills, streamlining others work to find optimal job

### The questions I wanted to answer through my SQL queries:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in-demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I utilized the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query my database to reveal critical and actionable insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database managemnt and executing SQL queries.
- **Git & Github:** Essential for version control and sharing my SQL scripts and analysis for project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the datta analyst job market. Here is how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This quert highlights the high paying opportunities in this field.

```sql
SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact AS job_postings
LEFT JOIN company_dim AS company ON job_postings.company_id = company.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

Breakdown of the Top Data Analyst Jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries. 
- **Job Title Variety:** There is a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS (

SELECT 
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
FROM
    job_postings_fact AS job_postings
LEFT JOIN company_dim AS company ON job_postings.company_id = company.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```

The breakdown of the most demanded skills for the top 10 highest paying daa analyst jobs in 2023:
- **SQL** is leading with a bold count of 8.
- **Python** follows closely with a bold count of 7. 
- **Tableau** is also highly sought after, with a bold count of 6.
- Other skills like **R**, **Snowflake**, **Pandas**, and **Excel** show varying degrees in demand.

### 3. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```

The breakdown of the most demanded skills for data analysts in 2023:
- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the icreasing importance of technical skills in data storytelling and decision support.

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills reealed which skills are the highest paying.

# What I Learned

Throughout this project, I have applied a lot to my SQL capabilities:

- **Complex Query Crafting:** Mastered advanced SQL, merging tables while also wielding WITH clauses for advanced temp table maneuvers. 
- **Data Aggregation:** Got very comfortable using GROUP BY and turned aggregate functions like COUNT() and AVG() into useful data-summarizing tools. 
- **Analytical Wizardry:** Leveled up my real-world problem solving skills, turning business questions into actionable and clearly insightful SQL queries.

# Conclusions

### Insights:
From the analysis, several general insights were gathered:
1. **Top-Paying Data Analyst Jobs:** The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs:** High-paying data analys jobs require advanced proficiency in SQL, suggesting it is a crucal skill for earning top salary money.
3. **Most In-Demand Skills:** SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries:** Specialized skills, such as SVN and Soladity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value:** SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market vaue.

### Closing Thoughts

This project severely enhanced my SQL skills and provided very valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts forjob seekers. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.