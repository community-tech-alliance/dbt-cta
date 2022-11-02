{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('sla_policies_applicable_to_ab1') }}
select
    _airbyte_sla_policies_hashid,
    sources,
    group_ids,
    company_ids,
    product_ids,
    ticket_types,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sla_policies_applicable_to_ab1') }}
-- applicable_to at sla_policies/applicable_to
where 1 = 1

