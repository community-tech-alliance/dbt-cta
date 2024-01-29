{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('vendor_credits_APAccountRef_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_vendor_credits_hashid',
        'name',
        'value',
    ]) }} as _airbyte_APAccountRef_hashid,
    tmp.*
from {{ ref('vendor_credits_APAccountRef_ab2') }} tmp
-- APAccountRef at vendor_credits/APAccountRef
where 1 = 1

