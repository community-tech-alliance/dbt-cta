{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('plans_tiers_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_plans_hashid',
        'up_to',
        'flat_amount',
        'unit_amount',
    ]) }} as _airbyte_tiers_hashid,
    tmp.*
from {{ ref('plans_tiers_ab2') }} as tmp
-- tiers at plans_base/tiers
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

