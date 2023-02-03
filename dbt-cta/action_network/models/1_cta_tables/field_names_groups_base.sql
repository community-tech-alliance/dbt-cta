{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('field_names_groups_ab3') }}
select
    id,
    hidden,
    group_id,
    field_name_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_field_names_groups_hashid
from {{ ref('field_names_groups_ab3') }}
-- field_names_groups from {{ source('cta', '_airbyte_raw_field_names_groups') }}
where 1 = 1

