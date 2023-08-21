{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ocdids_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(ocdid_name as {{ dbt_utils.type_string() }}) as ocdid_name,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(ocdid_value as {{ dbt_utils.type_string() }}) as ocdid_value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ocdids_ab1') }}
-- ocdids
where 1 = 1
