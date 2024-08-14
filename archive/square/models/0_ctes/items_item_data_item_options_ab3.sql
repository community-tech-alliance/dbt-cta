{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('items_item_data_item_options_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_item_data_hashid',
        'item_option_id',
    ]) }} as _airbyte_item_options_hashid,
    tmp.*
from {{ ref('items_item_data_item_options_ab2') }} as tmp
-- item_options at items/item_data/item_options
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

