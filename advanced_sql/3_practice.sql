with quater_jobs as (
    select *
    from january_jobs
    UNION 
    select *
    from february_jobs
    UNION 
    select *
    from march_jobs
)

select *
from quater_jobs
where 
    salary_year_avg> 70000