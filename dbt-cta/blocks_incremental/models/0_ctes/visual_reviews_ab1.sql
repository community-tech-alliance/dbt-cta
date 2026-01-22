{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'visual_review_responses') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    user_id,
    created_at,
    updated_at,
    petition_page_id,
    petition_signature_id,
    visual_review_response_id,
    voter_registration_form_id,
    voter_registration_scan_id
from {{ source('cta', 'visual_reviews') }}
