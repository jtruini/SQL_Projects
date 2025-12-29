# Introduction 
📊Lets go into the data job market! With a focus on data analysis roles, lets explore the top-paying jobs, demanded skills, and which has the best of both. 

🔍For SQL queries, go here: [project_sql folder](/project_sql/).
# Background 
Navigating the job market can be confusing, so this project aims to pinpoint high paying and in demand skills, streamlining credited work to find optimal jobs 

Data is from [SQL Course](https://lukebarousse.com/sql). It has information such as job titles, yearly pay, posting dates, and other valuable data. 
### The questions answered through these queries are: 

1. What are the top paying data analyst jobs? 
2. What skills are required for said jobs? 
3. What skills are most in demand for these jobs? 
4. Which skills are associated with higher salaries? 
5. What are the molst optimal skills to learn? 
# Tools I used
Tools used include: 

- **SQL** for writing queries.
- **PostgreSQL** for the database management system.
- **VSCode** for executing queries.
- **Git and GitHub**: Used for sharing SQL scripts and analysis. 
- **Tableau:** Used to make charts based off of findings. 
# The Analysis 
Every query is used to investigate specific instances of the data analyst job market. 

### 1. Highest Payed Data Analyst Jobs💰
For highest-paying data analyst roles, I made a query that filtered by average salary and location, making sure that the jobs were remote. This highlights the highest paying jobs in the field

```
SELECT 
    job_id, 
    job_title, 
    job_location, 
    job_schedule_type, 
    salary_year_avg, 
    job_posted_date,
    name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    10;
```
Breakdown of top analyst jobs of 2023: 
- **Large Range of Salary:** The top 10 paying roles span from $184,000 to $650,000. This shows high salary potential in the field. 
- **Diverse Employers:** Companies like AT&T, Mantys, and Motional all offer high salaries, showing a diverse set companies with interest in data analysis employement. 

![Top Paying Roles](assets\SQLProject1_1.png)
*Bar graph vizualizing the salary for the top 10 salaries. Made with Tableau.

### 2. Highest Paying Job Skills🔧
To identify the highest-paying skills, the previous query was extended to analyze the skills required across these job roles. This analysis highlights the specific technical skills most commonly associated with top-paying positions.

```
WITH top_paying_jobs AS (
SELECT
    job_id, 
    job_title,
    salary_year_avg,
    name AS company_name 
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    10
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
Breakdown of the skills needed for high paying jobs of 2023: 
- **Diverse Range of Skills:** 
Skills needed for each job is out of a pool of 28 different skills, all having diffferent purposes an functions. Skills include Databricks, Excel, Jupyter, Python, and more. 

- **Skill Amount Per Job** 
Some jobs require few skills like Hybrid/Remote Data Analyst, ERM Data Analyst, and Marketing Analyst while others require a lot including Director Analyst, Associate Director, and Principle Data Analyst.

- **Duplicate Skills** 
Many skills are needed for almost any job in the top 8 including sql, python, and tableau.

![Skills Needed for Job](assets\SQLProject1_2.png)
*Graph depicts skills needed for jobs in the top 8. Graph was made in Tableau. 

### 3. Top In-Demand Skills🔥
Investigated using a new query, the top in demand skills for data analytics were identified. Both the skill and demand count were filtered, showing what is in demand in 2023 for Data Analysis. 

```
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
Breakdown of the in-demand skills in 2023: 

- **Diverse Skillset:**
According to these findings, the top in demand skills for Data Analysts include a range of qualifications including SQL, Excel, Tableau, Power BI, and Python. Each of these skills reuire something different from the employee including coding skills, graphing and dashboard creation, and database management. 

- **Range of Demand** 
While these skills are all valuable and highly suaght after, the range is wide starting from 260 (Power BI) to 7291 (SQL). SQL, being the highest in demand, shows a need for database managment and creation over dashboard and graph creation provided by Power BI and Tableau. 

![In-Demand Skills](assets\SQLProject1_3.png)
*Graph depicts the top 5 skills as well as the demand count. Graph was made in Tableau 

### 4. Top Paying Skills🔧💰

Finding top paying skills can be useful for new analysts to 
pursue something that is both useful and rewarding. This filters 
skills that are high paying regardless of location. 

```
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
```
Breakdown of top paying skills: 

- **Tight Range** 
Most of the top paying skills fall within a range of $100,000 to $179,000. 
These skills include vmware, golang, git, snowflake, and electron. One outlier is present which is SVN, offering a price of around $400,000

- **Abundance of Skills** 
There is no shortage of skills within Data Analytics. While most companies 
seem to hold skills like Excel, SQL, and Power BI in high regard, there are still many skills that meet the $100,000 mark. This query examines the top 50, and all break $100,000 

- **Diversity of Skills** 
Some skills require coding, some managment, others creative insight. No matter what is it, there is no shortage of new things to learn that are valuable within analytics. 

![Top Paying Skills](assets\SQLProject1_4.png)
*Bar Graph shows high paying skills as well as the outlier, SVN. Graph was made in Tableau. 

### 5. Optimal Skills to Learn🥇

Now using the last two querys, we can find what the most optimal skills are to learn. This is based off of a combination of the demand and pay of the skill. This query will order by the highest in demand first, then secondly associate the pay. 

```
WITH skills_demand AS (
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
),

average_salary AS (
SELECT
    skills_job_dim.skill_id, 
    ROUND(AVG (salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
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
ORDER BY 
    demand_count DESC,
    avg_salary DESC
LIMIT 25;
```
Breakdown of the most optimal skills

- **Top 5 Optimal We Have Seen Before** 
In the previous queries, we've seen skills like SQL, Excel, Python, and Tableau be top skills that employers want, and within this query we see the same trend as well as thei paygrade, which all break $85,000 at least, python being the highest. 

- **R in Top 5** 
R also breaks the top 5 with its demand count. It's pay also surpasses skills like Tableau, Power BI, and SQL. 

- **Ordering So Pay is Primary**  
If we change the query so that pay is the primary objective, we can see the list shift. Wanting to keep in demand jobs relevant, I made sure to include that the demand count had to be at least 10. After these changes, skills like Confluence, Snowflake, and Hadoop started to top the list, with less in demand but high pay. 

![In-Demand Skills vs. Their Salary](assets\SQLProject1_5.png)
*These two charts show optimal skills. The top is the demand while the bottom is the salary associated with the skills. This is based off of the first query, with demand coming as the primary ordering. Graphs were made in Tableau. 


# What I Learned 

- **Query Building and Crafting🏗️**
Took the advanced levels of SQL and combined tables enabling for pinpoint results across multiple datasets. 
- **Aggregation👥** 
Used functions like Count() and Avg() to accruatly dpeict real world questions for upcoming Data Analysts. Got comfortable with GROUP BY to make data insight simple and easy to read. 
- **Data Transfer✈️** 
Practiced and got used to downloading, sharing, and importing folders and files into VSCode, Excel, and Tableau to show data from multiple different perspecitves like code, tables, and graphs.
- **Insight and problem Solving🕵️**
Asked real world questions that need precise answers. I turned questions into real querys and was able to show the data that came from those questions
# Conclusions

### Insights. 

These are the insights that emerged from the analysis:

1. **Top-Paying Data Analysis Jobs:**
The range of the top 5 jobs in payment are from $184,000 to $650,000. The top paying job was a Data Analyst getting paid $650,000. All jobs included had remote work included somwwhere. 
2. **Skills for Top-Paying Jobs:** 
The skills needed for these jobs are SQL, Python, and Tableau. Almost all the jobs needed these skills and are critical for data analytics. 
3. **In-Demand Skills:** 
SQL is also the mos t in demand skill within the job market, so learning it is valuable for your data journey. 
4. **Top Paying Skills** 
SVN and Solidity are specialized skills but if learned and mastered they are invaluable for high pay. These are niche skills. 
5. **Optimal Skills to Learn for the Job Market:** 
SQL is at the top for the in demand category that also pays well. The top 5 in demand are also popular for high payt such as Tableau, Power BI, and Python. 

### Closing Thoughts 

Overall this project was to not only show data about trends within the Data Analytics market but to hone my skills in SQL, Tableau, and more than anything, problem solving and applying real world questions to actionable querys and projects. 