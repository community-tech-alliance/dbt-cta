
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'tenants') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   contact_phone,
   logo_data,
   created_at,
   leaderboard_metrics,
   logo_old,
   contact_email,
   updated_at,
   shift_times,
   name,
   options,
   subdomain,
   contact_last_name,
   id,
   contact_first_name,
   status,
   {{ dbt_utils.surrogate_key([
     'contact_phone',
    'logo_data',
    'logo_old',
    'contact_email',
    'name',
    'options',
    'subdomain',
    'contact_last_name',
    'id',
    'contact_first_name',
    'status'
    ]) }} as _airbyte_tenants_hashid
from {{ source('cta', 'tenants') }}