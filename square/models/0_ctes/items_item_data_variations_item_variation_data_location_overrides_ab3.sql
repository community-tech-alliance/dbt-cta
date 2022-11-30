{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('items_item_data_variations_item_variation_data_location_overrides_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_item_variation_data_hashid',
        'location_id',
        boolean_to_string('track_inventory'),
    ]) }} as _airbyte_location_overrides_hashid,
    tmp.*
from {{ ref('items_item_data_variations_item_variation_data_location_overrides_ab2') }} tmp
-- location_overrides at items/item_data/variations/item_variation_data/location_overrides
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

