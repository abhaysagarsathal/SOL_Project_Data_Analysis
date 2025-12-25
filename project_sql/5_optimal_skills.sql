with skill_demand as(
    select 
        skills_dim.skill_id,
        skills_dim.skills,
        count(*) as demand_count
    From job_postings_fact
    inner join skills_job_dim  on job_postings_fact.job_id=skills_job_dim.job_id
    inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
    WHERE
        job_title_short='Data Analyst' AND
        job_work_from_home=TRUE
         AND salary_year_avg is not NULL
    group by
        skills_dim.skill_id
), average_salary as(
    select 
        skills_dim.skill_id,
        skills_dim.skills,
        round(avg(salary_year_avg),0) as avg_salary
    From job_postings_fact
    inner join skills_job_dim  on job_postings_fact.job_id=skills_job_dim.job_id
    inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
    WHERE
        job_title_short='Data Analyst'
        AND salary_year_avg is not NULL
        and job_work_from_home=TRUE 
        
    group by
        skills_dim.skill_id 
)

select
    skill_demand.skill_id,
    skill_demand.skills,
    demand_count,
    avg_salary
From
    skill_demand
inner join average_salary on skill_demand.skill_id=average_salary.skill_id
where 
    demand_count>10
order BY
    avg_salary DESC,
    demand_count desc
    
limit 25

