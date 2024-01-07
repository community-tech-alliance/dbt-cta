{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_voter_registration_scan_visual_review_responses_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('voter_registration_scan_visual_review_responses_ab2') }}
select * except (_airbyte_raw_id)
from {{ ref('voter_registration_scan_visual_review_responses_ab2') }}