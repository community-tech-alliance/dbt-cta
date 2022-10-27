{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('customers') }}
select
    _airbyte_customers_hashid,
    {{ json_extract_scalar('invoice_settings', ['footer'], ['footer']) }} as footer,
    {{ json_extract_string_array('invoice_settings', ['custom_fields'], ['custom_fields']) }} as custom_fields,
    {{ json_extract_scalar('invoice_settings', ['default_payment_method'], ['default_payment_method']) }} as default_payment_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers') }} as table_alias
-- invoice_settings at customers/invoice_settings
where 1 = 1
and invoice_settings is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

