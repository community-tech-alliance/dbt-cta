{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'campaign_subscribers') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    profile_id,
    cast(activated_at as {{dbt.type_timestamp()}}) as activated_at,
    cast(opted_out_at as {{dbt.type_timestamp()}}) as opted_out_at,
    phone_number,
   {{ dbt_utils.surrogate_key([
     'id',
    'profile_id',
    'activated_at',
    'opted_out_at',
    'phone_number'
    ]) }} as _airbyte_campaign_subscribers_hashid
from {{ source('cta', 'campaign_subscribers') }}
