{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- Final base SQL model
-- depends_on: {{ ref('group_members_ab3') }}, {{ ref('users') }}
select
    id,
    kind,
    role,
    type,
    email,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_group_members_hashid,
    current_timestamp() as _airbyte_normalized_at
from {{ ref('group_members_ab3') }}
