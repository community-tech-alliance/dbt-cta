{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('disputes_base') }}
select
    _airbyte_disputes_hashid,
    {{ json_extract_scalar('evidence_details', ['due_by'], ['due_by']) }} as due_by,
    {{ json_extract_scalar('evidence_details', ['past_due'], ['past_due']) }} as past_due,
    {{ json_extract_scalar('evidence_details', ['has_evidence'], ['has_evidence']) }} as has_evidence,
    {{ json_extract_scalar('evidence_details', ['submission_count'], ['submission_count']) }} as submission_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('disputes_base') }} as table_alias
-- evidence_details at disputes_base/evidence_details
where 1 = 1
and evidence_details is not null
{{ incremental_clause('_airbyte_emitted_at') }}

