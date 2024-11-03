{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'catalist_uploads_registration_forms') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    catalist_upload_id,
    registration_form_id,
   {{ dbt_utils.surrogate_key([
     'catalist_upload_id',
    'registration_form_id'
    ]) }} as _airbyte_catalist_uploads_registration_forms_hashid
from {{ source('cta', 'catalist_uploads_registration_forms') }}
