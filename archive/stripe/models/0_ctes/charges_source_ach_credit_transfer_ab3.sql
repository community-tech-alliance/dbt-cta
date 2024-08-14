{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_source_ach_credit_transfer_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_source_hashid',
        'bank_name',
        'swift_code',
        'fingerprint',
        'account_number',
        'routing_number',
        'refund_account_number',
        'refund_routing_number',
        'refund_account_holder_name',
        'refund_account_holder_type',
    ]) }} as _airbyte_ach_credit_transfer_hashid,
    tmp.*
from {{ ref('charges_source_ach_credit_transfer_ab2') }} as tmp
-- ach_credit_transfer at charges_base/source/ach_credit_transfer
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

