{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('event_campaign_invites_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'status',
        'event_id',
        'created_at',
        'updated_at',
        'event_campaign_id',
    ]) }} as _airbyte_event_campaign_invites_hashid,
    tmp.*
from {{ ref('event_campaign_invites_ab2') }} as tmp
-- event_campaign_invites
where 1 = 1
