{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_after_expiration_recovery_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_after_expiration_hashid',
        'url',
        boolean_to_string('enabled'),
        'expires_at',
        boolean_to_string('allow_promotion_codes'),
    ]) }} as _airbyte_recovery_hashid,
    tmp.*
from {{ ref('checkout_sessions_after_expiration_recovery_ab2') }} as tmp
-- recovery at checkout_sessions_base/after_expiration/recovery
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

