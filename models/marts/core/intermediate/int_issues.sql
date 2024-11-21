{{ config(materialized='table') }}

SELECT DISTINCT
    -- Identifiers
      description
    , created_by_id
    , closed_by_id
    , vehicle_id

    -- Metrics and values
    , vehicle_meter_value
    , vehicle_meter_unit
    , vehicle_meter_at

    -- Custom fields
    , custom_fields

    -- Timestamps converted to CST
    , {{ convert_timezone_cst('reported_at') }} AS reported_at_cst
    , {{ convert_timezone_cst('resolved_at') }} AS resolved_at_cst
    , {{ convert_timezone_cst('created_at') }} AS created_at_cst
    , {{ convert_timezone_cst('updated_at') }} AS updated_at_cst

    -- Statuses and notes
    , resolved_note
    , state

FROM {{ ref('stg_issues') }}

WHERE state IS NOT NULL