
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'field_management_projections') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   end_date,
   turf_id,
   name,
   creator_id,
   id,
   total_collected,
   targets,
   start_date,
   {{ dbt_utils.surrogate_key([
     'end_date',
    'turf_id',
    'name',
    'creator_id',
    'id',
    'targets',
    'start_date'
    ]) }} as _airbyte_field_management_projections_hashid
from {{ source('cta', 'field_management_projections') }}