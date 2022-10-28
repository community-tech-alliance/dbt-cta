{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('charges') }}
select
    _airbyte_charges_hashid,
    {{ json_extract_scalar('outcome', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('outcome', ['reason'], ['reason']) }} as reason,
    {{ json_extract_scalar('outcome', ['risk_level'], ['risk_level']) }} as risk_level,
    {{ json_extract_scalar('outcome', ['risk_score'], ['risk_score']) }} as risk_score,
    {{ json_extract_scalar('outcome', ['network_status'], ['network_status']) }} as network_status,
    {{ json_extract_scalar('outcome', ['seller_message'], ['seller_message']) }} as seller_message,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges') }} as table_alias
-- outcome at charges/outcome
where 1 = 1
and outcome is not null
{{ incremental_clause('_airbyte_emitted_at') }}

