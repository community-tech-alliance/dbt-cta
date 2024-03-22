{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_ticket_receipts') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('_airbyte_data', ['address'], ['address']) }} as address,
    {{ json_extract_scalar('_airbyte_data', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('_airbyte_data', ['is_comp'], ['is_comp']) }} as is_comp,
    {{ json_extract_scalar('_airbyte_data', ['is_free'], ['is_free']) }} as is_free,
    {{ json_extract_scalar('_airbyte_data', ['payer_id'], ['payer_id']) }} as payer_id,
    {{ json_extract_scalar('_airbyte_data', ['tag_list'], ['tag_list']) }} as tag_list,
    {{ json_extract_scalar('_airbyte_data', ['zip_code'], ['zip_code']) }} as zip_code,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['tip_amount'], ['tip_amount']) }} as tip_amount,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['checkout_id'], ['checkout_id']) }} as checkout_id,
    {{ json_extract_scalar('_airbyte_data', ['custom_amount'], ['custom_amount']) }} as custom_amount,
    {{ json_extract_scalar('_airbyte_data', ['custom_fields'], ['custom_fields']) }} as custom_fields,
    {{ json_extract_scalar('_airbyte_data', ['checkout_status'], ['checkout_status']) }} as checkout_status,
    {{ json_extract_scalar('_airbyte_data', ['stripe_charge_id'], ['stripe_charge_id']) }} as stripe_charge_id,
    {{ json_extract_scalar('_airbyte_data', ['wepay_account_id'], ['wepay_account_id']) }} as wepay_account_id,
    {{ json_extract_scalar('_airbyte_data', ['stripe_account_id'], ['stripe_account_id']) }} as stripe_account_id,
    {{ json_extract_scalar('_airbyte_data', ['ticketed_event_id'], ['ticketed_event_id']) }} as ticketed_event_id,
    {{ json_extract_scalar('_airbyte_data', ['originating_system'], ['originating_system']) }} as originating_system,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_ticket_receipts') }}
-- ticket_receipts
where 1 = 1
