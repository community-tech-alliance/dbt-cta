{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('media_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast({{ adapter.quote('hash') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('hash') }},
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(file_name as {{ dbt_utils.type_string() }}) as file_name,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(visibility as {{ dbt_utils.type_string() }}) as visibility,
    cast(media_status as {{ dbt_utils.type_string() }}) as media_status,
    cast(ad_account_id as {{ dbt_utils.type_string() }}) as ad_account_id,
    cast(download_link as {{ dbt_utils.type_string() }}) as download_link,
    {{ cast_to_boolean('is_demo_media') }} as is_demo_media,
    cast(image_metadata as {{ type_json() }}) as image_metadata,
    cast(video_metadata as {{ type_json() }}) as video_metadata,
    cast(file_size_in_bytes as {{ dbt_utils.type_bigint() }}) as file_size_in_bytes,
    cast(duration_in_seconds as {{ dbt_utils.type_float() }}) as duration_in_seconds,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('media_ab1') }}
-- media
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}

