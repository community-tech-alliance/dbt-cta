{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('disputes_evidence_details_ab3') }}
select
    _airbyte_disputes_hashid,
    due_by,
    past_due,
    has_evidence,
    submission_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_evidence_details_hashid
from {{ ref('disputes_evidence_details_ab3') }}
-- evidence_details at disputes/evidence_details from {{ ref('disputes') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

