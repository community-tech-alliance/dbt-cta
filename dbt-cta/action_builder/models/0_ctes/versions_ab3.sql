{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('versions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'event',
        'object',
        'item_id',
        'item_type',
        'whodunnit',
        'created_at',
        'object_changes',
    ]) }} as _airbyte_versions_hashid,
    tmp.*
from {{ ref('versions_ab2') }} as tmp
-- versions
where 1 = 1
