use healthcare;
-- creating view with the final results to export it to power bi:
drop view if exists doctors_financials;
create view doctors_financials as
-- a with statment to see revenue by doctor:
with revenue as(select Doctor_ID,round(sum(Amount)) as total_revenue from patient as p
join invoice as i on i.Patient_ID=p.Patient_ID
group by 1),
-- continue with statment to see salary and bonus by doctor:
salary as(select Doctor_ID,round(sum(salary+bonus)) as total_salary  from paycheck
group by 1),
-- continue with statment to see profit by doctor:
profit as(select salary.Doctor_ID,total_revenue,total_salary,total_revenue-total_salary as profit from revenue
join salary on revenue.Doctor_ID=salary.Doctor_ID),
final as(select profit.Doctor_ID,Name,total_revenue,total_salary,profit from profit
join doctor as d on  profit.Doctor_ID=d.Doctor_ID)
select * from final;