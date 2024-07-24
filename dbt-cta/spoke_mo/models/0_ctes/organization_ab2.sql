{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('organization_ab1') }}
select
    cast(features as {{ dbt_utils.type_string() }}) as features,
    cast(texting_hours_start as {{ dbt_utils.type_bigint() }}) as texting_hours_start,
    {{ cast_to_boolean('texting_hours_enforced') }} as texting_hours_enforced,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(texting_hours_end as {{ dbt_utils.type_bigint() }}) as texting_hours_end,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('organization_ab1') }}
-- organization
where 1 = 1


