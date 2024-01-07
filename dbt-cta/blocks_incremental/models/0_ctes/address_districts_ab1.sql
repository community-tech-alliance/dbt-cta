
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'address_districts') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   address_id,
   district_id,
   district_type,
   {{ dbt_utils.surrogate_key([
     'address_id',
    'district_id',
    'district_type'
    ]) }} as _airbyte_address_districts_hashid
from {{ source('cta', 'address_districts') }}