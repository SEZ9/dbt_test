SELECT
    user_id,
    user_name ,
    total_sales_value,
    total_tickets_sold,
    date_day
FROM {{ ref('intermediate_user_sales') }}