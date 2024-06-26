{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('networks_users_ab4') }}
select
    id,
    user_id,
    created_at,
    network_id,
    updated_at,
    accepted_terms,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_networks_users_hashid
from {{ ref('networks_users_ab4') }}
