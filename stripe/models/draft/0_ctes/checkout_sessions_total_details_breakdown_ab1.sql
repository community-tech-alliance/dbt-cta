{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('checkout_sessions_total_details') }}
select
    _airbyte_total_details_hashid,
    {{ json_extract_array('breakdown', ['taxes'], ['taxes']) }} as taxes,
    {{ json_extract_array('breakdown', ['discounts'], ['discounts']) }} as discounts,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_total_details') }} as table_alias
-- breakdown at checkout_sessions/total_details/breakdown
where 1 = 1
and breakdown is not null
{{ incremental_clause('_airbyte_emitted_at') }}

