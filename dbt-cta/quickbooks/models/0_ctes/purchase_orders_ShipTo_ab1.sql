{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('purchase_orders') }}
select
    _airbyte_purchase_orders_hashid,
    {{ json_extract_scalar('ShipTo', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('ShipTo', ['value'], ['value']) }} as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('purchase_orders') }} as table_alias
-- ShipTo at purchase_orders/ShipTo
where 1 = 1
and ShipTo is not null

