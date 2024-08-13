{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_orders') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_array('_airbyte_data', ['taxes'], ['taxes']) }} as taxes,
    {{ json_extract('table_alias', '_airbyte_data', ['source'], ['source']) }} as source,
    {{ json_extract_array('_airbyte_data', ['refunds'], ['refunds']) }} as refunds,
    {{ json_extract_array('_airbyte_data', ['returns'], ['returns']) }} as returns,
    {{ json_extract_array('_airbyte_data', ['tenders'], ['tenders']) }} as tenders,
    {{ json_extract_scalar('_airbyte_data', ['version'], ['version']) }} as version,
    {{ json_extract_scalar('_airbyte_data', ['closed_at'], ['closed_at']) }} as closed_at,
    {{ json_extract_array('_airbyte_data', ['discounts'], ['discounts']) }} as discounts,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_array('_airbyte_data', ['line_items'], ['line_items']) }} as line_items,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['location_id'], ['location_id']) }} as location_id,
    {{ json_extract('table_alias', '_airbyte_data', ['net_amounts'], ['net_amounts']) }} as net_amounts,
    {{ json_extract('table_alias', '_airbyte_data', ['total_money'], ['total_money']) }} as total_money,
    {{ json_extract_array('_airbyte_data', ['fulfillments'], ['fulfillments']) }} as fulfillments,
    {{ json_extract('table_alias', '_airbyte_data', ['return_amounts'], ['return_amounts']) }} as return_amounts,
    {{ json_extract_array('_airbyte_data', ['service_charges'], ['service_charges']) }} as service_charges,
    {{ json_extract('table_alias', '_airbyte_data', ['total_tax_money'], ['total_tax_money']) }} as total_tax_money,
    {{ json_extract('table_alias', '_airbyte_data', ['total_tip_money'], ['total_tip_money']) }} as total_tip_money,
    {{ json_extract('table_alias', '_airbyte_data', ['total_discount_money'], ['total_discount_money']) }} as total_discount_money,
    {{ json_extract('table_alias', '_airbyte_data', ['total_service_charge_money'], ['total_service_charge_money']) }} as total_service_charge_money,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_orders') }} as table_alias
-- orders
where 1 = 1
