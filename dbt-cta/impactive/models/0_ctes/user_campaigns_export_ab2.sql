{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('user_campaigns_export_ab1') }}
select
    cast(leaderboard_messages as {{ dbt_utils.type_bigint() }}) as leaderboard_messages,
    cast(user_last_name as {{ dbt_utils.type_string() }}) as user_last_name,
    cast(campaign_role as {{ dbt_utils.type_string() }}) as campaign_role,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    {{ cast_to_boolean('welcome_permission') }} as welcome_permission,
    cast(team_leaderboard_reports as {{ dbt_utils.type_bigint() }}) as team_leaderboard_reports,
    cast(team_rank as {{ dbt_utils.type_bigint() }}) as team_rank,
    cast(team_leaderboard_score as {{ dbt_utils.type_bigint() }}) as team_leaderboard_score,
    cast({{ empty_string_to_null('user_last_seen_at') }} as {{ type_timestamp_without_timezone() }}) as user_last_seen_at,
    cast(leaderboard_reports as {{ dbt_utils.type_bigint() }}) as leaderboard_reports,
    cast(team_leaderboard_performs as {{ dbt_utils.type_bigint() }}) as team_leaderboard_performs,
    cast(user_first_name as {{ dbt_utils.type_string() }}) as user_first_name,
    {{ cast_to_boolean('export_permission') }} as export_permission,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    {{ cast_to_boolean('settings_permission') }} as settings_permission,
    cast(user_phone as {{ dbt_utils.type_string() }}) as user_phone,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    {{ cast_to_boolean('sync_permission') }} as sync_permission,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(num_contacts as {{ dbt_utils.type_bigint() }}) as num_contacts,
    cast(leaderboard_score as {{ dbt_utils.type_bigint() }}) as leaderboard_score,
    {{ cast_to_boolean('manage_users_permission') }} as manage_users_permission,
    cast(user_email as {{ dbt_utils.type_string() }}) as user_email,
    {{ cast_to_boolean('broadcast_permission') }} as broadcast_permission,
    {{ cast_to_boolean('joined') }} as joined,
    cast(num_contacts_matched as {{ dbt_utils.type_bigint() }}) as num_contacts_matched,
    cast(user_fullname as {{ dbt_utils.type_string() }}) as user_fullname,
    cast({{ empty_string_to_null('exported_at') }} as {{ type_date() }}) as exported_at,
    {{ cast_to_boolean('billing_permission') }} as billing_permission,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(team_leaderboard_messages as {{ dbt_utils.type_bigint() }}) as team_leaderboard_messages,
    cast(leaderboard_performs as {{ dbt_utils.type_bigint() }}) as leaderboard_performs,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_campaigns_export_ab1') }}
-- user_campaigns_export
where 1 = 1

