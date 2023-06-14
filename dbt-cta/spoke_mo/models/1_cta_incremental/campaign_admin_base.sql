{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaign_admin_ab3') }}
select
    ingest_method,
    ingest_data_reference,
    deleted_optouts_count,
    updated_at,
    ingest_success,
    created_at,
    id,
    ingest_result,
    duplicate_contacts_count,
    contacts_count,
    campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_campaign_admin_hashid
from {{ ref('campaign_admin_ab3') }}
-- campaign_admin from {{ source('cta', '_airbyte_raw_campaign_admin') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

