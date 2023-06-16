{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('addresses_ab1') }}
select
    cast(line_three as {{ dbt_utils.type_string() }}) as line_three,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(line_one as {{ dbt_utils.type_string() }}) as line_one,
    cast(county as {{ dbt_utils.type_string() }}) as county,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(zipcode as {{ dbt_utils.type_string() }}) as zipcode,
    cast(county_id as {{ dbt_utils.type_bigint() }}) as county_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(line_four as {{ dbt_utils.type_string() }}) as line_four,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(line_two as {{ dbt_utils.type_string() }}) as line_two,
    cast(tsv_full_address as {{ dbt_utils.type_string() }}) as tsv_full_address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('addresses_ab1') }}
-- addresses
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

