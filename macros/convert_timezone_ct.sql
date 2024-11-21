{#  Convert the timestamp-with-timezone to Central Time to match HQ, and cast it as a timestamp-without-timezone
    because Tableau mangles timestamp-with-timezone values. #}
{% macro convert_timezone_cst(timestamp_tz) %}
    convert_timezone('UTC', 'America/Chicago', {{ timestamp_tz }})::timestamp_ntz
{% endmacro %}