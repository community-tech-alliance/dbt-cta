{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "default",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='page_leadgen_tos_accepting_user_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('page_leadgen_tos_accepting_user_ab3') }}
select
    _airbyte_page_hashid,
    birthday,
    installed,
    updated_time,
    interested_in,
    gender,
    timezone,
    link,
    about,
    political,
    name_format,
    local_news_megaphone_dismiss_status,
    third_party_id,
    locale,
    quotes,
    install_type,
    relationship_status,
    shared_login_upgrade_required_by,
    meeting_for,
    token_for_business,
    id,
    first_name,
    email,
    website,
    supports_donate_button_in_live_video,
    is_guest_user,
    verified,
    profile_pic,
    local_news_subscription_status,
    last_name,
    middle_name,
    is_verified,
    religion,
    name,
    short_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_leadgen_tos_accepting_user_hashid
from {{ ref('page_leadgen_tos_accepting_user_ab3') }}
-- leadgen_tos_accepting_user at page/leadgen_tos_accepting_user from {{ ref('page') }}
where 1 = 1

