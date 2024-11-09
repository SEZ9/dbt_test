-- models/staging/stg_users.sql

with users as (
    select
        userid as user_id,
        username as user_name,
        firstname as first_name,
        lastname as last_name,
        city,
        state
    from {{ source('tickit', 'users') }}  
)

select * from users 