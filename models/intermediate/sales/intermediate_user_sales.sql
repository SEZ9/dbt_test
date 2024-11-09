WITH user_sales_aggregated AS (
    -- 聚合每个 seller 的总销售额和最近一次的销售时间
    SELECT 
        s.sales_id,
        SUM(s.price_paid) AS total_sales_value,
        MAX(s.sale_time) AS last_sale_time
    FROM {{ ref('stg_sales') }} s
    GROUP BY s.sales_id
)

SELECT 
    u.user_id ,
    u.user_name,
    u.city AS user_city,
    usa.total_sales_value,
    usa.last_sale_time
FROM {{ ref('stg_users') }} u
-- 这里假设 sales_id 对应用户表中的 userid
LEFT JOIN user_sales_aggregated usa
    ON u.user_id = usa.sales_id