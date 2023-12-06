{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta','page') }} 
select
    {{ dbt_utils.surrogate_key([        
        'name_with_location_descriptor',
        'attire',
        'about',
        'global_brand_page_name',
        'mission',
        'release_date',
        'store_number',
        'description_html',
        'leadgen_tos_acceptance_time',
        'new_like_count',
        'genre',
        'record_label',
        'store_code',
        'website',
        'differently_open_offerings',
        'business',
        'founded',
        'privacy_info_url',
        'company_overview',
        'checkins',
        'written_by',
        'keywords',
        'overall_star_rating',
        'price_range',
        'pharma_safety_info',
        'features',
        'affiliation',
        'whatsapp_number',
        'current_location',
        'fan_count',
        'talking_about_count',
        'name',
        'produced_by',
        'booking_agent',
        'bio',
        'displayed_message_response_time',
        'public_transit',
        'season',
        'store_location_descriptor',
        'id',
        'band_members',
        'mpg',
        'access_token',
        'phone',
        'country_page_likes',
        'plot_outline',
        'products',
        'place_type',
        'general_manager',
        'artists_we_like',
        'page_token',
        'impressum',
        'press_contact',
        'band_interests',
        'members',
        'personal_interests',
        'merchant_review_status',
        'rating_count',
        'birthday',
        'link',
        'verification_status',
        'network',
        'directed_by',
        'personal_info',
        'influences',
        'general_info',
        'temporary_status',
        'built',
        'messenger_ads_quick_replies_type',
        'awards',
        'starring',
        'unseen_message_count',
        'category',
        'unread_notif_count',
    ]) }} as _airbyte_page_hashid,
    tmp.*
from {{ source('cta','page') }} as tmp
-- page
where 1 = 1