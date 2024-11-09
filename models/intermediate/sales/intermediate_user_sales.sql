WITH user_sales_aggregated AS (
    SELECT 
        u.user_id,
        u.user_name,
        SUM(s.price_paid) AS total_sales_value,
        COUNT(s.quantity_sold) AS total_tickets_sold,
        DATE(s.sale_time) AS sale_date  -- 提取 listtime 的日期部分
    FROM {{ ref('stg_sales') }} s
    LEFT JOIN {{ ref('stg_users') }} u
        ON s.sales_id = u.user_id
    GROUP BY u.user_id, u.user_name, DATE(s.sale_time)
),
sales_with_date AS (
    SELECT
        usa.user_id,
        usa.user_name,
        usa.total_sales_value,
        usa.total_tickets_sold,
        d.date_day,
        d.year,
        d.month,
        d.day
    FROM user_sales_aggregated usa
    LEFT JOIN {{ ref('stg_date') }} d
        ON usa.sale_date = d.date_day  -- 关联到 date 表的日期字段
)

SELECT * FROM sales_with_date
