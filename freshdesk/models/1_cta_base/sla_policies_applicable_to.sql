{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "freshdesk_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('sla_policies_applicable_to_ab3') }}
select
    _airbyte_sla_policies_hashid,
    sources,
    group_ids,
    company_ids,
    product_ids,
    ticket_types,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_applicable_to_hashid
from {{ ref('sla_policies_applicable_to_ab3') }}
-- applicable_to at sla_policies/applicable_to from {{ ref('sla_policies') }}
where 1 = 1

