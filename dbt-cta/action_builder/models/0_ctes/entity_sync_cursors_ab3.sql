{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('entity_sync_cursors_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'cursor',
        'created_at',
        'updated_at',
        'campaign_id',
    ]) }} as _airbyte_entity_sync_cursors_hashid,
    tmp.*
from {{ ref('entity_sync_cursors_ab2') }} tmp
-- entity_sync_cursors
where 1 = 1

