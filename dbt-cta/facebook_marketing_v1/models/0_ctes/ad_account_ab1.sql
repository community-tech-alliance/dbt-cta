{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_ad_account" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['age'], ['age']) }} as age,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['owner'], ['owner']) }} as owner,
    {{ json_extract_scalar('_airbyte_data', ['tax_id'], ['tax_id']) }} as tax_id,
    {{ json_extract_scalar('_airbyte_data', ['balance'], ['balance']) }} as balance,
    {{ json_extract_scalar('_airbyte_data', ['partner'], ['partner']) }} as partner,
    {{ json_extract('table_alias', '_airbyte_data', ['rf_spec'], ['rf_spec']) }} as rf_spec,
    {{ json_extract('table_alias', '_airbyte_data', ['business'], ['business']) }} as business,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('_airbyte_data', ['fb_entity'], ['fb_entity']) }} as fb_entity,
    {{ json_extract_scalar('_airbyte_data', ['io_number'], ['io_number']) }} as io_number,
    {{ json_extract_scalar('_airbyte_data', ['spend_cap'], ['spend_cap']) }} as spend_cap,
    {{ json_extract_scalar('_airbyte_data', ['account_id'], ['account_id']) }} as account_id,
    {{ json_extract_array('_airbyte_data', ['user_tasks'], ['user_tasks']) }} as user_tasks,
    {{ json_extract_scalar('_airbyte_data', ['is_personal'], ['is_personal']) }} as is_personal,
    {{ json_extract_scalar('_airbyte_data', ['tax_id_type'], ['tax_id_type']) }} as tax_id_type,
    {{ json_extract_scalar('_airbyte_data', ['timezone_id'], ['timezone_id']) }} as timezone_id,
    {{ json_extract_scalar('_airbyte_data', ['amount_spent'], ['amount_spent']) }} as amount_spent,
    {{ json_extract_scalar('_airbyte_data', ['business_zip'], ['business_zip']) }} as business_zip,
    {{ json_extract_array('_airbyte_data', ['capabilities'], ['capabilities']) }} as capabilities,
    {{ json_extract_scalar('_airbyte_data', ['created_time'], ['created_time']) }} as created_time,
    {{ json_extract_scalar('_airbyte_data', ['line_numbers'], ['line_numbers']) }} as line_numbers,
    {{ json_extract_scalar('_airbyte_data', ['media_agency'], ['media_agency']) }} as media_agency,
    {{ json_extract('table_alias', '_airbyte_data', ['tos_accepted'], ['tos_accepted']) }} as tos_accepted,
    {{ json_extract_scalar('_airbyte_data', ['business_city'], ['business_city']) }} as business_city,
    {{ json_extract_scalar('_airbyte_data', ['business_name'], ['business_name']) }} as business_name,
    {{ json_extract_scalar('_airbyte_data', ['tax_id_status'], ['tax_id_status']) }} as tax_id_status,
    {{ json_extract_scalar('_airbyte_data', ['timezone_name'], ['timezone_name']) }} as timezone_name,
    {{ json_extract_scalar('_airbyte_data', ['account_status'], ['account_status']) }} as account_status,
    {{ json_extract_scalar('_airbyte_data', ['business_state'], ['business_state']) }} as business_state,
    {{ json_extract_scalar('_airbyte_data', ['disable_reason'], ['disable_reason']) }} as disable_reason,
    {{ json_extract_scalar('_airbyte_data', ['end_advertiser'], ['end_advertiser']) }} as end_advertiser,
    {{ json_extract_scalar('_airbyte_data', ['funding_source'], ['funding_source']) }} as funding_source,
    {{ json_extract_scalar('_airbyte_data', ['business_street'], ['business_street']) }} as business_street,
    {{ json_extract_scalar('_airbyte_data', ['business_street2'], ['business_street2']) }} as business_street2,
    {{ json_extract_scalar('_airbyte_data', ['min_daily_budget'], ['min_daily_budget']) }} as min_daily_budget,
    {{ json_extract_scalar('_airbyte_data', ['is_prepay_account'], ['is_prepay_account']) }} as is_prepay_account,
    {{ json_extract('table_alias', '_airbyte_data', ['user_tos_accepted'], ['user_tos_accepted']) }} as user_tos_accepted,
    {{ json_extract_scalar('_airbyte_data', ['is_tax_id_required'], ['is_tax_id_required']) }} as is_tax_id_required,
    {{ json_extract_scalar('_airbyte_data', ['end_advertiser_name'], ['end_advertiser_name']) }} as end_advertiser_name,
    {{ json_extract_scalar('_airbyte_data', ['business_country_code'], ['business_country_code']) }} as business_country_code,
    {{ json_extract_scalar('_airbyte_data', ['failed_delivery_checks'], ['failed_delivery_checks']) }} as failed_delivery_checks,
    {{ json_extract('table_alias', '_airbyte_data', ['funding_source_details'], ['funding_source_details']) }} as funding_source_details,
    {{ json_extract_scalar('_airbyte_data', ['is_direct_deals_enabled'], ['is_direct_deals_enabled']) }} as is_direct_deals_enabled,
    {{ json_extract_scalar('_airbyte_data', ['has_migrated_permissions'], ['has_migrated_permissions']) }} as has_migrated_permissions,
    {{ json_extract_scalar('_airbyte_data', ['is_notifications_enabled'], ['is_notifications_enabled']) }} as is_notifications_enabled,
    {{ json_extract_scalar('_airbyte_data', ['timezone_offset_hours_utc'], ['timezone_offset_hours_utc']) }} as timezone_offset_hours_utc,
    {{ json_extract_scalar('_airbyte_data', ['can_create_brand_lift_study'], ['can_create_brand_lift_study']) }} as can_create_brand_lift_study,
    {{ json_extract_scalar('_airbyte_data', ['offsite_pixels_tos_accepted'], ['offsite_pixels_tos_accepted']) }} as offsite_pixels_tos_accepted,
    {{ json_extract_scalar('_airbyte_data', ['has_advertiser_opted_in_odax'], ['has_advertiser_opted_in_odax']) }} as has_advertiser_opted_in_odax,
    {{ json_extract_scalar('_airbyte_data', ['min_campaign_group_spend_cap'], ['min_campaign_group_spend_cap']) }} as min_campaign_group_spend_cap,
    {{ json_extract_scalar('_airbyte_data', ['extended_credit_invoice_group'], ['extended_credit_invoice_group']) }} as extended_credit_invoice_group,
    {{ json_extract_scalar('_airbyte_data', ['is_attribution_spec_system_default'], ['is_attribution_spec_system_default']) }} as is_attribution_spec_system_default,
    {{ json_extract_scalar('_airbyte_data', ['is_in_3ds_authorization_enabled_market'], ['is_in_3ds_authorization_enabled_market']) }} as is_in_3ds_authorization_enabled_market,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }} as table_alias
-- ad_account
where 1 = 1
