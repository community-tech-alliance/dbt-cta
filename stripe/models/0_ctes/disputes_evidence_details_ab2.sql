{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('disputes_evidence_details_ab1') }}
select
    _airbyte_disputes_hashid,
    cast(due_by as {{ dbt_utils.type_float() }}) as due_by,
    {{ cast_to_boolean('past_due') }} as past_due,
    {{ cast_to_boolean('has_evidence') }} as has_evidence,
    cast(submission_count as {{ dbt_utils.type_bigint() }}) as submission_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('disputes_evidence_details_ab1') }}
-- evidence_details at disputes/evidence_details
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

