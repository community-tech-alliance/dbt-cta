{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ad_account_hashid'
) }}

-- depends_on: {{ source('cta', 'ad_account_base') }}

SELECT
   _airbyte_ad_account_hashid
   ,MAX(account_id_stripped) as account_id_stripped
   ,MAX(id) as id
   ,MAX(age) as age
   ,MAX(name) as name
   ,MAX(owner) as owner
   ,MAX(tax_id) as tax_id
   ,MAX(balance) as balance
   ,MAX(partner) as partner
   ,MAX(rf_spec) as rf_spec
   ,MAX(business) as business
   ,MAX(currency) as currency
   ,MAX(fb_entity) as fb_entity
   ,MAX(io_number) as io_number
   ,MAX(spend_cap) as spend_cap
   ,MAX(account_id) as account_id
   ,MAX(ARRAY_TO_STRING(user_tasks,',')) as user_tasks
   ,MAX(is_personal) as is_personal
   ,MAX(tax_id_type) as tax_id_type
   ,MAX(timezone_id) as timezone_id
   ,MAX(amount_spent) as amount_spent
   ,MAX(business_zip) as business_zip
   ,MAX(ARRAY_TO_STRING(capabilities,',')) as capabilities
   ,MAX(created_time) as created_time
   ,MAX(line_numbers) as line_numbers
   ,MAX(media_agency) as media_agency
   ,MAX(tos_accepted) as tos_accepted
   ,MAX(business_city) as business_city
   ,MAX(business_name) as business_name
   ,MAX(tax_id_status) as tax_id_status
   ,MAX(timezone_name) as timezone_name
   ,MAX(account_status) as account_status
   ,MAX(business_state) as business_state
   ,MAX(disable_reason) as disable_reason
   ,MAX(end_advertiser) as end_advertiser
   ,MAX(funding_source) as funding_source
   ,MAX(business_street) as business_street
   ,MAX(business_street2) as business_street2
   ,MAX(min_daily_budget) as min_daily_budget
   ,MAX(is_prepay_account) as is_prepay_account
   ,MAX(user_tos_accepted) as user_tos_accepted
   ,MAX(is_tax_id_required) as is_tax_id_required
   ,MAX(end_advertiser_name) as end_advertiser_name
   ,MAX(business_country_code) as business_country_code
   ,MAX(failed_delivery_checks) as failed_delivery_checks
   ,MAX(funding_source_details) as funding_source_details
   ,MAX(is_direct_deals_enabled) as is_direct_deals_enabled
   ,MAX(has_migrated_permissions) as has_migrated_permissions
   ,MAX(is_notifications_enabled) as is_notifications_enabled
   ,MAX(timezone_offset_hours_utc) as timezone_offset_hours_utc
   ,MAX(can_create_brand_lift_study) as can_create_brand_lift_study
   ,MAX(offsite_pixels_tos_accepted) as offsite_pixels_tos_accepted
   ,MAX(has_advertiser_opted_in_odax) as has_advertiser_opted_in_odax
   ,MAX(min_campaign_group_spend_cap) as min_campaign_group_spend_cap
   ,MAX(extended_credit_invoice_group) as extended_credit_invoice_group
   ,MAX(is_attribution_spec_system_default) as is_attribution_spec_system_default
   ,MAX(is_in_3ds_authorization_enabled_market) as is_in_3ds_authorization_enabled_market
   ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
FROM {{ source('cta', 'ad_account_base') }}
GROUP BY _airbyte_ad_account_hashid