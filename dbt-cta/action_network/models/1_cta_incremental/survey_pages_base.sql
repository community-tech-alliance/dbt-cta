{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('survey_pages_ab1') }}
select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    uuid,
    title,
    heading,
    survey_id,
    conditions,
    created_at,
    updated_at,
    conditional,
    description_text,
    form_builder_output,
    administrative_title,
    form_builder_output_json
from {{ ref('survey_pages_ab1') }}
