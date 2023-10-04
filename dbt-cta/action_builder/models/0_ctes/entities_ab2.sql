{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('entities_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(age as {{ dbt_utils.type_bigint() }}) as age,
    cast(dw_id as {{ dbt_utils.type_string() }}) as dw_id,
    cast(nickname as {{ dbt_utils.type_string() }}) as nickname,
    cast(custom_id as {{ dbt_utils.type_string() }}) as custom_id,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(custom_id_1 as {{ dbt_utils.type_string() }}) as custom_id_1,
    cast(custom_id_2 as {{ dbt_utils.type_string() }}) as custom_id_2,
    cast(custom_id_3 as {{ dbt_utils.type_string() }}) as custom_id_3,
    cast(custom_id_4 as {{ dbt_utils.type_string() }}) as custom_id_4,
    cast(interact_id as {{ dbt_utils.type_string() }}) as interact_id,
    cast(middle_name as {{ dbt_utils.type_string() }}) as middle_name,
    cast(voterbase_id as {{ dbt_utils.type_string() }}) as voterbase_id,
    cast(created_by_id as {{ dbt_utils.type_bigint() }}) as created_by_id,
    cast({{ empty_string_to_null('date_of_birth') }} as {{ type_date() }}) as date_of_birth,
    cast(updated_by_id as {{ dbt_utils.type_bigint() }}) as updated_by_id,
    cast(entity_type_id as {{ dbt_utils.type_bigint() }}) as entity_type_id,
    cast(linked_user_id as {{ dbt_utils.type_bigint() }}) as linked_user_id,
    cast(organization_id as {{ dbt_utils.type_string() }}) as organization_id,
    cast(preferred_language as {{ dbt_utils.type_string() }}) as preferred_language,
    {{ cast_to_boolean('calculated_birth_date') }} as calculated_birth_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('entities_ab1') }}
-- entities
where 1 = 1
