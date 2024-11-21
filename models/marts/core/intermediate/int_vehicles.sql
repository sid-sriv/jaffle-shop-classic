{{ config(materialized='table') }}

SELECT DISTINCT
      vehicle_id
    , vehicle_meter_value
    , vehicle_meter_unit

FROM {{ ref('stg_issues') }}

WHERE vehicle_id IS NOT NULL