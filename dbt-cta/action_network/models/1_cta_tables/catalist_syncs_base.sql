{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('catalist_syncs_ab3') }}
select
    id,
    token,
    active,
    client_id,
    source_id,
    created_at,
    dwid_field,
    updated_at,
    catalist_id,
    source_type,
    client_secret,
    token_expires_in,
    token_updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_catalist_syncs_hashid
from {{ ref('catalist_syncs_ab3') }}
-- catalist_syncs from {{ source('cta', '_airbyte_raw_catalist_syncs') }}
where 1 = 1
