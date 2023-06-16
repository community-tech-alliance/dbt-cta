{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('announcements_views_ab1') }}
select
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(announcement_id as {{ dbt_utils.type_bigint() }}) as announcement_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('announcements_views_ab1') }}
-- announcements_views
where 1 = 1

