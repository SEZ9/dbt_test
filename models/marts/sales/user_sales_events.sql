-- models/marts/user_sales_events.sql

with sales as (
    select * from {{ ref('stg_sales') }}
),
users as (
    select * from {{ ref('stg_users') }}
),
events as (
    select * from {{ ref('stg_event') }}
)

select
    users.user_id,
    users.user_name,
    sales.sales_id,
    events.event_name,
    sales.quantity_sold,
    sales.price_paid,
    sales.sale_time
from sales
join users on sales.buyer_id = users.user_id
join events on sales.event_id = events.event_id