{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('page') }}
select
    _airbyte_page_hashid,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['birthday'], ['birthday']) }} as birthday,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['installed'], ['installed']) }} as installed,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['updated_time'], ['updated_time']) }} as updated_time,
    {{ json_extract_string_array('leadgen_tos_accepting_user', ['interested_in'], ['interested_in']) }} as interested_in,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['gender'], ['gender']) }} as gender,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['timezone'], ['timezone']) }} as timezone,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['link'], ['link']) }} as link,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['about'], ['about']) }} as about,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['political'], ['political']) }} as political,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['name_format'], ['name_format']) }} as name_format,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['local_news_megaphone_dismiss_status'], ['local_news_megaphone_dismiss_status']) }} as local_news_megaphone_dismiss_status,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['third_party_id'], ['third_party_id']) }} as third_party_id,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['locale'], ['locale']) }} as locale,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['quotes'], ['quotes']) }} as quotes,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['install_type'], ['install_type']) }} as install_type,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['relationship_status'], ['relationship_status']) }} as relationship_status,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['shared_login_upgrade_required_by'], ['shared_login_upgrade_required_by']) }} as shared_login_upgrade_required_by,
    {{ json_extract_string_array('leadgen_tos_accepting_user', ['meeting_for'], ['meeting_for']) }} as meeting_for,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['token_for_business'], ['token_for_business']) }} as token_for_business,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['website'], ['website']) }} as website,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['supports_donate_button_in_live_video'], ['supports_donate_button_in_live_video']) }} as supports_donate_button_in_live_video,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['is_guest_user'], ['is_guest_user']) }} as is_guest_user,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['verified'], ['verified']) }} as verified,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['profile_pic'], ['profile_pic']) }} as profile_pic,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['local_news_subscription_status'], ['local_news_subscription_status']) }} as local_news_subscription_status,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['middle_name'], ['middle_name']) }} as middle_name,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['is_verified'], ['is_verified']) }} as is_verified,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['religion'], ['religion']) }} as religion,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('leadgen_tos_accepting_user', ['short_name'], ['short_name']) }} as short_name,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page') }} as table_alias
-- leadgen_tos_accepting_user at page/leadgen_tos_accepting_user
where 1 = 1
and leadgen_tos_accepting_user is not null

