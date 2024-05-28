{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('catalist_syncs_ab4') }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_catalist_syncs_hashid
from {{ ref('catalist_syncs_ab4') }}