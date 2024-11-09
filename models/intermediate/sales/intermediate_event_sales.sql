WITH event_sales_aggregated AS (
    SELECT 
        s.event_id,
        SUM(s.quantity_sold) AS total_tickets_sold,
        SUM(s.price_paid) AS total_sales_value
    FROM {{ ref('stg_sales') }} s
    GROUP BY s.event_id
)

SELECT 
    e.event_id ,
    e.event_name,
    esa.total_tickets_sold,
    esa.total_sales_value
FROM {{ ref('stg_event') }} e
LEFT JOIN event_sales_aggregated esa
    ON e.event_id = esa.event_id