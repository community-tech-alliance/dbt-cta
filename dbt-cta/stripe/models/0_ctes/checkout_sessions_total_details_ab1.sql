{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('checkout_sessions_base') }}
select
    _airbyte_checkout_sessions_hashid,
    {{ json_extract('table_alias', 'total_details', ['breakdown'], ['breakdown']) }} as breakdown,
    {{ json_extract_scalar('total_details', ['amount_tax'], ['amount_tax']) }} as amount_tax,
    {{ json_extract_scalar('total_details', ['amount_discount'], ['amount_discount']) }} as amount_discount,
    {{ json_extract_scalar('total_details', ['amount_shipping'], ['amount_shipping']) }} as amount_shipping,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_base') }} as table_alias
-- total_details at checkout_sessions_base/total_details
where 1 = 1
and total_details is not null
{{ incremental_clause('_airbyte_emitted_at') }}

