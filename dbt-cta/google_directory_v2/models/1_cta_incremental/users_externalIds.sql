{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- Final base SQL model
-- depends_on: {{ ref('users_externalIds_ab3') }}, {{ ref('users') }}
select
    _airbyte_users_hashid,
    type,
    value,
    customType,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_externalIds_hashid,
    current_timestamp() as _airbyte_normalized_at
from {{ ref('users_externalIds_ab3') }}
