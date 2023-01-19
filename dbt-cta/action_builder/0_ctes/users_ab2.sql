{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(uid as {{ dbt_utils.type_string() }}) as uid,
    cast(role as {{ dbt_utils.type_string() }}) as role,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(tokens as {{ dbt_utils.type_string() }}) as tokens,
    cast(provider as {{ dbt_utils.type_string() }}) as provider,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    {{ cast_to_boolean('api_access') }} as api_access,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('deleted_at') }} as {{ type_timestamp_without_timezone() }}) as deleted_at,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast({{ empty_string_to_null('confirmed_at') }} as {{ type_timestamp_without_timezone() }}) as confirmed_at,
    cast(phone_number as {{ dbt_utils.type_string() }}) as phone_number,
    cast(invited_by_id as {{ dbt_utils.type_bigint() }}) as invited_by_id,
    cast(sign_in_count as {{ dbt_utils.type_bigint() }}) as sign_in_count,
    cast(invited_by_type as {{ dbt_utils.type_string() }}) as invited_by_type,
    cast({{ empty_string_to_null('last_sign_in_at') }} as {{ type_timestamp_without_timezone() }}) as last_sign_in_at,
    cast(last_sign_in_ip as {{ dbt_utils.type_string() }}) as last_sign_in_ip,
    cast(invitation_limit as {{ dbt_utils.type_bigint() }}) as invitation_limit,
    cast(invitation_token as {{ dbt_utils.type_string() }}) as invitation_token,
    cast(invitations_count as {{ dbt_utils.type_bigint() }}) as invitations_count,
    cast(unconfirmed_email as {{ dbt_utils.type_string() }}) as unconfirmed_email,
    cast(confirmation_token as {{ dbt_utils.type_string() }}) as confirmation_token,
    cast({{ empty_string_to_null('current_sign_in_at') }} as {{ type_timestamp_without_timezone() }}) as current_sign_in_at,
    cast(current_sign_in_ip as {{ dbt_utils.type_string() }}) as current_sign_in_ip,
    cast(encrypted_password as {{ dbt_utils.type_string() }}) as encrypted_password,
    cast({{ empty_string_to_null('invitation_sent_at') }} as {{ type_timestamp_without_timezone() }}) as invitation_sent_at,
    cast({{ empty_string_to_null('remember_created_at') }} as {{ type_timestamp_without_timezone() }}) as remember_created_at,
    cast(authentication_token as {{ dbt_utils.type_string() }}) as authentication_token,
    cast({{ empty_string_to_null('confirmation_sent_at') }} as {{ type_timestamp_without_timezone() }}) as confirmation_sent_at,
    cast(reset_password_token as {{ dbt_utils.type_string() }}) as reset_password_token,
    {{ cast_to_boolean('allow_password_change') }} as allow_password_change,
    cast({{ empty_string_to_null('invitation_created_at') }} as {{ type_timestamp_without_timezone() }}) as invitation_created_at,
    cast({{ empty_string_to_null('invitation_accepted_at') }} as {{ type_timestamp_without_timezone() }}) as invitation_accepted_at,
    cast({{ empty_string_to_null('reset_password_sent_at') }} as {{ type_timestamp_without_timezone() }}) as reset_password_sent_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users_ab1') }}
-- users
where 1 = 1

