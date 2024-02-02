{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "default",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='page_best_page_scd'
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
-- depends_on: {{ ref('page_best_page_ab3') }}
select
    _airbyte_page_hashid,
    studio,
    food_styles,
    name_with_location_descriptor,
    attire,
    is_published,
    about,
    bio,
    has_whatsapp_number,
    displayed_message_response_time,
    is_permanently_closed,
    public_transit,
    culinary_team,
    is_messenger_bot_get_started_enabled,
    copyright_whitelisted_ig_partners,
    season,
    store_location_descriptor,
    id,
    app_id,
    is_community_page,
    band_members,
    mpg,
    offer_eligible,
    global_brand_page_name,
    access_token,
    mission,
    phone,
    release_date,
    instant_articles_review_status,
    global_brand_root_id,
    store_number,
    country_page_likes,
    description_html,
    leadgen_tos_acceptance_time,
    plot_outline,
    products,
    new_like_count,
    promotion_eligible,
    messenger_ads_default_quick_replies,
    place_type,
    genre,
    general_manager,
    record_label,
    store_code,
    website,
    supports_donate_button_in_live_video,
    differently_open_offerings,
    business,
    founded,
    is_owned,
    privacy_info_url,
    is_verified,
    company_overview,
    unread_message_count,
    single_line_address,
    artists_we_like,
    promotion_ineligible_reason,
    page_token,
    checkins,
    pickup_options,
    written_by,
    keywords,
    overall_star_rating,
    price_range,
    pharma_safety_info,
    impressum,
    press_contact,
    features,
    band_interests,
    has_whatsapp_business_number,
    affiliation,
    members,
    has_added_app,
    whatsapp_number,
    current_location,
    personal_interests,
    fan_count,
    talking_about_count,
    merchant_review_status,
    rating_count,
    is_messenger_platform_bot,
    name,
    produced_by,
    is_webhooks_subscribed,
    booking_agent,
    birthday,
    has_transitioned_to_new_page_experience,
    can_checkin,
    link,
    description,
    merchant_id,
    verification_status,
    network,
    emails,
    directed_by,
    personal_info,
    supports_instant_articles,
    influences,
    display_subtext,
    general_info,
    can_post,
    hours,
    hometown,
    temporary_status,
    screenplay_by,
    is_chain,
    built,
    is_always_open,
    delivery_and_pickup_option_info,
    messenger_ads_quick_replies_type,
    is_eligible_for_branded_content,
    schedule,
    is_unclaimed,
    awards,
    followers_count,
    recipient,
    starring,
    messenger_ads_default_icebreakers,
    unseen_message_count,
    category,
    unread_notif_count,
    leadgen_tos_accepted,
    username,
    were_here_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_best_page_hashid
from {{ ref('page_best_page_ab3') }}
-- best_page at page/best_page from {{ ref('page') }}
where 1 = 1
