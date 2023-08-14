{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sales_receipts_CustomField_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_sales_receipts_hashid',
        'Type',
        'DefinitionId',
        'Name',
    ]) }} as _airbyte_CustomField_hashid,
    tmp.*
from {{ ref('sales_receipts_CustomField_ab2') }} tmp
-- CustomField at sales_receipts/CustomField
where 1 = 1

