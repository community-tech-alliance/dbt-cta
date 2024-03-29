{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('customers') }}
select
    _airbyte_customers_hashid,
    {{ json_extract_scalar('address', ['locality'], ['locality']) }} as locality,
    {{ json_extract_scalar('address', ['postal_code'], ['postal_code']) }} as postal_code,
    {{ json_extract_scalar('address', ['address_line_1'], ['address_line_1']) }} as address_line_1,
    {{ json_extract_scalar('address', ['address_line_2'], ['address_line_2']) }} as address_line_2,
    {{ json_extract_scalar('address', ['administrative_district_level_1'], ['administrative_district_level_1']) }} as administrative_district_level_1,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_base') }}
-- address at customers/address
where
    1 = 1
    and address is not null
