{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('freshdesk_partner_a', '_airbyte_raw_settings') }}
select
    {{ json_extract_string_array('_airbyte_data', ['portal_languages'], ['portal_languages']) }} as portal_languages,
    {{ json_extract_scalar('_airbyte_data', ['primary_language'], ['primary_language']) }} as primary_language,
    {{ json_extract_string_array('_airbyte_data', ['supported_languages'], ['supported_languages']) }} as supported_languages,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('freshdesk_partner_a', '_airbyte_raw_settings') }} as table_alias
-- settings
where 1 = 1

