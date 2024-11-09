WITH raw_date AS (
    -- 从原始 date 表中提取数据
    SELECT
        dateid as date_id,
        caldate as date_day,
        year,
        month,
        day,
        week
    FROM {{ source('tickit', 'date') }}  -- 引用原始的 date 表
)

SELECT
    date_id,
    date_day,
    year,
    month,
    day,
    week
FROM raw_date