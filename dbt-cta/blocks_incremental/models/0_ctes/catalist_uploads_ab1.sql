
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'catalist_uploads') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   uuid,
   status,
   remote_id,
   created_at,
   updated_at,
   remote_file_url,
   {{ dbt_utils.surrogate_key([
     'id',
    'uuid',
    'status',
    'remote_id',
    'remote_file_url'
    ]) }} as _airbyte_catalist_uploads_hashid
from {{ source('cta', 'catalist_uploads') }}