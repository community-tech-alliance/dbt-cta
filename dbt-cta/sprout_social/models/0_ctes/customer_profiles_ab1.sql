{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'customer_profiles') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    native_id,
    link,
    name,
    `groups`,
    customer_profile_id,
    network_type,
    native_name,
   {{ dbt_utils.generate_surrogate_key([
     'native_id',
    'link',
    'name',
    'customer_profile_id',
    'network_type',
    'native_name'
    ]) }} as _airbyte_customer_profiles_hashid
from {{ source('cta', 'customer_profiles') }}
