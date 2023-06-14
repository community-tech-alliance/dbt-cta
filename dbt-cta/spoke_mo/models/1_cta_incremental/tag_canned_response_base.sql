{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('tag_canned_response_ab3') }}
select
    canned_response_id,
    tag_id,
    created_at,
    id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tag_canned_response_hashid
from {{ ref('tag_canned_response_ab3') }}
-- tag_canned_response from {{ source('cta', '_airbyte_raw_tag_canned_response') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

