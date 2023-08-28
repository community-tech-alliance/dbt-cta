{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('balance_transactions_base') }}
{{ unnest_cte(ref('balance_transactions_base'), 'balance_transactions_base', 'fee_details') }}
select
    _airbyte_balance_transactions_hashid,
    {{ json_extract_scalar(unnested_column_value('fee_details'), ['type'], ['type']) }} as type,
    {{ json_extract_scalar(unnested_column_value('fee_details'), ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar(unnested_column_value('fee_details'), ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar(unnested_column_value('fee_details'), ['application'], ['application']) }} as application,
    {{ json_extract_scalar(unnested_column_value('fee_details'), ['description'], ['description']) }} as description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('balance_transactions_base') }}
-- fee_details at balance_transactions_base/fee_details
{{ cross_join_unnest('balance_transactions_base', 'fee_details') }}
where
    1 = 1
    and fee_details is not null
{{ incremental_clause('_airbyte_emitted_at') }}

