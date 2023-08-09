{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('purchase_orders') }}
select
    _airbyte_purchase_orders_hashid,
    {{ json_extract_scalar('VendorAddr', ['Line4'], ['Line4']) }} as Line4,
    {{ json_extract_scalar('VendorAddr', ['Long'], ['Long']) }} as Long,
    {{ json_extract_scalar('VendorAddr', ['Country'], ['Country']) }} as Country,
    {{ json_extract_scalar('VendorAddr', ['Id'], ['Id']) }} as Id,
    {{ json_extract_scalar('VendorAddr', ['City'], ['City']) }} as City,
    {{ json_extract_scalar('VendorAddr', ['Line1'], ['Line1']) }} as Line1,
    {{ json_extract_scalar('VendorAddr', ['Lat'], ['Lat']) }} as Lat,
    {{ json_extract_scalar('VendorAddr', ['Line2'], ['Line2']) }} as Line2,
    {{ json_extract_scalar('VendorAddr', ['Line3'], ['Line3']) }} as Line3,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('purchase_orders') }} as table_alias
-- VendorAddr at purchase_orders/VendorAddr
where 1 = 1
and VendorAddr is not null

