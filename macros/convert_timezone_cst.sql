{#  Convert the timestamp-with-timezone to Central Time to match HQ, and cast it as a timestamp-without-timezone
    because Tableau mangles timestamp-with-timezone values. #}
{% macro convert_timezone_cst(timestamp_tz) -%}

    -- Convert the timestamp to CST by adjusting the timezone offset
    ({{ timestamp_tz }} AT TIME ZONE 'UTC' AT TIME ZONE 'America/Chicago')::timestamptz

{%- endmacro %}