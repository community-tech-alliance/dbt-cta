
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'group_members') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   etag,
   kind,
   role,
   type,
   email,
   status,
   {{ dbt_utils.surrogate_key([
     'id',
    'etag',
    'kind',
    'role',
    'type',
    'email',
    'status'
    ]) }} as _airbyte_group_members_hashid
from {{ source('cta', 'group_members') }}