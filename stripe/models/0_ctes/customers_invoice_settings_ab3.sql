{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_invoice_settings_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_customers_hashid',
        'footer',
        array_to_string('custom_fields'),
        'default_payment_method',
    ]) }} as _airbyte_invoice_settings_hashid,
    tmp.*
from {{ ref('customers_invoice_settings_ab2') }} tmp
-- invoice_settings at customers/invoice_settings
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

