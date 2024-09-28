{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'workflows') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    name,
    type,
    enabled,
    portalId,
    updatedAt,
    insertedAt,
    description,
    updateSource,
    contactCounts,
    personaTagIds,
    contactListIds,
    creationSource,
    migrationStatus,
    lastUpdatedByUserId,
    contactListIds_steps,
    originalAuthorUserId,
    contactListIds_active,
    contactListIds_enrolled,
    contactListIds_completed,
    contactListIds_succeeded,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'type',
    'enabled',
    'portalId',
    'updatedAt',
    'insertedAt',
    'description',
    'lastUpdatedByUserId',
    'originalAuthorUserId',
    'contactListIds_active',
    'contactListIds_enrolled',
    'contactListIds_completed',
    'contactListIds_succeeded'
    ]) }} as _airbyte_workflows_hashid
from {{ source('cta', 'workflows') }}
