
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
   updated_at,
   remote_file_url,
   remote_id,
   created_at,
   id,
   uuid,
   status,
   {{ dbt_utils.surrogate_key([
     'remote_file_url',
    'remote_id',
    'id',
    'uuid',
    'status'
    ]) }} as _airbyte_catalist_uploads_hashid
from {{ source('cta', 'catalist_uploads') }}