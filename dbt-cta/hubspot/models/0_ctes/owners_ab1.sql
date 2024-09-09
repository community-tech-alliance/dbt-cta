
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'owners') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   _airbyte_generation_id,
   id,
   email,
   teams,
   userId,
   archived,
   lastName,
   createdAt,
   firstName,
   updatedAt,
   {{ dbt_utils.surrogate_key([
     'id',
    'email',
    'userId',
    'archived',
    'lastName',
    'createdAt',
    'firstName',
    'updatedAt'
    ]) }} as _airbyte_owners_hashid
from {{ source('cta', 'owners') }}