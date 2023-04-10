{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('external_account_cards_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'brand',
        'last4',
        'object',
        'account',
        'country',
        'funding',
        'exp_year',
        object_to_string('metadata'),
        'cvc_check',
        'exp_month',
        'redaction',
        'address_zip',
        'fingerprint',
        'address_city',
        'address_line1',
        'address_line2',
        'address_state',
        'dynamic_last4',
        'address_country',
        'address_zip_check',
        'address_line1_check',
        'tokenization_method',
    ]) }} as _airbyte_external_account_cards_hashid,
    tmp.*
from {{ ref('external_account_cards_ab2') }} tmp
-- external_account_cards
where 1 = 1

