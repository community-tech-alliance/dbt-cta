{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('customers') }}
{{ unnest_cte(ref('customers'), 'customers', 'cards') }}
select
    _airbyte_customers_hashid,
    {{ json_extract_scalar(unnested_column_value('cards'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('cards'), ['name'], ['name']) }} as name,
    {{ json_extract_scalar(unnested_column_value('cards'), ['type'], ['type']) }} as type,
    {{ json_extract_scalar(unnested_column_value('cards'), ['brand'], ['brand']) }} as brand,
    {{ json_extract_scalar(unnested_column_value('cards'), ['last4'], ['last4']) }} as last4,
    {{ json_extract_scalar(unnested_column_value('cards'), ['object'], ['object']) }} as object,
    {{ json_extract_scalar(unnested_column_value('cards'), ['country'], ['country']) }} as country,
    {{ json_extract_scalar(unnested_column_value('cards'), ['funding'], ['funding']) }} as funding,
    {{ json_extract_scalar(unnested_column_value('cards'), ['customer'], ['customer']) }} as customer,
    {{ json_extract_scalar(unnested_column_value('cards'), ['exp_year'], ['exp_year']) }} as exp_year,
    {{ json_extract('', unnested_column_value('cards'), ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar(unnested_column_value('cards'), ['cvc_check'], ['cvc_check']) }} as cvc_check,
    {{ json_extract_scalar(unnested_column_value('cards'), ['exp_month'], ['exp_month']) }} as exp_month,
    {{ json_extract_scalar(unnested_column_value('cards'), ['address_zip'], ['address_zip']) }} as address_zip,
    {{ json_extract_scalar(unnested_column_value('cards'), ['fingerprint'], ['fingerprint']) }} as fingerprint,
    {{ json_extract_scalar(unnested_column_value('cards'), ['address_city'], ['address_city']) }} as address_city,
    {{ json_extract_scalar(unnested_column_value('cards'), ['address_line1'], ['address_line1']) }} as address_line1,
    {{ json_extract_scalar(unnested_column_value('cards'), ['address_line2'], ['address_line2']) }} as address_line2,
    {{ json_extract_scalar(unnested_column_value('cards'), ['address_state'], ['address_state']) }} as address_state,
    {{ json_extract_scalar(unnested_column_value('cards'), ['dynamic_last4'], ['dynamic_last4']) }} as dynamic_last4,
    {{ json_extract_scalar(unnested_column_value('cards'), ['address_country'], ['address_country']) }} as address_country,
    {{ json_extract_scalar(unnested_column_value('cards'), ['address_zip_check'], ['address_zip_check']) }} as address_zip_check,
    {{ json_extract_scalar(unnested_column_value('cards'), ['address_line1_check'], ['address_line1_check']) }} as address_line1_check,
    {{ json_extract_scalar(unnested_column_value('cards'), ['tokenization_method'], ['tokenization_method']) }} as tokenization_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers') }} as table_alias
-- cards at customers/cards
{{ cross_join_unnest('customers', 'cards') }}
where 1 = 1
and cards is not null
{{ incremental_clause('_airbyte_emitted_at') }}

