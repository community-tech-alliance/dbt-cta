{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('field_names_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast(hidden as {{ dbt_utils.type_bigint() }}) as hidden,
    cast(owner_id as {{ dbt_utils.type_bigint() }}) as owner_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(owner_type as {{ dbt_utils.type_string() }}) as owner_type,
    cast(syndicated as {{ dbt_utils.type_bigint() }}) as syndicated,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(validation_regexp as {{ dbt_utils.type_string() }}) as validation_regexp,
    cast(validation_description as {{ dbt_utils.type_string() }}) as validation_description,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('field_names_ab1') }}
-- field_names
where 1 = 1
