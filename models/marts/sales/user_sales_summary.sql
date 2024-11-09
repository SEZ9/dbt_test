WITH user_sales_extended AS (
    -- 引用 intermediate_user_sales
    SELECT 
        u.user_id,
        u.user_name,
        u.total_sales_value,
        u.last_sale_time,
        COUNT(DISTINCT s.event_id) AS total_events_sold,
        COUNT(s.quantity_sold) AS total_sales_count
    FROM {{ ref('intermediate_user_sales') }} u  -- 使用 ref 函数
    LEFT JOIN {{ ref('stg_sales') }} s
        ON u.user_id = s.sales_id
    GROUP BY u.user_id, u.user_name, u.total_sales_value, u.last_sale_time
)

SELECT 
    user_id,
    user_name,
    total_sales_value,
    last_sale_time,
    total_events_sold,
    total_sales_count
FROM user_sales_extended