{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "freshdesk_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('business_hours_ab3') }}
select
    id,
    name,
    time_zone,
    created_at,
    is_default,
    updated_at,
    description,
    business_hours,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_business_hours_hashid
from {{ ref('business_hours_ab3') }}
-- business_hours from {{ source('freshdesk_partner_a', '_airbyte_raw_business_hours') }}
where 1 = 1

