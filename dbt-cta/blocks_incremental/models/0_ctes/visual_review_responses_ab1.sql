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
    implies_skips_phone_verification,
    implies_not_form,
    updated_at,
    reviewable_type,
    response,
    active,
    created_at,
    description,
    grouping_metadata,
    id,
    implies_incomplete_form,
   {{ dbt_utils.surrogate_key([
     'implies_skips_phone_verification',
    'implies_not_form',
    'reviewable_type',
    'response',
    'active',
    'description',
    'grouping_metadata',
    'id',
    'implies_incomplete_form'
    ]) }} as _airbyte_visual_review_responses_hashid
from {{ source('cta', 'visual_review_responses') }}
