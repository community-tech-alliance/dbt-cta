{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('actions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'source_id',
        'created_at',
        'updated_at',
        'campaign_id',
        'source_type',
    ]) }} as _airbyte_actions_hashid,
    tmp.*
from {{ ref('actions_ab2') }} as tmp
-- actions
where 1 = 1
