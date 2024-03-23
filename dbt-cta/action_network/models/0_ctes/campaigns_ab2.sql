{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(hidden as {{ dbt_utils.type_bigint() }}) as hidden,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(language as {{ dbt_utils.type_string() }}) as language,
    cast(permalink as {{ dbt_utils.type_string() }}) as permalink,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(first_publish as {{ dbt_utils.type_bigint() }}) as first_publish,
    cast(first_permalink as {{ dbt_utils.type_string() }}) as first_permalink,
    cast(photo_file_name as {{ dbt_utils.type_string() }}) as photo_file_name,
    cast(photo_file_size as {{ dbt_utils.type_bigint() }}) as photo_file_size,
    cast(description_text as {{ dbt_utils.type_string() }}) as description_text,
    cast(image_attribution as {{ dbt_utils.type_string() }}) as image_attribution,
    cast(photo_content_type as {{ dbt_utils.type_string() }}) as photo_content_type,
    cast(administrative_title as {{ dbt_utils.type_string() }}) as administrative_title,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_ab1') }}
-- campaigns
where 1 = 1
