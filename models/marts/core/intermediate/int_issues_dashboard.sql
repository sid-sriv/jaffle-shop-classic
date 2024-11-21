{{ config(materialized='table') }}

WITH joined_data AS (
    SELECT
          issues.description
        , vehicles.vehicle_id
        , vehicles.vehicle_meter_value
        , vehicles.vehicle_meter_unit
        , metadata.created_by_id
        , metadata.closed_by_id
        , metadata.created_at_cst
        , metadata.resolved_at_cst
        , issues.state
        , issues.reported_at_cst
    FROM {{ ref('int_issues') }} AS issues
    LEFT JOIN {{ ref('int_vehicles') }} AS vehicles
        ON issues.vehicle_id = vehicles.vehicle_id
    LEFT JOIN {{ ref('int_metadata') }} AS metadata
        ON issues.created_by_id = metadata.created_by_id
)

SELECT
      description
    , vehicle_id
    , vehicle_meter_value
    , vehicle_meter_unit
    , created_by_id
    , closed_by_id
    , created_at_cst
    , resolved_at_cst
    , state
    , reported_at_cst
    , COUNT(*) AS issue_count
    , DATE_TRUNC('week', reported_at_cst) AS week_start
    , MIN(reported_at_cst) AS first_reported
    , MAX(resolved_at_cst) AS last_resolved

FROM joined_data

GROUP BY state, week_start, description, vehicle_id, vehicle_meter_value, vehicle_meter_unit, created_by_id, closed_by_id, created_at_cst, resolved_at_cst, reported_at_cst