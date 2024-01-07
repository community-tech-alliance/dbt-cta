{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'voter_histories') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    pct_label,
    vtd_label,
    county,
    created_at,
    voter_reg_number,
    voter_state,
    updated_at,
    voted_party_code,
    voted_county_id,
    election_id,
    id,
    voting_method,
    person_id,
   {{ dbt_utils.surrogate_key([
     'pct_label',
    'vtd_label',
    'county',
    'voter_reg_number',
    'voter_state',
    'voted_party_code',
    'voted_county_id',
    'election_id',
    'id',
    'voting_method',
    'person_id'
    ]) }} as _airbyte_voter_histories_hashid
from {{ source('cta', 'voter_histories') }}
