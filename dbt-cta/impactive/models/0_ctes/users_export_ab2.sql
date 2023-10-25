{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_export_ab1') }}
select
    cast(num_contacts_synced as {{ dbt_utils.type_bigint() }}) as num_contacts_synced,
    cast(selected_voterbase_id as {{ dbt_utils.type_string() }}) as selected_voterbase_id,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(recruited_by_id as {{ dbt_utils.type_bigint() }}) as recruited_by_id,
    cast(recruited_by as {{ dbt_utils.type_string() }}) as recruited_by,
    cast(actions_performed as {{ dbt_utils.type_bigint() }}) as actions_performed,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(reports_filled as {{ dbt_utils.type_bigint() }}) as reports_filled,
    cast(van_id as {{ dbt_utils.type_string() }}) as van_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(supplied_zip_code as {{ dbt_utils.type_string() }}) as supplied_zip_code,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(num_contacts_matched_in_district as {{ dbt_utils.type_bigint() }}) as num_contacts_matched_in_district,
    cast(actions_completed as {{ dbt_utils.type_bigint() }}) as actions_completed,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast(num_contacts_matched as {{ dbt_utils.type_bigint() }}) as num_contacts_matched,
    cast({{ empty_string_to_null('exported_at') }} as {{ type_date() }}) as exported_at,
    cast(supplied_state_abbrev as {{ dbt_utils.type_string() }}) as supplied_state_abbrev,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(invites_sent as {{ dbt_utils.type_bigint() }}) as invites_sent,
    cast({{ empty_string_to_null('last_active_at') }} as {{ type_timestamp_without_timezone() }}) as last_active_at,
    cast({{ empty_string_to_null('last_seen_at') }} as {{ type_timestamp_without_timezone() }}) as last_seen_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users_export_ab1') }}
-- users_export
where 1 = 1

