-- models/staging/stg_sales.sql

with sales as (
    select
        salesid as sales_id,
        buyerid as buyer_id,
        eventid as event_id,
        qtysold as quantity_sold,
        pricepaid as price_paid,
        commission,
        saletime as sale_time
    from {{ source('tickit', 'sales') }} 
)

select * from sales