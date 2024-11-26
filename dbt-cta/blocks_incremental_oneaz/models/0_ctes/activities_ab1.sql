{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'activities') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    key,
    meta,
    user_id,
    owner_id,
    person_id,
    created_at,
    owner_type,
    parameters,
    updated_at,
    contact_type,
    contacted_at,
    recipient_id,
    trackable_id,
    recipient_type,
    trackable_type,
   {{ dbt_utils.surrogate_key([
     'id',
    'key',
    'meta',
    'user_id',
    'owner_id',
    'person_id',
    'owner_type',
    'parameters',
    'contact_type',
    'recipient_id',
    'trackable_id',
    'recipient_type',
    'trackable_type'
    ]) }} as _airbyte_activities_hashid
from {{ source('cta', 'activities') }}
