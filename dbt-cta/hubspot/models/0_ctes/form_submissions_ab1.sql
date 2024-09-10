
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'form_submissions') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   _airbyte_generation_id,
   formId,
   values,
   pageUrl,
   updatedAt,
   submittedAt,
   {{ dbt_utils.surrogate_key([
     'formId',
    'pageUrl',
    'updatedAt',
    'submittedAt'
    ]) }} as _airbyte_form_submissions_hashid
from {{ source('cta', 'form_submissions') }}