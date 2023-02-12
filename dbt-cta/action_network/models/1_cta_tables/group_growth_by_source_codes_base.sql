{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('group_growth_by_source_codes_ab3') }}
select
    id,
    end_at,
    group_id,
    start_at,
    created_at,
    updated_at,
    source_code,
    total_count,
    new_users_count,
    last_subscription_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_group_growth_by_source_codes_hashid
from {{ ref('group_growth_by_source_codes_ab3') }}
-- group_growth_by_source_codes from {{ source('cta', '_airbyte_raw_group_growth_by_source_codes') }}
where 1 = 1
