{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('checkout_sessions_base') }}
select
    _airbyte_checkout_sessions_hashid,
    {{ json_extract_scalar('automatic_tax', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('automatic_tax', ['enabled'], ['enabled']) }} as enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_base') }} as table_alias
-- automatic_tax at checkout_sessions_base/automatic_tax
where 1 = 1
and automatic_tax is not null
{{ incremental_clause('_airbyte_emitted_at') }}

