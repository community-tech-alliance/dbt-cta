{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('address_districts_ab1') }}
select
    cast(address_id as {{ dbt_utils.type_bigint() }}) as address_id,
    cast(district_id as {{ dbt_utils.type_bigint() }}) as district_id,
    cast(district_type as {{ dbt_utils.type_bigint() }}) as district_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('address_districts_ab1') }}
-- address_districts
where 1 = 1

