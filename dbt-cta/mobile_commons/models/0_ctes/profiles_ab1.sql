{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'profiles') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    email,
    clicks,
    source,
    status,
    address,
    last_name,
    cast(created_at as {{ dbt.type_timestamp() }}) as created_at,
    first_name,
    cast(updated_at as {{ dbt.type_timestamp() }}) as updated_at,
    integrations,
    cast(opted_out_at as {{ dbt.type_timestamp() }}) as opted_out_at,
    phone_number,
    subscriptions,
    custom_columns,
    opted_out_source,
    last_saved_location,
    last_saved_districts,
   {{ dbt_utils.surrogate_key([
     'id',
    'email',
    'clicks',
    'status',
    'last_name',
    'created_at',
    'first_name',
    'updated_at',
    'opted_out_at',
    'phone_number',
    'opted_out_source'
    ]) }} as _airbyte_profiles_hashid
from {{ source('cta', 'profiles') }}
