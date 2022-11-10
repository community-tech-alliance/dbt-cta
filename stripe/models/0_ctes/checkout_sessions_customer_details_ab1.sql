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
    {{ json_extract_scalar('customer_details', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('customer_details', ['phone'], ['phone']) }} as phone,
    {{ json_extract_array('customer_details', ['tax_ids'], ['tax_ids']) }} as tax_ids,
    {{ json_extract_scalar('customer_details', ['tax_exempt'], ['tax_exempt']) }} as tax_exempt,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_base') }} as table_alias
-- customer_details at checkout_sessions_base/customer_details
where 1 = 1
and customer_details is not null
{{ incremental_clause('_airbyte_emitted_at') }}

