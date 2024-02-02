{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'vr_zips_lookup') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    voter_age,
    voter_gender,
    turnout_score_avg,
    count,
    state,
    zip5,
    support_avg,
    party_score_avg,
   {{ dbt_utils.surrogate_key([
     'voter_gender',
    'count',
    'state',
    'zip5'
    ]) }} as _airbyte_vr_zips_lookup_hashid
from {{ source('cta', 'vr_zips_lookup') }}
