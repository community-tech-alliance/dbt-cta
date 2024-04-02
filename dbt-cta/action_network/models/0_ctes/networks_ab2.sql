{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('networks_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(terms as {{ dbt_utils.type_string() }}) as terms,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(sms_enabled as {{ dbt_utils.type_bigint() }}) as sms_enabled,
    cast(ip_pool_name as {{ dbt_utils.type_string() }}) as ip_pool_name,
    cast(csv_file_name as {{ dbt_utils.type_string() }}) as csv_file_name,
    cast(csv_file_size as {{ dbt_utils.type_bigint() }}) as csv_file_size,
    cast(csv_updated_at as {{ dbt_utils.type_string() }}) as csv_updated_at,
    cast(csv_content_type as {{ dbt_utils.type_string() }}) as csv_content_type,
    cast(lock_custom_fields as {{ dbt_utils.type_bigint() }}) as lock_custom_fields,
    cast(top_level_group_id as {{ dbt_utils.type_bigint() }}) as top_level_group_id,
    cast(opted_in_mobile_number as {{ dbt_utils.type_bigint() }}) as opted_in_mobile_number,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('networks_ab1') }}
-- networks
where 1 = 1
