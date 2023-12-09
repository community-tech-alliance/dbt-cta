{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('page') }}
select
    _airbyte_page_hashid,
    {{ json_extract_scalar('contact_address', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('contact_address', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('contact_address', ['street1'], ['street1']) }} as street1,
    {{ json_extract_scalar('contact_address', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('contact_address', ['street2'], ['street2']) }} as street2,
    {{ json_extract_scalar('contact_address', ['region'], ['region']) }} as region,
    {{ json_extract_scalar('contact_address', ['postal_code'], ['postal_code']) }} as postal_code,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page') }} as table_alias
-- contact_address at page/contact_address
where 1 = 1
and contact_address is not null

