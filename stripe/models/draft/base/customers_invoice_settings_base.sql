{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('customers_invoice_settings_ab3') }}
select
    _airbyte_customers_hashid,
    footer,
    custom_fields,
    default_payment_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_invoice_settings_hashid
from {{ ref('customers_invoice_settings_ab3') }}
-- invoice_settings at customers/invoice_settings from {{ ref('customers') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

