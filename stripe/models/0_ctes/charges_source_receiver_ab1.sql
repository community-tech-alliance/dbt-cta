{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('charges_source') }}
select
    _airbyte_source_hashid,
    {{ json_extract_scalar('receiver', ['address'], ['address']) }} as address,
    {{ json_extract_scalar('receiver', ['amount_charged'], ['amount_charged']) }} as amount_charged,
    {{ json_extract_scalar('receiver', ['amount_received'], ['amount_received']) }} as amount_received,
    {{ json_extract_scalar('receiver', ['amount_returned'], ['amount_returned']) }} as amount_returned,
    {{ json_extract_scalar('receiver', ['refund_attributes_method'], ['refund_attributes_method']) }} as refund_attributes_method,
    {{ json_extract_scalar('receiver', ['refund_attributes_status'], ['refund_attributes_status']) }} as refund_attributes_status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_source') }} as table_alias
-- receiver at charges/source/receiver
where 1 = 1
and receiver is not null
{{ incremental_clause('_airbyte_emitted_at') }}

