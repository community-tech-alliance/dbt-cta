{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('lists_people_ab1') }}
select
    cast(list_id as {{ dbt_utils.type_bigint() }}) as list_id,
    cast(person_id as {{ dbt_utils.type_bigint() }}) as person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('lists_people_ab1') }}
-- lists_people
where 1 = 1

