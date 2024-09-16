{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'subscription_changes') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    changes,
    portalId,
    recipient,
    timestamp,
    normalizedEmailId,
   {{ dbt_utils.surrogate_key([
     'portalId',
    'recipient',
    'timestamp',
    'normalizedEmailId'
    ]) }} as _airbyte_subscription_changes_hashid
from {{ source('cta', 'subscription_changes') }}
