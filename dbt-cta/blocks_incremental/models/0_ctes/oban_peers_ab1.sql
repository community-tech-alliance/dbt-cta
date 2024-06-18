{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'oban_peers') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    name,
    node,
    expires_at,
    started_at,
   {{ dbt_utils.surrogate_key([
     'name',
    'node'
    ]) }} as _airbyte_oban_peers_hashid
from {{ source('cta', 'oban_peers') }}
