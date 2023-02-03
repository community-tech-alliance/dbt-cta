{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('catalist_syncs_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(token as {{ dbt_utils.type_string() }}) as token,
    cast(active as {{ dbt_utils.type_bigint() }}) as active,
    cast(client_id as {{ dbt_utils.type_string() }}) as client_id,
    cast(source_id as {{ dbt_utils.type_bigint() }}) as source_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(dwid_field as {{ dbt_utils.type_string() }}) as dwid_field,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(catalist_id as {{ dbt_utils.type_string() }}) as catalist_id,
    cast(source_type as {{ dbt_utils.type_string() }}) as source_type,
    cast(client_secret as {{ dbt_utils.type_string() }}) as client_secret,
    cast(token_expires_in as {{ dbt_utils.type_bigint() }}) as token_expires_in,
    cast(token_updated_at as {{ dbt_utils.type_bigint() }}) as token_updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('catalist_syncs_ab1') }}
-- catalist_syncs
where 1 = 1

