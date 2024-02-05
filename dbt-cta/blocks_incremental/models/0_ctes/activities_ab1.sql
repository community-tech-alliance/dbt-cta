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
    trackable_id,
    owner_id,
    created_at,
    contacted_at,
    trackable_type,
    recipient_type,
    contact_type,
    updated_at,
    user_id,
    meta,
    id,
    parameters,
    key,
    owner_type,
    person_id,
    recipient_id,
   {{ dbt_utils.surrogate_key([
     'trackable_id',
    'owner_id',
    'trackable_type',
    'recipient_type',
    'contact_type',
    'user_id',
    'meta',
    'id',
    'parameters',
    'key',
    'owner_type',
    'person_id',
    'recipient_id'
    ]) }} as _airbyte_activities_hashid
from {{ source('cta', 'activities') }}
