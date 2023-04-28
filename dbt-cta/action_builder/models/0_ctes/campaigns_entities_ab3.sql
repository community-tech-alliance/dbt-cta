{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_entities_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'entity_id',
        'created_at',
        'updated_at',
        'campaign_id',
        'latest_assessment_id',
        'latest_assessment_level',
    ]) }} as _airbyte_campaigns_entities_hashid,
    tmp.*
from {{ ref('campaigns_entities_ab2') }} tmp
-- campaigns_entities
where 1 = 1

