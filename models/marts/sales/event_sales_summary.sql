WITH event_sales_extended AS (
    -- 从 intermediate_event_sales 中获取每个事件的汇总数据
    SELECT 
        e.event_id,
        e.event_name,
        e.total_tickets_sold,
        e.total_sales_value,
        AVG(s.price_paid) AS avg_ticket_price,  -- 计算平均每张票的价格
        MAX(s.sale_time) AS last_sale_time           -- 计算最近的销售时间
    FROM {{ ref('intermediate_event_sales') }} e
    LEFT JOIN {{ ref('stg_sales') }} s
        ON e.event_id = s.event_id
    GROUP BY e.event_id, e.event_name, e.total_tickets_sold, e.total_sales_value
)

SELECT 
    event_id,
    event_name,
    total_tickets_sold,
    total_sales_value,
    avg_ticket_price,
    last_sale_time
FROM event_sales_extended