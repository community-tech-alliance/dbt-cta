
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'votes') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   metric_id,
   vote_weight,
   updated_at,
   user_id,
   vote_flag,
   report_id,
   created_at,
   id,
   vote_scope,
   {{ dbt_utils.surrogate_key([
     'metric_id',
    'vote_weight',
    'user_id',
    'vote_flag',
    'report_id',
    'id',
    'vote_scope'
    ]) }} as _airbyte_votes_hashid
from {{ source('cta', 'votes') }}