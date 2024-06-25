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
    active,
    response,
    created_at,
    updated_at,
    description,
    reviewable_type,
    implies_not_form,
    grouping_metadata,
    implies_incomplete_form,
    implies_skips_phone_verification,
   {{ dbt_utils.surrogate_key([
     'id',
    'active',
    'response',
    'description',
    'reviewable_type',
    'implies_not_form',
    'grouping_metadata',
    'implies_incomplete_form',
    'implies_skips_phone_verification'
    ]) }} as _airbyte_visual_review_responses_hashid
from {{ source('cta', 'visual_review_responses') }}
