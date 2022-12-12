{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
) }}
-- Final base SQL model
-- depends_on: {{ ref('companies_ab2') }}
select
    id,
    name,
    note,
    SAFE_CAST(created_at as timestamp) as created_at,
    SAFE_CAST(updated_at as timestamp) as updated_at,
    description,
    JSON_EXTRACT_SCALAR(custom_fields, '$.member_code') as custom_member_code,
    JSON_EXTRACT_SCALAR(custom_fields, '$.secondary_dampt_strategist') as custom_secondary_dampt_strategist,
    JSON_EXTRACT_SCALAR(custom_fields, '$.primary_dampt_strategist') as custom_primary_dampt_strategist,
    JSON_EXTRACT_SCALAR(custom_fields, '$.pod') as custom_pod,
    JSON_EXTRACT_SCALAR(custom_fields, '$.mini_pod') as custom_mini_pod,
    JSON_EXTRACT_SCALAR(custom_fields, '$.internal_affiliate_list') as custom_internal_affiliate_list,
    domains,
    _airbyte_ab_id,
    _airbyte_emitted_at,
from {{ ref('companies_ab2') }}
-- companies from {{ source('cta', '_airbyte_raw_companies') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

