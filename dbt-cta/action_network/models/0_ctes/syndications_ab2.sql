{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('syndications_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(stats as {{ dbt_utils.type_string() }}) as stats,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(hidden as {{ dbt_utils.type_bigint() }}) as hidden,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(email_id as {{ dbt_utils.type_bigint() }}) as email_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(action_id as {{ dbt_utils.type_bigint() }}) as action_id,
    cast(permalink as {{ dbt_utils.type_string() }}) as permalink,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(action_type as {{ dbt_utils.type_string() }}) as action_type,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(first_publish as {{ dbt_utils.type_bigint() }}) as first_publish,
    cast(salesforce_id as {{ dbt_utils.type_string() }}) as salesforce_id,
    cast(display_creator as {{ dbt_utils.type_bigint() }}) as display_creator,
    cast(first_permalink as {{ dbt_utils.type_string() }}) as first_permalink,
    cast(photo_file_name as {{ dbt_utils.type_string() }}) as photo_file_name,
    cast(photo_file_size as {{ dbt_utils.type_bigint() }}) as photo_file_size,
    cast(originating_system as {{ dbt_utils.type_string() }}) as originating_system,
    cast(photo_content_type as {{ dbt_utils.type_string() }}) as photo_content_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('syndications_ab1') }}
-- syndications
where 1 = 1

