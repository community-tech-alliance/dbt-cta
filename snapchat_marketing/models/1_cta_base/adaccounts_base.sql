{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}

-- depends_on: {{ ref('adaccounts_ab3') }}
select
    id,
    name,
    type,
    status,
    currency,
    timezone,
    created_at,
    updated_at,
    regulations,
    billing_type,
    organization_id,
    billing_center_id,
    funding_source_ids,
    client_paying_invoices,
    advertiser_organization_id,
    agency_representing_client,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_adaccounts_hashid
from {{ ref('adaccounts_ab3') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

