{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('deposits_Line_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_deposits_hashid',
        'LineNum',
        object_to_string('DepositLineDetail'),
        'DetailType',
        'Amount',
        'Id',
        array_to_string('LinkedTxn'),
    ]) }} as _airbyte_Line_hashid,
    tmp.*
from {{ ref('deposits_Line_ab2') }} as tmp
-- Line at deposits/Line
where 1 = 1
