{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_line_items_ab3') }}
select
    _airbyte_orders_hashid,
    uid,
    name,
    note,
    quantity,
    item_type,
    modifiers,
    total_money,
    applied_taxes,
    variation_name,
    total_tax_money,
    base_price_money,
    applied_discounts,
    catalog_object_id,
    gross_sales_money,
    total_discount_money,
    variation_total_price_money,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_line_items_hashid
from {{ ref('orders_line_items_ab3') }}
-- line_items at orders/line_items from {{ ref('orders') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

