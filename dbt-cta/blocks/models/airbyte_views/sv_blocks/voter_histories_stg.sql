{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('voter_histories_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'pct_label',
        'vtd_label',
        'county',
        'created_at',
        'voter_reg_number',
        'voter_state',
        'updated_at',
        'voted_party_code',
        'voted_county_id',
        'election_id',
        'id',
        'voting_method',
        'person_id',
    ]) }} as _airbyte_voter_histories_hashid,
    tmp.*
from {{ ref('voter_histories_ab2') }} tmp
-- voter_histories
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

