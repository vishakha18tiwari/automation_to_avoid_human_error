-- Loader table query
insert into ${database_name}.${schema_name}.ldr_event_details 
(
    event_id,
    event_name,
    event_date,
    event_fees,
    event_active
)
select 
    event_id,
    event_name,
    event_date,
    event_fees,
    event_active
from ${database_name}.${schema_name}.event_base_table ;

--- DELETE NULL EVENTS

delete from ${database_name}.${schema_name}.ldr_event_details A
where event_active is null;

-- Final table query
INSERT into ${database_name}.${schema_name}.final_event_details A
(
    event_id,
    event_name,
    event_date,
    event_fees,
    event_active
)
select
    eevent_id,
    event_name,
    event_date,
    event_fees,
    event_active
where employee_status ='T';

--------- UPDATE QUERY

update ${database_name}.${schema_name}.ldr_event_details
set employee_status ='Active';
