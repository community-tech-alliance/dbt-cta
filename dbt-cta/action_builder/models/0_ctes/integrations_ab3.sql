{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('integrations_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'created_at',
        'updated_at',
        'campaign_id',
        'external_service_id',
    ]) }} as _airbyte_integrations_hashid,
    tmp.*
from {{ ref('integrations_ab2') }} as tmp
-- integrations
where 1 = 1
