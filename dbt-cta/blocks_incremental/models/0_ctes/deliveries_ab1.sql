{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_deliveries') }}
select
    {{ json_extract_scalar('_airbyte_data', ['notes'], ['notes']) }} as notes,
    {{ json_extract_scalar('_airbyte_data', ['batch_number'], ['batch_number']) }} as batch_number,
    {{ json_extract_scalar('_airbyte_data', ['form_filter_registration_date_start'], ['form_filter_registration_date_start']) }} as form_filter_registration_date_start,
    {{ json_extract_scalar('_airbyte_data', ['canvasser_id'], ['canvasser_id']) }} as canvasser_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['form_filter_turf_id'], ['form_filter_turf_id']) }} as form_filter_turf_id,
    {{ json_extract_scalar('_airbyte_data', ['form_filter_counties'], ['form_filter_counties']) }} as form_filter_counties,
    {{ json_extract_scalar('_airbyte_data', ['clerk_receipt_data'], ['clerk_receipt_data']) }} as clerk_receipt_data,
    {{ json_extract_scalar('_airbyte_data', ['created_by_user_id'], ['created_by_user_id']) }} as created_by_user_id,
    {{ json_extract_scalar('_airbyte_data', ['office_id'], ['office_id']) }} as office_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['turn_in_location_id'], ['turn_in_location_id']) }} as turn_in_location_id,
    {{ json_extract_scalar('_airbyte_data', ['delivery_method'], ['delivery_method']) }} as delivery_method,
    {{ json_extract_scalar('_airbyte_data', ['runner_receipt_data'], ['runner_receipt_data']) }} as runner_receipt_data,
    {{ json_extract_scalar('_airbyte_data', ['form_filter_registration_date_end'], ['form_filter_registration_date_end']) }} as form_filter_registration_date_end,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['turn_in_date'], ['turn_in_date']) }} as turn_in_date,
    {{ json_extract_scalar('_airbyte_data', ['form_filters_no_county'], ['form_filters_no_county']) }} as form_filters_no_county,
    {{ json_extract_scalar('_airbyte_data', ['form_filter_qc_statuses'], ['form_filter_qc_statuses']) }} as form_filter_qc_statuses,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_deliveries') }}
-- deliveries
where 1 = 1
