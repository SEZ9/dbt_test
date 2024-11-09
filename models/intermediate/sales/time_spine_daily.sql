SELECT
    date_day
FROM {{ ref('stg_date') }}  -- 引用现有的 stg_date 表