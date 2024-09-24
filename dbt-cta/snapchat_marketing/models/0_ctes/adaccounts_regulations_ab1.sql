{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('adaccounts_base') }}
select
    id as ad_account_id,
    {{ json_extract_scalar('regulations', ['restricted_delivery_signals'], ['restricted_delivery_signals']) }} as restricted_delivery_signals,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('adaccounts_base') }}
where
    1 = 1
    and regulations is not null
{{ incremental_clause('_airbyte_extracted_at') }}

