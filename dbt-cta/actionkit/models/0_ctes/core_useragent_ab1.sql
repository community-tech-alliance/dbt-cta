{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'core_useragent') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    os,
    `hash`,
    device,
    browser,
    is_phone,
    is_mobile,
    is_tablet,
    created_at,
    is_desktop,
    os_version,
    updated_at,
    browser_version,
    useragent_string
from {{ source('cta', 'core_useragent') }}
