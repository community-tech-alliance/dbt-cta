{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'blocked_tokens') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    inserted_at,
    token,
   {{ dbt_utils.surrogate_key([
     'id',
    'token'
    ]) }} as _airbyte_blocked_tokens_hashid
from {{ source('cta', 'blocked_tokens') }}
