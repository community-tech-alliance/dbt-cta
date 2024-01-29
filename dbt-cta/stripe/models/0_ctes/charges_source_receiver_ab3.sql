{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_source_receiver_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_source_hashid',
        'address',
        'amount_charged',
        'amount_received',
        'amount_returned',
        'refund_attributes_method',
        'refund_attributes_status',
    ]) }} as _airbyte_receiver_hashid,
    tmp.*
from {{ ref('charges_source_receiver_ab2') }} as tmp
-- receiver at charges_base/source/receiver
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

