
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'states') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   full_name,
   created_at,
   state_code,
   updated_at,
   {{ dbt_utils.surrogate_key([
     'full_name',
    'state_code'
    ]) }} as _airbyte_states_hashid
from {{ source('cta', 'states') }}