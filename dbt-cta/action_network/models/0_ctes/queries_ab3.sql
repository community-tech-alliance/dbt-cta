{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('queries_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'uuid',
        'params',
        'user_id',
        'group_id',
        'created_at',
        'creator_id',
        'updated_at',
    ]) }} as _airbyte_queries_hashid,
    tmp.*
from {{ ref('queries_ab2') }} as tmp
-- queries
where 1 = 1
