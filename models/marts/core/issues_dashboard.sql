{{ config(materialized='view') }}

WITH final_issues AS (
    SELECT
        description,
        vehicle_id,
        vehicle_meter_value,
        created_by_id,
        resolved_at_cst,
        state,
        reported_at_cst,
        issue_count,
        week_start
    FROM {{ ref('int_issues_dashboard') }}
)

SELECT 
    description,
    vehicle_id,
    vehicle_meter_value,
    created_by_id,
    resolved_at_cst,
    state,
    reported_at_cst,
    issue_count,
    week_start

FROM final_issues