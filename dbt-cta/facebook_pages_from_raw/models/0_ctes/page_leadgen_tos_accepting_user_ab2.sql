{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_leadgen_tos_accepting_user_ab1') }}
select
    _airbyte_page_hashid,
    cast(birthday as {{ dbt_utils.type_string() }}) as birthday,
    {{ cast_to_boolean('installed') }} as installed,
    cast({{ empty_string_to_null('updated_time') }} as {{ type_timestamp_with_timezone() }}) as updated_time,
    interested_in,
    cast(gender as {{ dbt_utils.type_string() }}) as gender,
    cast(timezone as {{ dbt_utils.type_float() }}) as timezone,
    cast(link as {{ dbt_utils.type_string() }}) as link,
    cast(about as {{ dbt_utils.type_string() }}) as about,
    cast(political as {{ dbt_utils.type_string() }}) as political,
    cast(name_format as {{ dbt_utils.type_string() }}) as name_format,
    {{ cast_to_boolean('local_news_megaphone_dismiss_status') }} as local_news_megaphone_dismiss_status,
    cast(third_party_id as {{ dbt_utils.type_string() }}) as third_party_id,
    cast(locale as {{ dbt_utils.type_string() }}) as locale,
    cast(quotes as {{ dbt_utils.type_string() }}) as quotes,
    cast(install_type as {{ dbt_utils.type_string() }}) as install_type,
    cast(relationship_status as {{ dbt_utils.type_string() }}) as relationship_status,
    cast({{ empty_string_to_null('shared_login_upgrade_required_by') }} as {{ type_timestamp_with_timezone() }}) as shared_login_upgrade_required_by,
    meeting_for,
    cast(token_for_business as {{ dbt_utils.type_string() }}) as token_for_business,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(website as {{ dbt_utils.type_string() }}) as website,
    {{ cast_to_boolean('supports_donate_button_in_live_video') }} as supports_donate_button_in_live_video,
    {{ cast_to_boolean('is_guest_user') }} as is_guest_user,
    {{ cast_to_boolean('verified') }} as verified,
    cast(profile_pic as {{ dbt_utils.type_string() }}) as profile_pic,
    {{ cast_to_boolean('local_news_subscription_status') }} as local_news_subscription_status,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast(middle_name as {{ dbt_utils.type_string() }}) as middle_name,
    {{ cast_to_boolean('is_verified') }} as is_verified,
    cast(religion as {{ dbt_utils.type_string() }}) as religion,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(short_name as {{ dbt_utils.type_string() }}) as short_name,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_leadgen_tos_accepting_user_ab1') }}
-- leadgen_tos_accepting_user at page/leadgen_tos_accepting_user
where 1 = 1

