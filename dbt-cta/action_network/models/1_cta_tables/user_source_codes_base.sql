{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_source_codes_ab3') }}
select
    id,
    user_id,
    new_user,
    owner_id,
    created_at,
    owner_type,
    updated_at,
    source_code_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_source_codes_hashid
from {{ ref('user_source_codes_ab3') }}
-- user_source_codes from {{ source('cta', '_airbyte_raw_user_source_codes') }}
where 1 = 1

