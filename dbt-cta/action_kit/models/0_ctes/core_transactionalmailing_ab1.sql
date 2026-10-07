{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'core_transactionalmailing') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    body,
    type,
    hidden,
    status,
    page_id,
    subject,
    reply_to,
    signature,
    created_at,
    updated_at,
    wrapper_id,
    custom_from,
    from_line_id,
    variation_id
from {{ source('cta', 'core_transactionalmailing') }}
