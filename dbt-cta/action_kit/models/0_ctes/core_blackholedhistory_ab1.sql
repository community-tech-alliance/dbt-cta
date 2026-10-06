{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'core_blackholedhistory') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    email,
    action_id,
    created_at,
    mailing_id,
    updated_at,
    matched_email,
    matched_domain,
    matched_pattern
from {{ source('cta', 'core_blackholedhistory') }}
