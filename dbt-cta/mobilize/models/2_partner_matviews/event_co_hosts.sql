{{
    config(
        cluster_by="_airbyte_extracted_at",
        partition_by={
            "field": "_airbyte_extracted_at",
            "data_type": "timestamp",
            "granularity": "day",
        },
        unique_key="_airbyte_event_co_hosts_hashid",
    )
}}

-- depends_on: {{ source('cta', 'event_co_hosts_base') }}
select
    _airbyte_event_co_hosts_hashid,
    max(id) as id,
    max(email) as email,
    max(user_id) as user_id,
    max(event_id) as event_id,
    max(created_date) as created_date,
    max(modified_date) as modified_date,
    max(_airbyte_raw_id) as _airbyte_raw_id,
    max(_airbyte_extracted_at) as _airbyte_extracted_at
from {{ source("cta", "event_co_hosts_base") }}
group by _airbyte_event_co_hosts_hashid
