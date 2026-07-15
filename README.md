# Introduction
    Dive into the data job market! Focusing on data analyst roles, this project explores top paying jobs, in-demand skills, and where high demand meets high salary in data analytics.
    
# Data Analyst Job Market Analysis (SQL)

## Introduction

This project explores the data analyst job market by analysing real-world job postings to identify salary trends, in-demand technical skills, and the technologies associated with high-paying opportunities.

Using PostgreSQL, I answered a series of business questions through SQL queries involving joins, Common Table Expressions (CTEs), aggregate functions, and window functions to extract meaningful insights from the data.

### The analysis focuses on five key questions:
1. What are the highest-paying data analyst roles?
2. What skills are required for the highest-paying positions?
3. Which skills are most in demand among employers?
4. Which skills are associated with higher salaries?
5. Which skills provide the best combination of demand and salary potential?

        Explore the SQL analysis here:

        ➡️ [SQL Project Files](project_sql/README.md)

# Background
With a background in enterprise IT support and a BSc Honours in Data Science, I am developing my skills in data analytics and data science.

This project was created to apply my SQL skills to a real-world dataset and explore the relationship between job demand, salaries, and technical skills within the data analytics industry.

The dataset contains information about data-related job postings, including:
- Job titles
- Salaries
- Locations
- Work arrangements
- Required technical skills

The data was provided through the SQL course by Luke Barousse:
[SQL Course](https://lukebarousse.com/sql)

# 🛠️ Tools I used
- **PostgreSQL:** Used to store, query, and analyze job posting data.
- **SQL:** Used to clean, transform, join, and analyze relational data.
- **Visual Studio Code:** Used as the development environment for writing SQL queries.
- **Git & GitHub:** Used for version control and documenting my portfolio projects.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market.
Here's how i approached each question.

## SQL Concepts Demonstrated

- SELECT
- WHERE
- GROUP BY
- ORDER BY
- JOINS
- LEFT JOIN
- INNER JOIN
- Common Table Expressions (CTEs)
- Aggregate Functions
- Window Functions
- LIMIT

### 1. Top paying Data Analyst Jobs.
To identify the highest-paying roles I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.


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
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential I the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offeringhigh salaries, showing a broad interest accross different industries.
- **Job Title Variety:** There's a high diversity in job title, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

### 2. Skills for top paying jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
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
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC
```

Here's a breakdown of the  most demanded skills for the top 10 highest paying data analyst jobs in 2023:
-  ***SQL*** is leading with abold count of 8.
- ***Python*** follows closely with a count of 7.
- ***Excel*** is also in high demand with 6 job postings requiring it.
- ***Tableu*** is also highly sought after, with 6.
Other skills like ***R, Snowflake, Pandas*** show varying degrees of demand.

### 3. In-demand skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE   
     job_title_short = 'Data Analyst' AND
     job_work_from_home = True
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
Here's a breakdown of the most demanded skills for data analysts in 2023.
- ***SQL*** and ***Excel*** remain fundamental, emphasizing the need for strong foundational skills in data processing and manipulation. 
- ***Programming*** and ***Visualization Tools*** like ***Python, Tableu*** and ***Power Bi*** are essential, pointing towards the increasing importance of tehcnical skills in data storytelling and decision support.

| Skills   | Demand Count |
|--------  |--------------|
| SQL      | 7291         | 
| Excel    | 4611         | 
| Pythhon  | 4330         | 
| Tableu   | 3745         | 
| Power BI | 2609         | 

*Table of the demand for top 5 skills in data analyst job postings*


### 4. Skills based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE   
     job_title_short = 'Data Analyst' 
     AND salary_year_avg IS NOT NULL
     AND job_work_from_home = True
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```

Here is a breakdown of the results for the top paying skills
- ***High demand for Big Data & ML skills:*** Top salaries commanded by analysts skilled in big data tech (PyShark,Couchbase), machine learning tools(DataRobot, Jupyter), and Python libraries(Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- ***Software Development & Deployment proficiency:*** Knowledge in devlopment and deployemnt tools(GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering.
- ***Cloud computing expertise:*** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks,GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency boosts earning potential in data analytics.


| Skills  | Average Salary ($)   |
|---------|:--------------------:|
| pyspark | 208,172              |
|bitbucket| 189,155              |
|couchbase| 160,515              |
| watson  | 160,515              |
|datarobot| 155,486              |
|gitlab   | 154,500              |
| swift   | 153,750              |
| jupyter | 152,777              |
| pandas  | 151,821              |
|elasticsearch| 145,000          |

*Table of the average salary for the top 10 paying skills for data analyst*


### 5. Most optimal skills to learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.
``` sql

WITH skills_demand AS( 
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE   
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True
    GROUP BY
        skills_dim.skill_id
), average_salary AS ( 
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE   
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True
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
WHERE
    demand_count > 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

| Skill ID | Skills    | Demand Count | Average Salary ($) |
|----------|-----------|------------- |--------------------|
| 8        | go        | 27           | 115,320            |
| 234      | confluenc | 11           | 114,210            |
| 97       | hadoop    | 22           | 113,193            |
| 80       | snowflake | 37           | 112,948            | 
| 74       | azure     | 34           | 111,225            |
| 77       | bigquery  | 13           | 109,654            |
| 76       | aws       | 32           | 108,317            |
| 4        | java      | 17           | 106,906            |
|194       | ssis      | 12           | 106,683            |
|233       | jira      | 20           | 104,918            |

*Table of the most optimal skills for data analyst sorted by salary*


Here's a breakdown of the most optimal skills for Data Analysts in 2023:
- **High-Demand Programming Languages:** Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely.
- **Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
- **Business Intelligence and Visualization
Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from
- **Database Technologies:** The demand for skills
in traditional and NoSQL
databases (Oracle, SQL
Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.

# What I learned
Through this project, I strengthened my understanding of SQL and data analysis workflows.

Key skills developed:

- Writing complex SQL queries using multiple joins and Common Table Expressions (CTEs)
- Extracting insights from relational databases
- Using aggregation functions to summarize large datasets
- Applying analytical thinking to answer real-world business questions
- Structuring and documenting projects using GitHub

# Conclusions 

This analysis highlighted the importance of strong technical foundations in the data analyst field.

Key findings:

- SQL remains one of the most valuable and in-demand skills for data analysts.
- Python, Excel, Tableau, and cloud technologies are frequently requested by employers.
- Specialized skills in areas such as cloud platforms and data engineering tools can increase earning potential.
- Combining technical skills with analytical thinking creates stronger opportunities in the data job market.

This project helped me apply SQL concepts to a real-world dataset and provided a clearer understanding of the skills required to continue developing as a data professional.
