{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('uploads_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(key as {{ dbt_utils.type_string() }}) as key,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(bucket as {{ dbt_utils.type_string() }}) as bucket,
    cast(counts as {{ dbt_utils.type_string() }}) as counts,
    cast(result as {{ dbt_utils.type_string() }}) as result,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(mappings as {{ dbt_utils.type_string() }}) as mappings,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(upload_type as {{ dbt_utils.type_string() }}) as upload_type,
    cast(created_by_id as {{ dbt_utils.type_bigint() }}) as created_by_id,
    cast(entity_type_id as {{ dbt_utils.type_bigint() }}) as entity_type_id,
    cast(visibility_status as {{ dbt_utils.type_string() }}) as visibility_status,
    cast(processing_options as {{ dbt_utils.type_string() }}) as processing_options,
    cast(identification_field as {{ dbt_utils.type_string() }}) as identification_field,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('uploads_ab1') }}
-- uploads
where 1 = 1

