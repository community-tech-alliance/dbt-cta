{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "default",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='page_scd'
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
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('page_ab3') }}
select
    name_with_location_descriptor,
    attire,
    messaging_feature_status,
    subscribed_apps,
    about,
    videos,
    published_posts,
    cover,
    culinary_team,
    tagged,
    app_id,
    is_community_page,
    events,
    custom_labels,
    offer_eligible,
    messaging_feature_review,
    global_brand_page_name,
    personas,
    page_backed_instagram_accounts,
    image_copyrights,
    mission,
    release_date,
    global_brand_root_id,
    connected_instagram_account,
    store_number,
    description_html,
    instagram_accounts,
    albums,
    nativeoffers,
    leadgen_tos_acceptance_time,
    mini_shop_storefront,
    ads_posts,
    new_like_count,
    genre,
    record_label,
    start_info,
    store_code,
    website,
    global_brand_children,
    canvas_elements,
    differently_open_offerings,
    business,
    founded,
    is_owned,
    privacy_info_url,
    company_overview,
    unread_message_count,
    indexed_videos,
    restaurant_specialties,
    single_line_address,
    promotion_ineligible_reason,
    checkins,
    pickup_options,
    written_by,
    crosspost_whitelisted_pages,
    engagement,
    keywords,
    overall_star_rating,
    price_range,
    pharma_safety_info,
    features,
    affiliation,
    whatsapp_number,
    current_location,
    instagram_business_account,
    fan_count,
    talking_about_count,
    live_videos,
    name,
    produced_by,
    is_webhooks_subscribed,
    booking_agent,
    custom_user_settings,
    can_checkin,
    roles,
    description,
    voip_info,
    merchant_id,
    emails,
    messenger_profile,
    supports_instant_articles,
    ratings,
    display_subtext,
    copyright_whitelisted_partners,
    best_page,
    contact_address,
    hours,
    hometown,
    screenplay_by,
    is_always_open,
    delivery_and_pickup_option_info,
    secondary_receivers,
    agencies,
    commerce_payouts,
    media_fingerprints,
    is_eligible_for_branded_content,
    schedule,
    admin_notes,
    is_unclaimed,
    followers_count,
    recipient,
    location,
    video_lists,
    username,
    were_here_count,
    studio,
    parking,
    visitor_posts,
    food_styles,
    restaurant_services,
    is_published,
    bio,
    has_whatsapp_number,
    displayed_message_response_time,
    is_permanently_closed,
    chat_plugin,
    public_transit,
    category_list,
    is_messenger_bot_get_started_enabled,
    claimed_urls,
    copyright_whitelisted_ig_partners,
    season,
    store_location_descriptor,
    leadgen_tos_accepting_user,
    id,
    band_members,
    payment_options,
    instant_articles_insights,
    mpg,
    shop_setup_status,
    access_token,
    product_catalogs,
    commerce_orders,
    phone,
    instant_articles_review_status,
    commerce_eligibility,
    country_page_likes,
    video_copyright_rules,
    tabs,
    plot_outline,
    leadgen_forms,
    products,
    commerce_transactions,
    blocked,
    promotion_eligible,
    messenger_ads_default_quick_replies,
    place_type,
    general_manager,
    supports_donate_button_in_live_video,
    is_verified,
    scheduled_posts,
    picture,
    artists_we_like,
    page_token,
    rtb_dynamic_posts,
    parent_page,
    call_to_actions,
    posts,
    photos,
    impressum,
    press_contact,
    band_interests,
    has_whatsapp_business_number,
    members,
    has_added_app,
    likes,
    personal_interests,
    settings,
    insights,
    assigned_users,
    merchant_review_status,
    connected_page_backed_instagram_account,
    rating_count,
    feed,
    canvases,
    featured_video,
    is_messenger_platform_bot,
    commerce_merchant_settings,
    birthday,
    has_transitioned_to_new_page_experience,
    instant_articles,
    link,
    ad_campaign,
    verification_status,
    conversations,
    network,
    directed_by,
    personal_info,
    influences,
    general_info,
    can_post,
    preferred_audience,
    temporary_status,
    is_chain,
    built,
    {{ adapter.quote('groups') }},
    threads,
    messenger_ads_quick_replies_type,
    thread_owner,
    awards,
    starring,
    messenger_ads_default_icebreakers,
    locations,
    unseen_message_count,
    category,
    unread_notif_count,
    leadgen_tos_accepted,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_page_hashid
from {{ ref('page_ab3') }}
-- page from {{ source('default', '_airbyte_raw_page') }}
where 1 = 1

