{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('checkout_sessions') }}
select
    _airbyte_checkout_sessions_hashid,
    {{ json_extract_string_array('shipping_address_collection', ['allowed_countries'], ['allowed_countries']) }} as allowed_countries,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions') }} as table_alias
-- shipping_address_collection at checkout_sessions/shipping_address_collection
where 1 = 1
and shipping_address_collection is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

