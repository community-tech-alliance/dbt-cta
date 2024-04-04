{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(info as {{ dbt_utils.type_string() }}) as info,
    cast(role as {{ dbt_utils.type_bigint() }}) as role,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(agree as {{ dbt_utils.type_bigint() }}) as agree,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(stats as {{ dbt_utils.type_string() }}) as stats,
    cast(language as {{ dbt_utils.type_string() }}) as language,
    cast(auth_hash as {{ dbt_utils.type_string() }}) as auth_hash,
    cast(permalink as {{ dbt_utils.type_string() }}) as permalink,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(deleted_at as {{ dbt_utils.type_string() }}) as deleted_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(confirmed_at as {{ dbt_utils.type_string() }}) as confirmed_at,
    cast(lists_enabled as {{ dbt_utils.type_bigint() }}) as lists_enabled,
    cast(root_group_id as {{ dbt_utils.type_bigint() }}) as root_group_id,
    cast(sign_in_count as {{ dbt_utils.type_bigint() }}) as sign_in_count,
    cast(is_super_admin as {{ dbt_utils.type_bigint() }}) as is_super_admin,
    cast(last_sign_in_at as {{ dbt_utils.type_string() }}) as last_sign_in_at,
    cast(last_sign_in_ip as {{ dbt_utils.type_string() }}) as last_sign_in_ip,
    cast(avatar_file_name as {{ dbt_utils.type_string() }}) as avatar_file_name,
    cast(avatar_file_size as {{ dbt_utils.type_bigint() }}) as avatar_file_size,
    cast(save_credit_card as {{ dbt_utils.type_bigint() }}) as save_credit_card,
    cast(redirects_enabled as {{ dbt_utils.type_bigint() }}) as redirects_enabled,
    cast(unconfirmed_email as {{ dbt_utils.type_string() }}) as unconfirmed_email,
    cast(current_sign_in_at as {{ dbt_utils.type_string() }}) as current_sign_in_at,
    cast(current_sign_in_ip as {{ dbt_utils.type_string() }}) as current_sign_in_ip,
    cast(originating_system as {{ dbt_utils.type_string() }}) as originating_system,
    cast(avatar_content_type as {{ dbt_utils.type_string() }}) as avatar_content_type,
    cast(enable_applications as {{ dbt_utils.type_bigint() }}) as enable_applications,
    cast(remember_created_at as {{ dbt_utils.type_string() }}) as remember_created_at,
    cast(confirmation_sent_at as {{ dbt_utils.type_string() }}) as confirmation_sent_at,
    cast(custom_fields_enabled as {{ dbt_utils.type_bigint() }}) as custom_fields_enabled,
    cast(reset_password_sent_at as {{ dbt_utils.type_string() }}) as reset_password_sent_at,
    cast(salesforce_last_update as {{ dbt_utils.type_string() }}) as salesforce_last_update,
    cast(current_page_wrapper_id as {{ dbt_utils.type_bigint() }}) as current_page_wrapper_id,
    cast(email_templates_enabled as {{ dbt_utils.type_bigint() }}) as email_templates_enabled,
    cast(salesforce_sync_enabled as {{ dbt_utils.type_bigint() }}) as salesforce_sync_enabled,
    cast(salesforce_custom_fields as {{ dbt_utils.type_string() }}) as salesforce_custom_fields,
    cast(credit_card_last_4_digits as {{ dbt_utils.type_string() }}) as credit_card_last_4_digits,
    cast(current_email_template_id as {{ dbt_utils.type_bigint() }}) as current_email_template_id,
    cast(salesforce_sync_successful as {{ dbt_utils.type_bigint() }}) as salesforce_sync_successful,
    cast(receive_transactional_email as {{ dbt_utils.type_bigint() }}) as receive_transactional_email,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users_ab1') }}
-- users
where 1 = 1
