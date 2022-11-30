{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders') }}
select
    _airbyte_orders_hashid,
    {{ json_extract('table_alias', 'return_amounts', ['tax_money'], ['tax_money']) }} as tax_money,
    {{ json_extract('table_alias', 'return_amounts', ['tip_money'], ['tip_money']) }} as tip_money,
    {{ json_extract('table_alias', 'return_amounts', ['total_money'], ['total_money']) }} as total_money,
    {{ json_extract('table_alias', 'return_amounts', ['discount_money'], ['discount_money']) }} as discount_money,
    {{ json_extract('table_alias', 'return_amounts', ['service_charge_money'], ['service_charge_money']) }} as service_charge_money,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_base') }} as table_alias
-- return_amounts at orders/return_amounts
where 1 = 1
and return_amounts is not null

