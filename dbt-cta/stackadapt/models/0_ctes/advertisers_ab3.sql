{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('advertisers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'description',
        array_to_string('all_line_item_ids'),
    ]) }} as _airbyte_advertisers_hashid,
    tmp.*
from {{ ref('advertisers_ab2') }} as tmp
-- advertisers
where 1 = 1
