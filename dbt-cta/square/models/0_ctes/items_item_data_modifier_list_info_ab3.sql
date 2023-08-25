{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('items_item_data_modifier_list_info_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_item_data_hashid',
        boolean_to_string('enabled'),
        'visibility',
        'modifier_list_id',
        'max_selected_modifiers',
        'min_selected_modifiers',
    ]) }} as _airbyte_modifier_list_info_hashid,
    tmp.*
from {{ ref('items_item_data_modifier_list_info_ab2') }} as tmp
-- modifier_list_info at items/item_data/modifier_list_info
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

