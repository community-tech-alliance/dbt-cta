{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('adaccounts_regulations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_adaccounts_hashid',
        boolean_to_string('restricted_delivery_signals'),
    ]) }} as _airbyte_regulations_hashid,
    tmp.*
from {{ ref('adaccounts_regulations_ab2') }} tmp
-- regulations at adaccounts/regulations
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

