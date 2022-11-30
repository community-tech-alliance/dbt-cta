{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('customers') }}
{{ unnest_cte(ref('customers'), 'customers', 'cards') }}
select
    _airbyte_customers_hashid,
    {{ json_extract_scalar(unnested_column_value('cards'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('cards'), ['last_4'], ['last_4']) }} as last_4,
    {{ json_extract_scalar(unnested_column_value('cards'), ['exp_year'], ['exp_year']) }} as exp_year,
    {{ json_extract_scalar(unnested_column_value('cards'), ['exp_month'], ['exp_month']) }} as exp_month,
    {{ json_extract_scalar(unnested_column_value('cards'), ['card_brand'], ['card_brand']) }} as card_brand,
    {{ json_extract('', unnested_column_value('cards'), ['billing_address'], ['billing_address']) }} as billing_address,
    {{ json_extract_scalar(unnested_column_value('cards'), ['cardholder_name'], ['cardholder_name']) }} as cardholder_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_base') }} as table_alias
-- cards at customers/cards
{{ cross_join_unnest('customers', 'cards') }}
where 1 = 1
and cards is not null

