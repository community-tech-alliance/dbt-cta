{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'ad_account') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
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
    min_campaign_group_spend_cap,
    extended_credit_invoice_group,
    is_attribution_spec_system_default,
    is_in_3ds_authorization_enabled_market,
    split(id, '_')[offset(1)] as account_id_stripped,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'tax_id',
    'balance',
    'currency',
    'spend_cap',
    'account_id',
    'tax_id_type',
    'amount_spent',
    'business_zip',
    'created_time',
    'business_city',
    'business_name',
    'timezone_name',
    'account_status',
    'business_state',
    'business_street',
    'business_street2',
    'is_prepay_account',
    'is_tax_id_required',
    'end_advertiser_name',
    'business_country_code',
    'is_direct_deals_enabled',
    'has_migrated_permissions',
    'is_notifications_enabled',
    'can_create_brand_lift_study',
    'offsite_pixels_tos_accepted',
    'is_attribution_spec_system_default',
    'is_in_3ds_authorization_enabled_market'
    ]) }} as _airbyte_ad_account_hashid
from {{ source('cta', 'ad_account') }}
