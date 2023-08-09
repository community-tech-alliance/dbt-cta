{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('vendors_PrimaryPhone_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_vendors_hashid',
        'FreeFormNumber',
    ]) }} as _airbyte_PrimaryPhone_hashid,
    tmp.*
from {{ ref('vendors_PrimaryPhone_ab2') }} tmp
-- PrimaryPhone at vendors/PrimaryPhone
where 1 = 1

