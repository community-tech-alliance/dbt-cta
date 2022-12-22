{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('invoice_line_items_period_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_invoice_line_items_hashid',
        adapter.quote('end'),
        'start',
    ]) }} as _airbyte_period_hashid,
    tmp.*
from {{ ref('invoice_line_items_period_ab2') }} tmp
-- period at invoice_line_items_base/period
where 1 = 1

