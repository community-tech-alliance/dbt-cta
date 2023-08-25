{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('items_item_data_variations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_item_data_hashid',
        'id',
        'type',
        'version',
        boolean_to_string('is_deleted'),
        'updated_at',
        object_to_string('item_variation_data'),
        array_to_string('present_at_location_ids'),
        boolean_to_string('present_at_all_locations'),
    ]) }} as _airbyte_variations_hashid,
    tmp.*
from {{ ref('items_item_data_variations_ab2') }} as tmp
-- variations at items/item_data/variations
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

