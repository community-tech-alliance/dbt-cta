{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('customers_base') }}
select
    _airbyte_customers_hashid,
    {{ json_extract_scalar('shipping', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('shipping', ['phone'], ['phone']) }} as phone,
    {{ json_extract('table_alias', 'shipping', ['address'], ['address']) }} as address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_base') }} as table_alias
-- shipping at customers_base/shipping
where 1 = 1
and shipping is not null
{{ incremental_clause('_airbyte_emitted_at') }}

