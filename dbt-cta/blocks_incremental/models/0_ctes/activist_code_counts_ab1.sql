
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'activist_code_counts') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   count,
   turf_id,
   created_at,
   updated_at,
   datecanvassed,
   activist_code_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'count',
    'turf_id',
    'datecanvassed',
    'activist_code_id'
    ]) }} as _airbyte_activist_code_counts_hashid
from {{ source('cta', 'activist_code_counts') }}