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
    id,
    name,
    targets,
    turf_id,
    end_date,
    creator_id,
    start_date,
    total_collected,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'targets',
    'turf_id',
    'end_date',
    'creator_id',
    'start_date'
    ]) }} as _airbyte_field_management_projections_hashid
from {{ source('cta', 'field_management_projections') }}
