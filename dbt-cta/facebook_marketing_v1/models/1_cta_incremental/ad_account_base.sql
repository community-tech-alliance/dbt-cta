{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}

-- depends_on: {{ ref('ad_account_ab2') }}
select
    id,
    _airbyte_extracted_at,
    _airbyte_raw_id,
    age,
    name,
    owner,
    tax_id,
    balance,
    partner,
    rf_spec,
    business,
    currency,
    fb_entity,
    io_number,
    spend_cap,
    account_id,
    user_tasks,
    is_personal,
    tax_id_type,
    timezone_id,
    amount_spent,
    business_zip,
    capabilities,
    created_time,
    line_numbers,
    media_agency,
    tos_accepted,
    business_city,
    business_name,
    tax_id_status,
    timezone_name,
    account_status,
    business_state,
    disable_reason,
    end_advertiser,
    funding_source,
    business_street,
    business_street2,
    min_daily_budget,
    is_prepay_account,
    user_tos_accepted,
    is_tax_id_required,
    end_advertiser_name,
    business_country_code,
    failed_delivery_checks,
    funding_source_details,
    is_direct_deals_enabled,
    has_migrated_permissions,
    is_notifications_enabled,
    timezone_offset_hours_utc,
    can_create_brand_lift_study,
    offsite_pixels_tos_accepted,
    has_advertiser_opted_in_odax,
    min_campaign_group_spend_cap,
    extended_credit_invoice_group,
    is_attribution_spec_system_default,
    is_in_3ds_authorization_enabled_market,
    right(id, 16) as account_id_stripped
from {{ ref('ad_account_ab2') }}
