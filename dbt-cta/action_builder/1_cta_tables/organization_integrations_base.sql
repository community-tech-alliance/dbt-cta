{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('organization_integrations_ab3') }}
select
    id,
    settings,
    created_at,
    updated_at,
    service_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_organization_integrations_hashid
from {{ ref('organization_integrations_ab3') }}
-- organization_integrations from {{ source('cta', '_airbyte_raw_organization_integrations') }}
where 1 = 1

