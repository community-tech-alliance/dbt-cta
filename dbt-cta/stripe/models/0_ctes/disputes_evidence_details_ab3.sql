{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('disputes_evidence_details_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_disputes_hashid',
        'due_by',
        boolean_to_string('past_due'),
        boolean_to_string('has_evidence'),
        'submission_count',
    ]) }} as _airbyte_evidence_details_hashid,
    tmp.*
from {{ ref('disputes_evidence_details_ab2') }} as tmp
-- evidence_details at disputes_base/evidence_details
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

