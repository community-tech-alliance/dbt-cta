
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'scheduled_exports_turfs') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   scheduled_export_id,
   turf_id,
   {{ dbt_utils.surrogate_key([
     'scheduled_export_id',
    'turf_id'
    ]) }} as _airbyte_scheduled_exports_turfs_hashid
from {{ source('cta', 'scheduled_exports_turfs') }}