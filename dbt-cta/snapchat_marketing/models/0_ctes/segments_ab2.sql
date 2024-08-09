{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('segments_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    visible_to,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(source_type as {{ dbt_utils.type_string() }}) as source_type,
    cast(ad_account_id as {{ dbt_utils.type_string() }}) as ad_account_id,
    cast(upload_status as {{ dbt_utils.type_string() }}) as upload_status,
    cast(organization_id as {{ dbt_utils.type_string() }}) as organization_id,
    cast(retention_in_days as {{ dbt_utils.type_bigint() }}) as retention_in_days,
    cast(targetable_status as {{ dbt_utils.type_string() }}) as targetable_status,
    cast(approximate_number_users as {{ dbt_utils.type_bigint() }}) as approximate_number_users,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('segments_ab1') }}
-- segments
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}

