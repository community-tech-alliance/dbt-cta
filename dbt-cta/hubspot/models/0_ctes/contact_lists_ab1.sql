{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'contact_lists') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    name,
    listId,
    dynamic,
    filters,
    teamIds,
    archived,
    authorId,
    internal,
    listType,
    metaData,
    parentId,
    portalId,
    readOnly,
    createdAt,
    updatedAt,
    deleteable,
    limitExempt,
    metaData_size,
    internalListId,
    metaData_error,
    ilsFilterBranch,
    metaData_processing,
    metaData_parentFolderId,
    metaData_lastSizeChangeAt,
    metaData_listReferencesCount,
    metaData_lastProcessingStateChangeAt,
   {{ dbt_utils.surrogate_key([
     'name',
    'listId',
    'dynamic',
    'archived',
    'authorId',
    'internal',
    'listType',
    'parentId',
    'portalId',
    'readOnly',
    'createdAt',
    'updatedAt',
    'deleteable',
    'limitExempt',
    'metaData_size',
    'internalListId',
    'metaData_error',
    'ilsFilterBranch',
    'metaData_processing',
    'metaData_parentFolderId',
    'metaData_lastSizeChangeAt',
    'metaData_listReferencesCount',
    'metaData_lastProcessingStateChangeAt'
    ]) }} as _airbyte_contact_lists_hashid
from {{ source('cta', 'contact_lists') }}
