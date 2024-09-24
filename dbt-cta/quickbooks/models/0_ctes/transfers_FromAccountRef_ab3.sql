{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('transfers_FromAccountRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_transfers_hashid',
        'name',
        'value',
    ]) }} as _airbyte_FromAccountRef_hashid,
    tmp.*
from {{ ref('transfers_FromAccountRef_ab2') }} as tmp
-- FromAccountRef at transfers/FromAccountRef
where 1 = 1
