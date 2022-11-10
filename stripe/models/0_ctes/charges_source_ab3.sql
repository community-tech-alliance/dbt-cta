{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_source_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_charges_hashid',
        'id',
        object_to_string('eps'),
        object_to_string('card'),
        'flow',
        'name',
        'type',
        'brand',
        object_to_string('ideal'),
        'last4',
        object_to_string('owner'),
        'usage',
        object_to_string('alipay'),
        'amount',
        'object',
        'status',
        'country',
        'created',
        'funding',
        'currency',
        'customer',
        'exp_year',
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        object_to_string('receiver'),
        object_to_string('redirect'),
        'cvc_check',
        'exp_month',
        object_to_string('bancontact'),
        object_to_string('multibanco'),
        'address_zip',
        'fingerprint',
        'address_city',
        'address_line1',
        'address_line2',
        'address_state',
        'client_secret',
        'dynamic_last4',
        'address_country',
        'address_zip_check',
        object_to_string('ach_credit_transfer'),
        'address_line1_check',
        'tokenization_method',
        'statement_descriptor',
    ]) }} as _airbyte_source_hashid,
    tmp.*
from {{ ref('charges_source_ab2') }} tmp
-- source at charges_base/source
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

