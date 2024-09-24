{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('voter_registration_scan_visual_review_responses_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'updated_at',
        'voter_registration_scan_id',
        'user_id',
        'petition_signature_id',
        'created_at',
        'id',
        'visual_review_response_id',
    ]) }} as _airbyte_voter_registration_scan_visual_review_responses_hashid,
    tmp.*
from {{ ref('voter_registration_scan_visual_review_responses_ab2') }} as tmp
-- voter_registration_scan_visual_review_responses
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

