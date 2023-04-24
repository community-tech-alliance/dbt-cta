{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('profileorganizationtags_ab1') }}
select
    cast(profileEid as {{ dbt_utils.type_string() }}) as profileEid,
    cast(tagId as {{ dbt_utils.type_bigint() }}) as tagId,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('profileorganizationtags_ab1') }}
-- profileorganizationtags
where 1 = 1

