{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('collections_roles_ab1') }}
select
    cast(collection_id as {{ dbt_utils.type_bigint() }}) as collection_id,
    cast(role_id as {{ dbt_utils.type_bigint() }}) as role_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('collections_roles_ab1') }}
-- collections_roles
where 1 = 1

