{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaign_participations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'user_id',
        'created_at',
        'updated_at',
        'campaign_id',
    ]) }} as _airbyte_campaign_participations_hashid,
    tmp.*
from {{ ref('campaign_participations_ab2') }} tmp
-- campaign_participations
where 1 = 1

