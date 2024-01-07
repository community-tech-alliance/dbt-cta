
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'districts') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   district_name,
   updated_at,
   extras,
   created_at,
   id,
   state,
   district_type,
   district_type_id,
   {{ dbt_utils.surrogate_key([
     'district_name',
    'extras',
    'id',
    'state',
    'district_type',
    'district_type_id'
    ]) }} as _airbyte_districts_hashid
from {{ source('cta', 'districts') }}