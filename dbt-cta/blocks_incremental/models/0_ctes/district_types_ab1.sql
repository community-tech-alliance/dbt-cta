
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'district_types') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   label,
   created_at,
   updated_at,
   primary_key,
   {{ dbt_utils.surrogate_key([
     'id',
    'label',
    'primary_key'
    ]) }} as _airbyte_district_types_hashid
from {{ source('cta', 'district_types') }}