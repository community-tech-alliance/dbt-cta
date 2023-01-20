{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('canned_response_ab3') }}
select
    id,
    text,
    title,
    user_id,
    created_at,
    updated_at,
    campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_canned_response_hashid
from {{ ref('canned_response_ab3') }}
-- canned_response from {{ source('public', '_airbyte_raw_canned_response') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

