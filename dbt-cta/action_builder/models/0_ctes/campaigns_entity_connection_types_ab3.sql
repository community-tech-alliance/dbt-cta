{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_entity_connection_types_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'created_at',
        'updated_at',
        'campaign_id',
        'entity_connection_type_id',
    ]) }} as _airbyte_campaigns_entity_connection_types_hashid,
    tmp.*
from {{ ref('campaigns_entity_connection_types_ab2') }} as tmp
-- campaigns_entity_connection_types
where 1 = 1
