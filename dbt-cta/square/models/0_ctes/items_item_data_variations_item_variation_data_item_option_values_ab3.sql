{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('items_item_data_variations_item_variation_data_item_option_values_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_item_variation_data_hashid',
        'item_option_id',
        'item_option_value_id',
    ]) }} as _airbyte_item_option_values_hashid,
    tmp.*
from {{ ref('items_item_data_variations_item_variation_data_item_option_values_ab2') }} tmp
-- item_option_values at items/item_data/variations/item_variation_data/item_option_values
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

