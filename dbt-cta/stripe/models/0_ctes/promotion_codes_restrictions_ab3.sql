{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('promotion_codes_restrictions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_promotion_codes_hashid',
        'minimum_amount',
        boolean_to_string('first_time_transaction'),
        'minimum_amount_currency',
    ]) }} as _airbyte_restrictions_hashid,
    tmp.*
from {{ ref('promotion_codes_restrictions_ab2') }} tmp
-- restrictions at promotion_codes_base/restrictions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

