{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('locations') }}
select
    _airbyte_locations_hashid,
    {{ json_extract_scalar('address', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('address', ['locality'], ['locality']) }} as locality,
    {{ json_extract_scalar('address', ['postal_code'], ['postal_code']) }} as postal_code,
    {{ json_extract_scalar('address', ['address_line_1'], ['address_line_1']) }} as address_line_1,
    {{ json_extract_scalar('address', ['administrative_district_level_1'], ['administrative_district_level_1']) }} as administrative_district_level_1,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('locations_base') }} as table_alias
-- address at locations/address
where 1 = 1
and address is not null

