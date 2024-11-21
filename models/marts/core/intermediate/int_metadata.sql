{{ config(materialized='table') }}

SELECT DISTINCT
      created_by_id
    , closed_by_id
    
    , {{ convert_timezone_cst('created_at') }} AS created_at_cst
    , {{ convert_timezone_cst('updated_at') }} AS updated_at_cst
    , {{ convert_timezone_cst('resolved_at') }} AS resolved_at_cst
    
FROM {{ ref('stg_issues') }}

WHERE created_by_id IS NOT NULL OR closed_by_id IS NOT NULL