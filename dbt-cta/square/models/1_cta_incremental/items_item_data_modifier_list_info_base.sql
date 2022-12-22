{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('items_item_data_modifier_list_info_ab3') }}
select
    _airbyte_item_data_hashid,
    enabled,
    visibility,
    modifier_list_id,
    max_selected_modifiers,
    min_selected_modifiers,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_modifier_list_info_hashid
from {{ ref('items_item_data_modifier_list_info_ab3') }}
-- modifier_list_info at items/item_data/modifier_list_info from {{ ref('items_item_data') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

