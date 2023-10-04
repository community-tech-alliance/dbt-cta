{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('assessments_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'level',
        'owner_id',
        'created_at',
        'owner_type',
        'updated_at',
        'campaign_id',
        'created_by_id',
        'updated_by_id',
    ]) }} as _airbyte_assessments_hashid,
    tmp.*
from {{ ref('assessments_ab2') }} as tmp
-- assessments
where 1 = 1
