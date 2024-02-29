{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'clicks') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    url,
    created_at,
    profile_id,
    user_agent,
    clicked_url,
    remote_addr,
    http_referer,
   {{ dbt_utils.surrogate_key([
     'id',
    'url',
    'created_at',
    'profile_id',
    'user_agent',
    'clicked_url',
    'remote_addr',
    'http_referer'
    ]) }} as _airbyte_clicks_hashid
from {{ source('cta', 'clicks') }}
