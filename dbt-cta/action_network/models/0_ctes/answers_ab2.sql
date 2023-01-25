{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('answers_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(street as {{ dbt_utils.type_string() }}) as street,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(form_id as {{ dbt_utils.type_bigint() }}) as form_id,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(tag_list as {{ dbt_utils.type_string() }}) as tag_list,
    cast(zip_code as {{ dbt_utils.type_string() }}) as zip_code,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(display_name as {{ dbt_utils.type_string() }}) as display_name,
    cast(custom_fields as {{ dbt_utils.type_string() }}) as custom_fields,
    cast(message_to_target as {{ dbt_utils.type_string() }}) as message_to_target,
    cast(originating_system as {{ dbt_utils.type_string() }}) as originating_system,
    cast(updates_from_creator as {{ dbt_utils.type_bigint() }}) as updates_from_creator,
    cast(updates_from_sponsor as {{ dbt_utils.type_bigint() }}) as updates_from_sponsor,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('answers_ab1') }}
-- answers
where 1 = 1

