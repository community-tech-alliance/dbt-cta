{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('response_pages_ab1') }}
select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    uuid,
    user_id,
    survey_id,
    created_at,
    updated_at,
    response_id,
    custom_fields,
    survey_page_id
from {{ ref('response_pages_ab1') }}
