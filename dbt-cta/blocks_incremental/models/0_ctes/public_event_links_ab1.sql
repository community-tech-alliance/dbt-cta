
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'public_event_links') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   event_id,
   user_id,
   id,
   url,
   {{ dbt_utils.surrogate_key([
     'event_id',
    'user_id',
    'id',
    'url'
    ]) }} as _airbyte_public_event_links_hashid
from {{ source('cta', 'public_event_links') }}