/* 
Question: what are the top skills based on salary? 
-- Look at the average salary associated with each skills for Data Analyst positions 
-- Focuses on roles with specified salaries, regardless of location 
-- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to aquire or improve. 
*/


SELECT
    skills,
    ROUND(AVG (salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    -- AND job_work_from_home = True
GROUP BY 
    skills
ORDER BY
   avg_salary DESC
LIMIT 50;

/* 
A breakdown of the results for top paying skills
-- High Demand for Big Data and ML skills: Top salaries 
-- Software Development and Deployment Proficiency
-- Cloud Computing Expertise: Familitarity with cloud
*/