{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'core_page') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    url,
    goal,
    name,
    type,
    notes,
    title,
    hidden,
    status,
    lang_id,
    list_id,
    goal_type,
    recognize,
    created_at,
    updated_at,
    real_actions,
    hosted_with_id,
    never_spam_check,
    allow_multiple_responses,
    multilingual_campaign_id
from {{ source('cta', 'core_page') }}
