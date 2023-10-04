{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaign_context_notes_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'text',
        'owner_id',
        'created_at',
        'owner_type',
        'updated_at',
        'campaign_id',
        'created_by_id',
    ]) }} as _airbyte_campaign_context_notes_hashid,
    tmp.*
from {{ ref('campaign_context_notes_ab2') }} as tmp
-- campaign_context_notes
where 1 = 1
