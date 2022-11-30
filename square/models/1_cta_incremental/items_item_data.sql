{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('items_item_data_ab3') }}
select
    _airbyte_items_hashid,
    name,
    tax_ids,
    variations,
    visibility,
    category_id,
    description,
    item_options,
    product_type,
    ecom_visibility,
    modifier_list_info,
    skip_modifier_screen,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_item_data_hashid
from {{ ref('items_item_data_ab3') }}
-- item_data at items/item_data from {{ ref('items') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

