{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('invoices_base') }}
{{ unnest_cte(ref('invoices_base'), 'invoices', 'CustomField') }}
select
    _airbyte_invoices_hashid,
    {{ json_extract_scalar(unnested_column_value('CustomField'), ['Type'], ['Type']) }} as Type,
    {{ json_extract_scalar(unnested_column_value('CustomField'), ['DefinitionId'], ['DefinitionId']) }} as DefinitionId,
    {{ json_extract_scalar(unnested_column_value('CustomField'), ['StringValue'], ['StringValue']) }} as StringValue,
    {{ json_extract_scalar(unnested_column_value('CustomField'), ['Name'], ['Name']) }} as Name,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('invoices_base') }}
-- CustomField at invoices/CustomField
{{ cross_join_unnest('invoices', 'CustomField') }}
where
    1 = 1
    and CustomField is not null
