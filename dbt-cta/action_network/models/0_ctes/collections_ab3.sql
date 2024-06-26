{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('collections_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'title',
        'group_id',
        'created_at',
        'network_id',
        'updated_at',
    ]) }} as _airbyte_collections_hashid,
    tmp.*
from {{ ref('collections_ab2') }} as tmp
-- collections
where 1 = 1
