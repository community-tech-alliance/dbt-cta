{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('charges_base') }}
select
    _airbyte_charges_hashid,
    {{ json_extract_scalar('refunds', ['url'], ['url']) }} as url,
    {{ json_extract_array('refunds', ['data'], ['data']) }} as data,
    {{ json_extract_scalar('refunds', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('refunds', ['has_more'], ['has_more']) }} as has_more,
    {{ json_extract_scalar('refunds', ['total_count'], ['total_count']) }} as total_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_base') }} as table_alias
-- refunds at charges_base/refunds
where 1 = 1
and refunds is not null
{{ incremental_clause('_airbyte_emitted_at') }}

