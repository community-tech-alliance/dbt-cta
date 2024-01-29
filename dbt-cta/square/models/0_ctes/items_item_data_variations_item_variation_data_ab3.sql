{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('items_item_data_variations_item_variation_data_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_variations_hashid',
        'sku',
        'name',
        'item_id',
        'ordinal',
        object_to_string('price_money'),
        'pricing_type',
        array_to_string('item_option_values'),
        array_to_string('location_overrides'),
    ]) }} as _airbyte_item_variation_data_hashid,
    tmp.*
from {{ ref('items_item_data_variations_item_variation_data_ab2') }} as tmp
-- item_variation_data at items/item_data/variations/item_variation_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

