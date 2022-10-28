{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('disputes') }}
{{ unnest_cte(ref('disputes'), 'disputes', 'balance_transactions') }}
select
    _airbyte_disputes_hashid,
    {{ json_extract_scalar(unnested_column_value('balance_transactions'), ['id'], ['id']) }} as id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('disputes') }} as table_alias
-- balance_transactions at disputes/balance_transactions
{{ cross_join_unnest('disputes', 'balance_transactions') }}
where 1 = 1
and balance_transactions is not null
{{ incremental_clause('_airbyte_emitted_at') }}

