{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('invoice_line_items_plan_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_invoice_line_items_hashid',
        'id',
        'name',
        array_to_string('tiers'),
        boolean_to_string('active'),
        'amount',
        'object',
        'created',
        'product',
        'updated',
        'currency',
        adapter.quote('interval'),
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        'nickname',
        'tiers_mode',
        'usage_type',
        'billing_scheme',
        'interval_count',
        'aggregate_usage',
        'transform_usage',
        'trial_period_days',
        'statement_descriptor',
        'statement_description',
    ]) }} as _airbyte_plan_hashid,
    tmp.*
from {{ ref('invoice_line_items_plan_ab2') }} as tmp
-- plan at invoice_line_items_base/plan
where 1 = 1
