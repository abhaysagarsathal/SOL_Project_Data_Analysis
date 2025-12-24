with remote_job_skills as (
SELECT
    skill_id,
    count(*) as skill_count
from skills_job_dim  as skills_to_job
inner join job_postings_fact on skills_to_job.job_id=job_postings_fact.job_id
WHERE
    job_postings_fact.job_work_from_home=TRUE
group BY
    skill_id
)

select 
    skills.skill_id,
    skills,
    skill_count
FROM
    remote_job_skills
inner join skills_dim as skills on remote_job_skills.skill_id=skills.skill_id
order BY
    skill_count desc
limit 5;