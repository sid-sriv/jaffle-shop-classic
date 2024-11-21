/* Issues Staging Model */

select distinct

    /* Primary key */
    "DESCRIPTION" as description

    /* Foreign keys */
    , "CREATED_BY_ID" as created_by_id
    , "CLOSED_BY_ID" as closed_by_id
    , "VEHICLE_ID" as vehicle_id

    /* Metrics and values */
    , cast("VEHICLE_METER_VALUE" as float) as vehicle_meter_value
    , "VEHICLE_METER_UNIT" as vehicle_meter_unit
    , "VEHICLE_METER_AT" as vehicle_meter_at

    /* Timestamps */
    , "REPORTED_AT" as reported_at
    , "RESOLVED_AT" as resolved_at
    , "CREATED_AT" as created_at
    , "UPDATED_AT" as updated_at

    /* Notes and statuses */
    , "RESOLVED_NOTE" as resolved_note
    , "STATE" as state

    /* Custom fields */
    , "CUSTOM_FIELDS" as custom_fields

from {{ source('raw', 'issues') }} as issues