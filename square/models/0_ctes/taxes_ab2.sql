{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('taxes_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(version as {{ dbt_utils.type_bigint() }}) as version,
    cast(tax_data as {{ type_json() }}) as tax_data,
    {{ cast_to_boolean('is_deleted') }} as is_deleted,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    absent_at_location_ids,
    {{ cast_to_boolean('present_at_all_locations') }} as present_at_all_locations,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('taxes_ab1') }}
-- taxes
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

