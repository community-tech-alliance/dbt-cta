
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
   zip5,
   count,
   state,
   voter_age,
   support_avg,
   voter_gender,
   party_score_avg,
   turnout_score_avg,
   {{ dbt_utils.surrogate_key([
     'zip5',
    'count',
    'state',
    'voter_gender'
    ]) }} as _airbyte_vr_zips_lookup_hashid
from {{ source('cta', 'vr_zips_lookup') }}