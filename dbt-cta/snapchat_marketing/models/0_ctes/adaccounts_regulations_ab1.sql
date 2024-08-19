{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('adaccounts_base') }}
select
    id as ad_account_id,
    {{ json_extract_scalar('regulations', ['restricted_delivery_signals'], ['restricted_delivery_signals']) }} as restricted_delivery_signals,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('adaccounts_base') }} as table_alias
where 1 = 1
and regulations is not null
{{ incremental_clause('_airbyte_emitted_at') }}

