{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'voter_registration_scan_visual_review_responses') }}

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
    voter_registration_scan_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'user_id',
    'petition_page_id',
    'petition_signature_id',
    'visual_review_response_id',
    'voter_registration_scan_id'
    ]) }} as _airbyte_voter_registration_scan_visual_review_responses_hashid
from {{ source('cta', 'voter_registration_scan_visual_review_responses') }}
