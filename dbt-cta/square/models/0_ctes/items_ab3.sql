{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('items_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'type',
        'version',
        'image_id',
        object_to_string('item_data'),
        boolean_to_string('is_deleted'),
        'updated_at',
        object_to_string('custom_attribute_values'),
        array_to_string('present_at_location_ids'),
        boolean_to_string('present_at_all_locations'),
    ]) }} as _airbyte_items_hashid,
    tmp.*
from {{ ref('items_ab2') }} as tmp
-- items
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

