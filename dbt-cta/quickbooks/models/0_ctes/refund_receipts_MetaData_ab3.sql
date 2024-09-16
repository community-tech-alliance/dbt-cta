{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('refund_receipts_MetaData_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_refund_receipts_hashid',
        'CreateTime',
        'LastUpdatedTime',
    ]) }} as _airbyte_MetaData_hashid,
    tmp.*
from {{ ref('refund_receipts_MetaData_ab2') }} as tmp
-- MetaData at refund_receipts/MetaData
where 1 = 1
