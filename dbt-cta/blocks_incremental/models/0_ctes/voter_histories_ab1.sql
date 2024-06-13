
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
   id,
   county,
   pct_label,
   person_id,
   vtd_label,
   created_at,
   updated_at,
   election_id,
   voter_state,
   voting_method,
   voted_county_id,
   voted_party_code,
   voter_reg_number,
   {{ dbt_utils.surrogate_key([
     'id',
    'county',
    'pct_label',
    'person_id',
    'vtd_label',
    'election_id',
    'voter_state',
    'voting_method',
    'voted_county_id',
    'voted_party_code',
    'voter_reg_number'
    ]) }} as _airbyte_voter_histories_hashid
from {{ source('cta', 'voter_histories') }}