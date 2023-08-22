{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaign_entity_types_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'created_at',
        'updated_at',
        'campaign_id',
        'entity_type_id',
    ]) }} as _airbyte_campaign_entity_types_hashid,
    tmp.*
from {{ ref('campaign_entity_types_ab2') }} as tmp
-- campaign_entity_types
where 1 = 1
