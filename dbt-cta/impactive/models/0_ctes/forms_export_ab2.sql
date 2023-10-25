{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('forms_export_ab1') }}
select
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(contact_id as {{ dbt_utils.type_bigint() }}) as contact_id,
    cast(contact_referral_id as {{ dbt_utils.type_bigint() }}) as contact_referral_id,
    cast(zip_code as {{ dbt_utils.type_string() }}) as zip_code,
    cast({{ empty_string_to_null('exported_at') }} as {{ type_date() }}) as exported_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(team_referral_id as {{ dbt_utils.type_bigint() }}) as team_referral_id,
    cast(activity_id as {{ dbt_utils.type_bigint() }}) as activity_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    {{ cast_to_boolean('opt_in') }} as opt_in,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(activity_title as {{ dbt_utils.type_string() }}) as activity_title,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('forms_export_ab1') }}
-- forms_export
where 1 = 1

