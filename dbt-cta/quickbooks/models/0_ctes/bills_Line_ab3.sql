{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('bills_Line_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_bills_hashid',
        'LineNum',
        object_to_string('ItemBasedExpenseLineDetail'),
        'Description',
        object_to_string('AccountBasedExpenseLineDetail'),
        'DetailType',
        'Amount',
        'Id',
    ]) }} as _airbyte_Line_hashid,
    tmp.*
from {{ ref('bills_Line_ab2') }} as tmp
-- Line at bills/Line
where 1 = 1
