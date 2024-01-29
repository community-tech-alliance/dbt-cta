{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('refund_receipts_CustomField_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_refund_receipts_hashid',
        'Type',
        'DefinitionId',
        'Name',
    ]) }} as _airbyte_CustomField_hashid,
    tmp.*
from {{ ref('refund_receipts_CustomField_ab2') }} tmp
-- CustomField at refund_receipts/CustomField
where 1 = 1

