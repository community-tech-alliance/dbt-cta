{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_total_details_breakdown_taxes_rate_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_taxes_hashid',
        'id',
        'state',
        boolean_to_string('active'),
        'object',
        'country',
        'created',
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        'tax_type',
        boolean_to_string('inclusive'),
        'percentage',
        'description',
        'display_name',
        'jurisdiction',
    ]) }} as _airbyte_rate_hashid,
    tmp.*
from {{ ref('checkout_sessions_total_details_breakdown_taxes_rate_ab2') }} as tmp
-- rate at checkout_sessions_base/total_details/breakdown/taxes/rate
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

