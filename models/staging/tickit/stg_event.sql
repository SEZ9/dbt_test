-- models/staging/stg_event.sql

with event as (
    select
        eventid as event_id,
        eventname as event_name,
        venueid as venue_id,
        starttime as start_time
    from {{ source('tickit', 'event') }}  
)

select * from event