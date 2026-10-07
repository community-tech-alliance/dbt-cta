{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'core_emailwrapper') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    name,
    hidden,
    lang_id,
    template,
    created_at,
    is_default,
    updated_at,
    amp_template,
    text_template,
    unsubscribe_html,
    unsubscribe_text,
    unsubscribe_amp_html
from {{ source('cta', 'core_emailwrapper') }}
