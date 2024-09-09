
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'email_subscriptions') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   _airbyte_generation_id,
   id,
   name,
   order,
   active,
   channel,
   category,
   internal,
   portalId,
   description,
   internalName,
   businessUnitId,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'order',
    'active',
    'channel',
    'category',
    'internal',
    'portalId',
    'description',
    'internalName',
    'businessUnitId'
    ]) }} as _airbyte_email_subscriptions_hashid
from {{ source('cta', 'email_subscriptions') }}