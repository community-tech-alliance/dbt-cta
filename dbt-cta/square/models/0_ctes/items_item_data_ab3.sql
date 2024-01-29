{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('items_item_data_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_items_hashid',
        'name',
        array_to_string('tax_ids'),
        array_to_string('variations'),
        'visibility',
        'category_id',
        'description',
        array_to_string('item_options'),
        'product_type',
        'ecom_visibility',
        array_to_string('modifier_list_info'),
        boolean_to_string('skip_modifier_screen'),
    ]) }} as _airbyte_item_data_hashid,
    tmp.*
from {{ ref('items_item_data_ab2') }} as tmp
-- item_data at items/item_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

