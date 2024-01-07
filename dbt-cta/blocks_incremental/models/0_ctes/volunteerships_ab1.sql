
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'volunteerships') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   event_shift_id,
   updated_at,
   user_id,
   responsibility,
   created_at,
   id,
   responsibility_id,
   person_id,
   {{ dbt_utils.surrogate_key([
     'event_shift_id',
    'user_id',
    'responsibility',
    'id',
    'responsibility_id',
    'person_id'
    ]) }} as _airbyte_volunteerships_hashid
from {{ source('cta', 'volunteerships') }}