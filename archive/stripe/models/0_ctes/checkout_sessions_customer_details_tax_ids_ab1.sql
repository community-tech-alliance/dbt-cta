{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('checkout_sessions_customer_details_base') }}
{{ unnest_cte(ref('checkout_sessions_customer_details_base'), 'customer_details', 'tax_ids') }}
select
    _airbyte_customer_details_hashid,
    {{ json_extract_scalar(unnested_column_value('tax_ids'), ['type'], ['type']) }} as type,
    {{ json_extract_scalar(unnested_column_value('tax_ids'), ['value'], ['value']) }} as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_customer_details_base') }}
-- tax_ids at checkout_sessions_base/customer_details/tax_ids
{{ cross_join_unnest('customer_details', 'tax_ids') }}
where
    1 = 1
    and tax_ids is not null
{{ incremental_clause('_airbyte_emitted_at') }}

