{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('customizations_export_ab1') }}
select
    cast(custom_field_slug as {{ dbt_utils.type_string() }}) as custom_field_slug,
    cast(custom_field_name as {{ dbt_utils.type_string() }}) as custom_field_name,
    cast(reportable_id as {{ dbt_utils.type_bigint() }}) as reportable_id,
    cast(voterbase_id as {{ dbt_utils.type_string() }}) as voterbase_id,
    cast(customizable_id as {{ dbt_utils.type_bigint() }}) as customizable_id,
    cast(customizable_type as {{ dbt_utils.type_string() }}) as customizable_type,
    cast(reported_by_email as {{ dbt_utils.type_string() }}) as reported_by_email,
    cast(custom_field_id as {{ dbt_utils.type_bigint() }}) as custom_field_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('exported_at') }} as {{ type_date() }}) as exported_at,
    cast(reportable_type as {{ dbt_utils.type_string() }}) as reportable_type,
    cast(van_id as {{ dbt_utils.type_string() }}) as van_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(fullname as {{ dbt_utils.type_string() }}) as fullname,
    cast(reported_by_fullname as {{ dbt_utils.type_string() }}) as reported_by_fullname,
    cast(value as {{ dbt_utils.type_string() }}) as value,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customizations_export_ab1') }}
-- customizations_export
where 1 = 1

