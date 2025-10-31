{{
    config(
        materialized='ephemeral',
        tags = [
            'airbyte-usage'
        ]
    )
}}

select
    sourceId as source_id,
    sourceType as source_type,
    case sourceType  -- db and file syncs use bytes, everything else uses records
        when "postgres" then "bytes"
        when "redshift" then "bytes"
        when "mysql" then "bytes"
        else "records"
    end as billing_type
from {{ source('airbyte_usage', 'sources') }}
