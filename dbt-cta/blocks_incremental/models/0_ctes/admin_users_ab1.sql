
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'admin_users') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   email,
   session,
   encrypted_password,
   {{ dbt_utils.surrogate_key([
     'id',
    'email',
    'session',
    'encrypted_password'
    ]) }} as _airbyte_admin_users_hashid
from {{ source('cta', 'admin_users') }}