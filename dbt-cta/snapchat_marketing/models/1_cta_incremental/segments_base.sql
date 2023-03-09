{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}

-- depends_on: {{ ref('segments_ab2') }}
select
    id,
    name,
    status,
    created_at,
    updated_at,
    visible_to,
    description,
    source_type,
    ad_account_id,
    upload_status,
    organization_id,
    retention_in_days,
    targetable_status,
    approximate_number_users,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('segments_ab2') }}
