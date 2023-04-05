{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        array_to_string('cards'),
        'email',
        'phone',
        'object',
        object_to_string('address'),
        'balance',
        'created',
        'sources',
        'currency',
        object_to_string('discount'),
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        object_to_string('shipping'),
        'tax_info',
        boolean_to_string('delinquent'),
        'tax_exempt',
        'description',
        'default_card',
        object_to_string('subscriptions'),
        'default_source',
        'invoice_prefix',
        'account_balance',
        object_to_string('invoice_settings'),
        array_to_string('preferred_locales'),
        'next_invoice_sequence',
        'tax_info_verification',
    ]) }} as _airbyte_customers_hashid,
    tmp.*
from {{ ref('customers_ab2') }} tmp
-- customers
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

