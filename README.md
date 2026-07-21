# Introduction
Let's begin to dive into the data job market! Focusing on data analyst roles, this project explores top-paying jobs, in-demand skills, and where high demand meets high salary in the field of data analytics.

Check out my SQL queries here: [data_analysis_sql_project folder](/data_analysis_sql_project/)

# Background
Driven by a quest to navigate towards the data analyst job market more effectively, this project was intended to pinpoint top-paid and in-demand skills, streamlining job seekers to find optimal jobs.

### The questions I aim to answer through my SQL queries:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in-demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my dive into the data analyst job market, I utilized the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query my database to reveal critical and actionable insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & Github:** Essential for version control and sharing my SQL scripts and analysis for project tracking and sharing.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here is how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the top 10 paying roles, I filtered data analyst positions by the average yearly salary and location, focusing on remote jobs and ignoring null values. This query highlights the high paying opportunities in this field.

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
    job_work_from_home = TRUE AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

## Top 10 Highest Paying Data Analyst Jobs (2023)

| Job Title | Company | Salary (USD) |
|---|---|---|
| Data Analyst | Mantys | $650,000 |
| Director of Analytics | Meta | $336,500 |
| Associate Director, Data Insights | AT&T | $255,830 |
| Data Analyst, Marketing | Pinterest | $232,423 |
| Data Analyst (Hybrid/Remote) | UCLA Health | $217,000 |
| Principal Data Analyst (Remote) | SmartAsset | $205,000 |
| Director, Data Analyst | Inclusively | $189,309 |
| Principal Data Analyst, AV Performance | Motional | $189,000 |
| Principal Data Analyst | SmartAsset | $186,000 |
| ERM Data Analyst | Get It Recruit | $184,000 |

> All positions are remote full-time. Average salary: $255,406.

Breakdown of the Top Data Analyst Jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field. However, the company, Mantys, seems to be an outlier, where without it being included, the remaining jobs average out to around $220K.
- **No Tech Giants:** While Meta certainly is a recognizable name within the top 10, the majority of the top paying roles are from companies people have not heard much from, including SmartAsset, Mantys, and Inclusively. This suggests that some smaller companies are willing to prioritize on paying more towards data talent than household names.
- **Job Title Variety:** There is a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings dataset with the skills data, providing insights into what employers value for high-compensation roles.

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

![Top Skills](data_analysis_sql_project\assets\top_skills.png)

The breakdown of the most demanded skills for the top 10 highest paying daa analyst jobs in 2023:
- **SQL** is leading with a bold count of 8.
- **Python** follows closely with a bold count of 7. 
- **Tableau** is also highly sought after, with a bold count of 6.
- Other skills like **R**, **Snowflake**, **Pandas**, and **Excel** show varying degrees in demand.
- Tableau appears in 6 of 8 job listings, while Power BI is only included in 2. At the highest salary levels, Tableau shows to be the more dominant visualization tool.

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
![In Demand SKills](data_analysis_sql_project\assets\in_demand_skills.png)

The breakdown of the most demanded skills for data analysts in 2023:
- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.
- **SQL**, **Excel**, **Python**, **Tableau**, and **Power BI** cover the core toolkit that the market demands. Mastering these five gives you great coverage across the majority of data analyst job postings.

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying based on salary.

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg),2) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25
```
## Top 25 Highest Paying Skills for Data Analysts

| Skill | Average Salary (USD) |
|---|---|
| SVN | $400,000 |
| Solidity | $179,000 |
| Couchbase | $160,515 |
| DataRobot | $155,486 |
| Golang | $155,000 |
| MXNet | $149,000 |
| dplyr | $147,633 |
| VMware | $147,500 |
| Terraform | $146,734 |
| Twilio | $138,500 |
| GitLab | $134,126 |
| Kafka | $130,000 |
| Puppet | $129,820 |
| Keras | $127,013 |
| PyTorch | $125,226 |
| Perl | $124,686 |
| Ansible | $124,370 |
| Hugging Face | $123,950 |
| TensorFlow | $120,647 |
| Cassandra | $118,407 |
| Notion | $118,092 |
| Atlassian | $117,966 |
| Bitbucket | $116,712 |
| Airflow | $116,387 |
| Scala | $115,480 |

> *Average salaries based on job postings from 2023. SVN represents a significant outlier likely driven by a small number of exceptionally high-paying roles.*

The breakdown for the top paying skills for Data Analysts in 2023:
- Six AI/ML related skills appear in the top 25, including MXNet, Keras, PyTorch, Hugging Face, TensorFlow, and DataRobot, which are all averaging in the range of $120K-$155K. AI/ML adjacent skills command a significant salary premium for data analysts.
- None of the top 5 most in-demand skills from the previous chart, including **SQL**, **Excel**, **Python**, **Tableau**, **Power BI** appear in this top 25. The skills the market demands most are not the same ones that pay the most. The sweet spot for salary growth is pairing the foundational skills with niche, specialized tools, as aspiring data analysts adapt throughout their careers.


### 5. What are the most optimal skills for Data Analysts?
Balancing out both the top paying skills, along with the most in-demand skills, this query, incorporating a combination of ctes, explores the most optimal skills for aspiring Data Analysts to master to succeed in their data analytics career.

```sql
WITH skills_demand AS (
    SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
), average_salary AS (
    SELECT 
    skills_job_dim.skill_id,
    ROUND(AVG(salary_year_avg),2) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL
GROUP BY
    skills_job_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
## Optimal Skills for Data Analysts (High Demand + High Salary)

| Skill | Demand (Job Postings) | Average Salary (USD) |
|---|---|---|
| Snowflake | 241 | $111,578 |
| Spark | 187 | $113,002 |
| Hadoop | 140 | $110,888 |
| Databricks | 102 | $112,881 |
| Pandas | 90 | $110,767 |
| GCP | 78 | $113,065 |
| Git | 74 | $112,250 |
| Airflow | 71 | $116,387 |
| Confluence | 62 | $114,153 |
| Scala | 59 | $115,480 |
| Linux | 58 | $114,883 |
| PySpark | 49 | $114,058 |
| Shell | 44 | $111,496 |
| Kafka | 40 | $129,999 |
| Unix | 37 | $111,123 |
| PHP | 29 | $109,052 |
| MongoDB | 26 | $113,608 |
| TensorFlow | 24 | $120,647 |
| Phoenix | 23 | $109,259 |
| PyTorch | 20 | $125,226 |
| Perl | 20 | $124,686 |
| Atlassian | 15 | $117,966 |
| Splunk | 15 | $112,928 |
| Cassandra | 11 | $118,407 |
| Airflow | 71 | $116,387 |

> *Optimal skills are defined as those appearing in a meaningful number of job postings while commanding above-average compensation — representing the best return on learning investment.*

The breakdown of the most optimal skills for Data Analysts to focus on in 2023:
- **Snowflake** is the single most optimal skill with the highest demand and a very high salary of around $111K. It's the clearest single skill to prioritize for anyone targeting both job opportunities and compensation.
- **Snowflake**, **Spark**, **Databricks**, **GCP**, **Hadoop**, and **PySpark** all cluster in high demand and high salary. Cloud and big data infrastructure skills consistently deliver both volume of opportunity and strong compensation.
- **Kafka** pays the most at $130,000 but only appears in 40 job postings. **PyTorch** and **Perl**, in addition, also pay well but have very low demand. These are specialist skills that pay a premium precisely because few people have them, but the job opportunities are limited.
# What I Learned

Throughout this project, I have applied a lot to my SQL capabilities:

- **Complex Query Crafting:** Mastered advanced SQL, merging tables while also wielding WITH cte clauses for advanced temp table maneuvers. 
- **Data Aggregation:** Got very comfortable using GROUP BY and turned aggregate functions like COUNT() and AVG() into useful data-summarizing tools. 
- **Analytical Wizardry:** Leveled up my real-world problem solving skills, turning business questions into actionable and clearly insightful SQL queries.

# Conclusions

### Insights:
From the analysis, several general insights were gathered:
1. **Top-Paying Data Analyst Jobs:** The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs:** High-paying data analyst jobs require advanced proficiency in SQL, suggesting it is a crucial skill for earning top salary money.
3. **Most In-Demand Skills:** SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries:** Specialized skills, such as SVN and Soladity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value:** SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market vaue.

### Closing Thoughts

This project severely enhanced my SQL skills and provided very valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts for job seekers. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.