{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'contacts_form_submissions') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    title,
    form_id,
    page_url,
    form_type,
    meta_data,
    portal_id,
    timestamp,
    page_title,
    canonical_url,
    canonical_vid,
    conversion_id,
    contact_associated_by,
   {{ dbt_utils.surrogate_key([
     'title',
    'form_id',
    'page_url',
    'form_type',
    'portal_id',
    'timestamp',
    'page_title',
    'canonical_url',
    'canonical_vid',
    'conversion_id'
    ]) }} as _airbyte_contacts_form_submissions_hashid
from {{ source('cta', 'contacts_form_submissions') }}
