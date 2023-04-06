{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('email_campaigns_ab3') }}
select
    id,
    name,
    hidden,
    group_id,
    created_at,
    updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_email_campaigns_hashid
from {{ ref('email_campaigns_ab3') }}
-- email_campaigns from {{ source('cta', '_airbyte_raw_email_campaigns') }}
where 1 = 1

