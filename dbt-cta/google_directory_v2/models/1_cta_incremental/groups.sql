{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- Final base SQL model
-- depends_on: {{ ref('groups_ab3') }}
select
    id,
    etag,
    kind,
    name,
    email,
    description,
    adminCreated,
    directMembersCount,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_groups_hashid,
    current_timestamp() as _airbyte_normalized_at
from {{ ref('groups_ab3') }}
