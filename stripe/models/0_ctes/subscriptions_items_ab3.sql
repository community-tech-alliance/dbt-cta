{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('subscriptions_items_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_subscriptions_hashid',
        'url',
        array_to_string('data'),
        'object',
        boolean_to_string('has_more'),
        'total_count',
    ]) }} as _airbyte_items_hashid,
    tmp.*
from {{ ref('subscriptions_items_ab2') }} tmp
-- items at subscriptions_base/items
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

