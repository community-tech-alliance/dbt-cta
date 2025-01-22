{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('journal_entries_base') }}
select
    _airbyte_journal_entries_hashid,
    {{ json_extract_scalar('TaxRateRef', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('TaxRateRef', ['value'], ['value']) }} as value,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('journal_entries_base') }}
-- TaxRateRef at journal_entries/TaxRateRef
where
    1 = 1
    and TaxRateRef is not null
