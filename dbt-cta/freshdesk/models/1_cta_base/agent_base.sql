{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('agents_ab2') }}
select
    id,
    available,
    occasional,
    signature,
    ticket_scope,
    SAFE_CAST(created_at as timestamp) as created_at,
    SAFE_CAST(updated_at as timestamp) as updated_at,
    SAFE_CAST(available_since as timestamp) as available_since,
    SAFE_CAST(JSON_EXTRACT_SCALAR(contact, '$.active') as boolean) as contact_active,
    JSON_EXTRACT_SCALAR(contact, '$.email') as contact_email,
    JSON_EXTRACT_SCALAR(contact, '$.job_title') as contact_job_title,
    JSON_EXTRACT_SCALAR(contact, '$.language') as contact_language,
    SAFE_CAST(JSON_EXTRACT_SCALAR(contact, '$.last_login_at') as timestamp) as contact_last_login_at,
    JSON_EXTRACT_SCALAR(contact, '$.mobile') as contact_mobile,
    JSON_EXTRACT_SCALAR(contact, '$.name') as contact_name,
    JSON_EXTRACT_SCALAR(contact, '$.phone') as contact_phone,
    JSON_EXTRACT_SCALAR(contact, '$.time_zone') as contact_time_zone,
    SAFE_CAST(JSON_EXTRACT_SCALAR(contact, '$.created_at') as timestamp) as contact_created_at,
    SAFE_CAST(JSON_EXTRACT_SCALAR(contact, '$.updated_at') as timestamp) as contact_updated_at,
    type,
    last_active_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
from {{ ref('agents_ab2') }}
-- agents from {{ source('cta', '_airbyte_raw_agents') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

