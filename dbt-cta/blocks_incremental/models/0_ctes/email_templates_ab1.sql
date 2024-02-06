{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'email_templates') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    updated_at,
    template_content,
    name,
    extras,
    created_at,
    id,
    created_by_user_id,
   {{ dbt_utils.surrogate_key([
     'template_content',
    'name',
    'extras',
    'id',
    'created_by_user_id'
    ]) }} as _airbyte_email_templates_hashid
from {{ source('cta', 'email_templates') }}
