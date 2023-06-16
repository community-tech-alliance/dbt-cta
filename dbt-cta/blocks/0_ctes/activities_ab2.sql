{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('activities_ab1') }}
select
    cast(recipient_type as {{ dbt_utils.type_string() }}) as recipient_type,
    cast(trackable_id as {{ dbt_utils.type_bigint() }}) as trackable_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(owner_id as {{ dbt_utils.type_bigint() }}) as owner_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(trackable_type as {{ dbt_utils.type_string() }}) as trackable_type,
    cast(parameters as {{ dbt_utils.type_string() }}) as parameters,
    cast(key as {{ dbt_utils.type_string() }}) as key,
    cast(owner_type as {{ dbt_utils.type_string() }}) as owner_type,
    cast(recipient_id as {{ dbt_utils.type_bigint() }}) as recipient_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('activities_ab1') }}
-- activities
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

