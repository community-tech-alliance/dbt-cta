
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'deal_pipelines') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   _airbyte_generation_id,
   label,
   active,
   stages,
   `default`,
   createdAt,
   updatedAt,
   objectType,
   pipelineId,
   displayOrder,
   objectTypeId,
   {{ dbt_utils.surrogate_key([
     'label',
    'active',
    'createdAt',
    'updatedAt',
    'objectType',
    'pipelineId',
    'displayOrder',
    'objectTypeId'
    ]) }} as _airbyte_deal_pipelines_hashid
from {{ source('cta', 'deal_pipelines') }}