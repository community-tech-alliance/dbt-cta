{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "freshdesk_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('companies_ab3') }}
select
    id,
    name,
    note,
    domains,
    industry,
    created_at,
    updated_at,
    description,
    account_tier,
    health_score,
    renewal_date,
    custom_fields,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_companies_hashid
from {{ ref('companies_ab3') }}
-- companies from {{ source('freshdesk_partner_a', '_airbyte_raw_companies') }}
where 1 = 1

