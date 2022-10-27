{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('subscriptions') }}
select
    _airbyte_subscriptions_hashid,
    {{ json_extract_scalar('discount', ['end'], ['end']) }} as {{ adapter.quote('end') }},
    {{ json_extract('table_alias', 'discount', ['coupon'], ['coupon']) }} as coupon,
    {{ json_extract_scalar('discount', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('discount', ['customer'], ['customer']) }} as customer,
    {{ json_extract_scalar('discount', ['start_date'], ['start_date']) }} as start_date,
    {{ json_extract_scalar('discount', ['subscription'], ['subscription']) }} as subscription,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('subscriptions') }} as table_alias
-- discount at subscriptions/discount
where 1 = 1
and discount is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

