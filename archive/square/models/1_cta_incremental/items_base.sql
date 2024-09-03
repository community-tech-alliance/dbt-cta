{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('items_ab3') }}
select
    id,
    type,
    version,
    image_id,
    item_data,
    is_deleted,
    updated_at,
    custom_attribute_values,
    present_at_location_ids,
    present_at_all_locations,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_items_hashid
from {{ ref('items_ab3') }}
-- items from {{ source('cta', '_airbyte_raw_items') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

