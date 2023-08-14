{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('purchase_orders') }}
select
    _airbyte_purchase_orders_hashid,
    {{ json_extract_scalar('ShipAddr', ['Long'], ['Long']) }} as Long,
    {{ json_extract_scalar('ShipAddr', ['Id'], ['Id']) }} as Id,
    {{ json_extract_scalar('ShipAddr', ['Line1'], ['Line1']) }} as Line1,
    {{ json_extract_scalar('ShipAddr', ['Lat'], ['Lat']) }} as Lat,
    {{ json_extract_scalar('ShipAddr', ['Line2'], ['Line2']) }} as Line2,
    {{ json_extract_scalar('ShipAddr', ['Line3'], ['Line3']) }} as Line3,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('purchase_orders') }} as table_alias
-- ShipAddr at purchase_orders/ShipAddr
where 1 = 1
and ShipAddr is not null

