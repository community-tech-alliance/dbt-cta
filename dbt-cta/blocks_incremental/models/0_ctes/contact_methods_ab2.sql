{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('contact_methods_ab1') }}
select
    cast(extension as {{ dbt_utils.type_string() }}) as extension,
    cast(contact_type as {{ dbt_utils.type_string() }}) as contact_type,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    {{ cast_to_boolean('invalid') }} as invalid,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(content as {{ dbt_utils.type_string() }}) as content,
    cast(person_id as {{ dbt_utils.type_bigint() }}) as person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('contact_methods_ab1') }}
-- contact_methods
where 1 = 1
