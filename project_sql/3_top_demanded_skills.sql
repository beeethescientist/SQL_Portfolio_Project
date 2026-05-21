/*
What are the most in-demand skills for my role?
    - Join postings to inner join table similar to query 2.
    - Identify the top 5 in-demand skills for data analyst.
    - Focus on all job postings.
    - Why? Retrieves the top 5 skills with the highest demands in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

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

/*
Here's a breakdown of the most demanded skills for data analysts.
SQL and Excel remain fundamental, emphasizing the need for strong foundation 
Programming and Visualization Tools like Python, Tableu and Power Bi are expected
[
  {
    "skills": "sql",
    "demand_count": "7291"
  },
  {
    "skills": "excel",
    "demand_count": "4611"
  },
  {
    "skills": "python",
    "demand_count": "4330"
  },
  {
    "skills": "tableau",
    "demand_count": "3745"
  },
  {
    "skills": "power bi",
    "demand_count": "2609"
  }
]*/