{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('integrations_ab3') }}
select
    id,
    created_at,
    updated_at,
    campaign_id,
    external_service_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_integrations_hashid
from {{ ref('integrations_ab3') }}
-- integrations from {{ source('cta', '_airbyte_raw_integrations') }}
where 1 = 1

