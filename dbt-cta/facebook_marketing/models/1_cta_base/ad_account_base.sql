{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = '_airbyte_ad_account_hashid'
) }}

-- depends_on: {{ ref('ad_account_ab3') }}
select
     _airbyte_ad_account_hashid
    ,_airbyte_emitted_at
    ,_airbyte_ab_id
    ,right(id, 16) as account_id_stripped
    ,id
    ,age
    ,name
    ,owner
    ,tax_id
    ,balance
    ,partner
    ,rf_spec
    ,business
    ,currency
    ,fb_entity
    ,io_number
    ,spend_cap
    ,account_id
    ,user_tasks
    ,is_personal
    ,tax_id_type
    ,timezone_id
    ,amount_spent
    ,business_zip
    ,capabilities
    ,created_time
    ,line_numbers
    ,media_agency
    ,tos_accepted
    ,business_city
    ,business_name
    ,tax_id_status
    ,timezone_name
    ,account_status
    ,business_state
    ,disable_reason
    ,end_advertiser
    ,funding_source
    ,business_street
    ,business_street2
    ,min_daily_budget
    ,is_prepay_account
    ,user_tos_accepted
    ,is_tax_id_required
    ,end_advertiser_name
    ,business_country_code
    ,failed_delivery_checks
    ,funding_source_details
    ,is_direct_deals_enabled
    ,has_migrated_permissions
    ,is_notifications_enabled
    ,timezone_offset_hours_utc
    ,can_create_brand_lift_study
    ,offsite_pixels_tos_accepted
    ,has_advertiser_opted_in_odax
    ,min_campaign_group_spend_cap
    ,extended_credit_invoice_group
    ,is_attribution_spec_system_default
    ,is_in_3ds_authorization_enabled_market
from {{ ref('ad_account_ab3') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}