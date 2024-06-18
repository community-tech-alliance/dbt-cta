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
    id,
    name,
    status,
    options,
    logo_old,
    logo_data,
    subdomain,
    created_at,
    updated_at,
    shift_times,
    contact_email,
    contact_phone,
    contact_last_name,
    contact_first_name,
    leaderboard_metrics,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'status',
    'options',
    'logo_old',
    'logo_data',
    'subdomain',
    'contact_email',
    'contact_phone',
    'contact_last_name',
    'contact_first_name'
    ]) }} as _airbyte_tenants_hashid
from {{ source('cta', 'tenants') }}
