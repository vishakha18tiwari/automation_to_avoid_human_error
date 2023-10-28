-- Loader table query
insert into ${database_name}.${schema_name}.ldr_employee_details A
(
    employee_id,
    employee_first_name,
    employee_last_name,
    employee_status
)
select 
    employee_id,
    employee_first_name,
    employee_last_name,
    employee_status
from employee_base_table;

-- Final table query
INSERT into ${database_name}.${schema_name}.final_employee_details
(
    employee_id,
    employee_first_name,
    employee_last_name
)
select
    employee_id,
    employee_first_name,
    employee_last_name
from ldr_employee_details
where employee_status ='T';

update ${database_name}.${schema_name}.final_employee_details
set employee_status ='Active';