{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('emails_ab3') }}
select
    id,
    email,
    source,
    status,
    owner_id,
    created_at,
    email_type,
    owner_type,
    updated_at,
    interact_id,
    created_by_id,
    updated_by_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_emails_hashid
from {{ ref('emails_ab3') }}
-- emails from {{ source('cta', '_airbyte_raw_emails') }}
where 1 = 1

