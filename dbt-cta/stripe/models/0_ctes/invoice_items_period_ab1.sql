{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('invoice_items_base') }}
select
    _airbyte_invoice_items_hashid,
    {{ json_extract_scalar('period', ['end'], ['end']) }} as {{ adapter.quote('end') }},
    {{ json_extract_scalar('period', ['start'], ['start']) }} as start,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('invoice_items_base') }} as table_alias
-- period at invoice_items_base/period
where 1 = 1
and period is not null
{{ incremental_clause('_airbyte_emitted_at') }}

