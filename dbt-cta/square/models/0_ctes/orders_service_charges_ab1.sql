{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders') }}
{{ unnest_cte(ref('orders'), 'orders', 'service_charges') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar(unnested_column_value('service_charges'), ['uid'], ['uid']) }} as uid,
    {{ json_extract_scalar(unnested_column_value('service_charges'), ['name'], ['name']) }} as name,
    {{ json_extract_scalar(unnested_column_value('service_charges'), ['taxable'], ['taxable']) }} as taxable,
    {{ json_extract('', unnested_column_value('service_charges'), ['total_money'], ['total_money']) }} as total_money,
    {{ json_extract('', unnested_column_value('service_charges'), ['amount_money'], ['amount_money']) }} as amount_money,
    {{ json_extract('', unnested_column_value('service_charges'), ['applied_money'], ['applied_money']) }} as applied_money,
    {{ json_extract('', unnested_column_value('service_charges'), ['total_tax_money'], ['total_tax_money']) }} as total_tax_money,
    {{ json_extract_scalar(unnested_column_value('service_charges'), ['calculation_phase'], ['calculation_phase']) }} as calculation_phase,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_base') }} as table_alias
-- service_charges at orders/service_charges
{{ cross_join_unnest('orders', 'service_charges') }}
where 1 = 1
and service_charges is not null

