
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'check_ins') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   end_date,
   updated_at,
   turf_id,
   created_at,
   days_of_the_week,
   id,
   {{ dbt_utils.surrogate_key([
     'end_date',
    'turf_id',
    'id'
    ]) }} as _airbyte_check_ins_hashid
from {{ source('cta', 'check_ins') }}