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
    id,
    user_id,
    metric_id,
    report_id,
    vote_flag,
    created_at,
    updated_at,
    vote_scope,
    vote_weight,
   {{ dbt_utils.surrogate_key([
     'id',
    'user_id',
    'metric_id',
    'report_id',
    'vote_flag',
    'vote_scope',
    'vote_weight'
    ]) }} as _airbyte_votes_hashid
from {{ source('cta', 'votes') }}
